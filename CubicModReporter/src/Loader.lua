local Json = require("json")
local Request = require("coro-http").request
local FS = require("fs")
local Path = require("path")

p(args)
require("timer").sleep(3000)
if not args[1] then
    local Spawn = require("coro-spawn")
    Spawn(
        args[0],
        {
            args = {
                "detached"
            },
            detached = true,
            hide = true,
            cwd = Path.resolve(args[0], "./")
        }
    )
    process:exit()
end

local function IsLocalServer()
    local Success = pcall(function ()
        Request("GET", "http://localhost:8080")
    end)
    return Success
end
local Domains = {
    [true] = "http://localhost:8080",
    [false] = ""
}
local Domain = Domains[IsLocalServer()]

Request("GET", Domain .. "/start/?username=" .. FS.readFileSync("./PlayerName.txt") .. "&start=" .. FS.readFileSync("./IsStart.txt"))

local Report = {}
do
    Report.PlayerName = FS.readFileSync("./PlayerName.txt")
    Report.ResourcePacks = require("./Methods/ResourcePacks")()
    Report.Mods = require("./Methods/Mods")()
end


print(Json.encode(Report, {indent = true}))


if IsLocalServer() then
    Request(
        "POST",
        Domain .. "/report/",
        {},
        Json.encode(Report)
    )
else

end

FS.writeFileSync("Hashes.json", Json.encode(Report, {indent = true}))