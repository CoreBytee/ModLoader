local FS = require("fs")
local LoaderLocation = Import("ga.CubicInc.SMP.Installer.Locations.Loader")
local GameFolder = Import("ga.CubicInc.SMP.Installer.Locations.GameFolder")
local Rmrf = require("coro-fs").rmrf
local Spawn = require("coro-spawn")	

return function (SkipClear)
    if not FS.existsSync(LoaderLocation .. "/Loader.version") then
        local SetVersion = 0
        if SkipClear then
            SetVersion = 1
        end
        FS.writeFileSync(LoaderLocation .. "/Loader.version", tostring(SetVersion))
    end
    local Version = tonumber(FS.readFileSync(LoaderLocation .. "/Loader.version"))

    if Version ~= 1 then
        TypeWriter.Logger.Warn("REMOVING OLD DATA IN 10 SECONDS")
        TypeWriter.Logger.Warn("CTRL/CMD + C TO EXIT!")
        Wait(10)
        local Exclude = {
            ["CubicLoader"] = true,
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
end