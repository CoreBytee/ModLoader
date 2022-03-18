local Spawn = require("coro-spawn")
local Path = require("path")
local Split = require("Split")
local Json = require("json")
local Folders = require("Folders")
local Sha = require("sha1")
local FS = require("fs")
local Sleep = require("timer").sleep

local ModsFolder = Folders:GetCustomFolder() .. "/mods/"

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

    local Success, ModInfo = pcall(function ()
        return Json.decode(
            table.concat(
                Split(
                    Result.stdout.read(),
                    "\n"
                ),
                ""
            )
        )
    end)

    if Success then
        return ModInfo
    else
        return nil
    end
    
end

local Ignore = {
    [".DS_Store"] = true
}

return function ()
    local ModsReport = {}
    ModsReport.Hashes = {}
    ModsReport.Folders = {}
    ModsReport.FolderFound = false

    local HashedCount = 0
    local Count = #FS.readdirSync(ModsFolder)

    for Index, FileName in pairs(FS.readdirSync(ModsFolder)) do
        if not Ignore[FileName] then
            coroutine.wrap(function ()
                print("Hashing file " .. FileName)
                local FileType = FS.statSync(ModsFolder .. "/" .. FileName).type
                if FileType == "file" then
                    local ModInfo = GetModInfo(ModsFolder .. "/" .. FileName)
                    ModsReport.Hashes[Sha(FS.readFileSync(ModsFolder .. "/" .. FileName))] = {
                        Name = FileName,
                        ModInfo = {
                            Id =    (ModInfo or {}).id,
                            Name =  (ModInfo or {}).name
                        }
                    }
                else
                    ModsReport.FolderFound = true
                    ModsReport.Folders[FileName] = true
                end
                HashedCount = HashedCount + 1
                print("Hashed " .. FileName .. " (" .. HashedCount .. "/" .. Count .. ")")
            end)()
        else
            HashedCount = HashedCount + 1
        end
        
    end

    repeat
        Sleep(500)
    until HashedCount == Count


    return ModsReport
end