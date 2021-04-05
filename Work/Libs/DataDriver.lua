local DataDriverModule = {}

-- OS Part

DataDriverModule.OS = {}

function DataDriverModule.OS.Get()
    return OS
end

function DataDriverModule.OS.Set(OS)
    _G.OS = OS
end

-- PATHs part

function DataDriverModule.Paths.GetMinecraft()

    local Paths = require("../Configuration/Paths")

    if OS == "MAC" then
        return Paths.MAC
    else
        return Paths.WINDOWS
    end

end

-- Mods Part

function DataDriverModule.Mods.GetModInformation(Path)

    

end

function DataDriverModule.Mods.GetAllMods()

    

end

return DataDriverModule