local FS = require("fs")
local LoaderLocation = Import("ga.CubicInc.SMP.Installer.Locations.Loader")
local GameFolder = Import("ga.CubicInc.SMP.Installer.Locations.GameFolder")
local Rmrf = require("coro-fs").rmrf
local Spawn = require("coro-spawn")	

return function (SkipClear)
    if SkipClear then
        return
    end
    TypeWriter.Logger.Warn("Clearing game folder...")
    Wait(0)
    local Exclude = {
        ["CubicLoader"] = false,
        ["saves"] = true
    }
    for Index, FileName in pairs(FS.readdirSync(GameFolder)) do
        if not Exclude[FileName] then
            TypeWriter.Logger.Info("Removing " .. GameFolder .. "/" .. FileName)
            if not Rmrf(GameFolder .. FileName) then
                TypeWriter.Logger.Error("Failed to remove " .. GameFolder .. "/" .. FileName)
                FS.unlinkSync(GameFolder .. FileName)
                TypeWriter.Logger.Info("")
            end
        end
    end
end