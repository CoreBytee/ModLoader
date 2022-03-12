local Sleep = require("timer").sleep

local function PrintBar(Percent, Name, Stage, Length)
    local LoadedLength = math.floor((Length / 100) * Percent)
    local Bar = ""

    for Index = 1, Length do
        if Index <= LoadedLength then
            Bar = Bar .. "#"
        else
            Bar = Bar .. "-"
        end
    end

    _G.process.stdout.handle:write(
        string.format(
            "\r%s: [%s](%s%%)(%s)                  ",
            Name,
            string.format("\27[%im", 36) .. Bar .. "\27[0m",
            math.floor(Percent),
            Stage
        )
    )

    if Percent >= 100 then
        _G.process.stdout.handle:write("\n")
    end
end

local function GetHeader(HeaderName, Headers)
    for Index, Header in ipairs(Headers) do
        if Header[1] == HeaderName then
            return Header[2]
        end
    end
end

local function AdvancedRequest(Url)
    local ParsedUrl = require("http").parseUrl(Url)
    local Finished = false
    local Request

    local Response
    local Body = ""

    local function Callback(CurrentResponse)
        Response = CurrentResponse
        local ContentLength = tonumber(GetHeader("Content-Length", Response.headers) or 0)
        CurrentResponse:on(
            "data",
            function (Data)
                Body = Body .. Data
                Response:resume()
            end
        )
        coroutine.wrap(function ()
            while Finished == false do
                PrintBar(#Body / ContentLength * 100, "Downloading mods", "", 100)
                Sleep(3000)
            end
        end)()
        
        CurrentResponse:on(
            "end",
            function ()
                print()
                Finished = true
            end
        )
    end

    if string.sub(Url, 1, 5) == "https" then
        Request = require("https").get(ParsedUrl, Callback)
    else
        Request = require("http").get(ParsedUrl, Callback)
    end

    repeat
        Sleep(50)
    until Finished == true
    if Response.statusCode == 302 or Response.statusCode == 301 then
        print("AdvancedRequest > Redirected")
        return AdvancedRequest(Response.headers.Location)
    end

    return Response, Body
end

AdvancedRequest("http://mods.corebyte.ga")