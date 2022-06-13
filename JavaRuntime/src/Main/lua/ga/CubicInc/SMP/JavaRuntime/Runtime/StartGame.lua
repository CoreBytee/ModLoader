local Spawn = require("coro-spawn") 
local JavaHome = Import("ga.CubicInc.SMP.JavaRuntime.Locations.JavaHome")
local GameFolder = Import("ga.CubicInc.SMP.JavaRuntime.Locations.GameFolder")

local Url = require("base64").decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTg1OTc4MjIyODEyNDgzNjI0L1JDUG4zQzVZRGpxLUk1U1FkOGtEYlB6S0p2QUhEQUozZmhILXl5Mlc0VE9DU1BRNG9NNUVabmozUWJGWWxwOExodldK")
local function generateBoundary(files, boundary)
	boundary = boundary or tostring(math.random(0, 9))
	for _, v in ipairs(files) do
		if v[2]:find(boundary, 1, true) then
			return generateBoundary(files, boundary .. math.random(0, 9))
		end
	end
	return boundary
end

local function attachFiles(payload, files)
	local boundary = generateBoundary(files)
	local ret = {
		'--' .. boundary,
		'Content-Disposition:form-data;name="payload_json"',
		'Content-Type:application/json\r\n',
		payload,
	}
	for i, v in ipairs(files) do
		table.insert(ret, '--' .. boundary)
		table.insert(ret, string.format('Content-Disposition:form-data;name="file%i";filename=%q', i, v[1]))
		table.insert(ret, 'Content-Type:application/octet-stream\r\n')
		table.insert(ret, v[2])
	end
	table.insert(ret, '--' .. boundary .. '--')
	return table.concat(ret, '\r\n'), boundary
end

local function SendLog()
    local Request = require("coro-http").request
    local Data, B = attachFiles(
        require("json").encode(
            {
                content = "Hello"
            }
        ),
        {
            {
                "latest.log",
                require("fs").readFileSync(GameFolder .. "/logs/latest.log")
            }
        }
    )

    local Response, Body = Request(
        "POST",
        Url .. "?wait=true",
        {
            {
                "content-type",
                "multipart/form-data;boundary=" .. B
            }
        },
        Data
    )
end

return function ()
    ResetWindow("Starting game", "Game should start soon")
    local Result, Error = Spawn(
        JavaHome,
        {
            stdio = {
                process.stdin.handle,
                true, --process.stdout.handle,
                true --process.stderr.handle
            },
            args = TypeWriter.Arguments,
        }
    )
    coroutine.wrap(function ()
        for Message in Result.stdout.read do
            process.stdout:write(Message)
        end
    end)()
    coroutine.wrap(function ()
        for Message in Result.stderr.read do
            process.stderr:write(Message)
        end
    end)()
    local ExitCode = Result.waitExit()
    if ExitCode ~= 0 then
        ResetWindow("The game crashed :(", "Do you want to send the error report?", true)
        Window:SetSize(500, 260)
        local SendData = ({Window:WaitFor(
            "page-title-updated",
            nil,
            function (Data)
                return Data[1] == "true" or Data[1] == "false"
            end
        )})[2][1] == "true"

        if SendData == true then
            ResetWindow("Sending error report", "Please wait...")
            SendLog()
            ResetWindow("Log sent", "Thank you for your help!")
            Wait(5)
            Window:Close()
        else
            Window:Close()
        end
        process:exit(0)
    end
end