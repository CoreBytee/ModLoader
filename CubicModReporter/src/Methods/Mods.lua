local Spawn = require("coro-spawn")
local Path = require("path")
local Split = require("Split")
local Json = require("json")

local function GetModInfo(ModPath)
    local Result = Spawn(
        "tar",
        {
            args = {
                "-xOzf",
                Path.resolve(ModPath),
                "fabric.mod.json"
            }
        }
    )
    Result.waitExit()

    return Json.decode(
        table.concat(
            Split(
                Result.stdout.read(),
                "\n"
            ),
            ""
        )
    )
end

return function ()
    local ModsReport = {}
    local ModsReport.Hashes = {}

    for FileName, FileType in FS.scandirSync()

    p(GetModInfo("/Users/thijmenkorenromp/Documents/Github/Self/ModLoader/indium-1.0.2+mc1.18.2.jar"))

    return ModsReport
end