
--[[
local function AdvancedRequest(Url)
    local ParsedUrl = require("http").parseUrl(Url)
    local Response
    local Data
    local function Callback (ReturnData)
        Data = ReturnData
        p(Data)
    end
    if string.sub(Url, 1, 5) == "https" then
        Response = require("https").get(ParsedUrl, function () end)
    else
        Response = require("http").get(ParsedUrl, function () end)
    end

    Response:once("finish", Callback)
    Response.socket:on("data", function (A)
        print(A)
    end)
    repeat
        require("timer").sleep(50)
    until Done
    p(Data.headers["Content-Length"])
    
    if Data.statusCode == 302 or Data.statusCode == 301 then
        print("Advanced Request > Redirected")
        return AdvancedRequest(Data.headers.Location)
    end
    p(1)
    return Data
end
]]

local Sleep = require("timer").sleep

local function AdvancedRequest(Url)
    local ParsedUrl = require("http").parseUrl(Url)
    local Finished = false
    local Request

    local Response

    local function Callback(CurrentResponse)
        Response = CurrentResponse
        p(CurrentResponse)
        CurrentResponse:on("data", print)
    end

    if string.sub(Url, 1, 5) == "https" then
        Request = require("https").get(ParsedUrl, Callback)
    else
        Request = require("http").get(ParsedUrl, Callback)
    end

    Request:on("finish", function ()
        coroutine.wrap(function ()
            repeat
                Sleep(50)
            until Response
            Finished = true
        end)()
    end)


    repeat
        Sleep(50)
    until Finished == true
    if Response.statusCode == 302 or Response.statusCode == 301 then
        print("AdvancedRequest > Redirected")
        AdvancedRequest(Response.headers.Location)
    end
end

AdvancedRequest("http://mods.corebyte.ga")
