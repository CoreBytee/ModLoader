local Json = require("json")
local Request = require("coro-http").request
local FS = require("fs")

local Report = {}
do
    Report.PlayerName = FS.readFileSync("./PlayerName.txt")
    Report.ResourcePacks = require("./Methods/ResourcePacks")()
    Report.Mods = require("./Methods/Mods")()
end


p(Report)
print(Json.encode(Report, {indent = true}))

local function IsLocalServer()
    local Success = pcall(function ()
        Request("GET", "http://localhost:8080")
    end)
    return Success
end
if IsLocalServer() then
    Request(
        "POST",
        "http://localhost:8080/report/",
        {},
        Json.encode(Report)
    )
else

end

FS.writeFileSync("Hashes.json", Json.encode(Report, {indent = true}))