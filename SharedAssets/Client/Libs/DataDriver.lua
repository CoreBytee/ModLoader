local DataDriverModule = {}

-- OS Part

DataDriverModule.OS = {}

function DataDriverModule.OS.Get()
    return OS
end

function DataDriverModule.OS.Set(OS)
    _G.OS = OS

    local OperatingData = Json.decode(Readfile("./Data/OperatingData.json"))

    OperatingData.OS = OS

    Writefile("./Data/OperatingData.json", Json.encode(OperatingData))
end

function DataDriverModule.OS.Start()
    local OperatingData = Json.decode(Readfile("./Data/OperatingData.json"))

    OperatingData.FirstLaunch = false
    OperatingData.LaunchCount = OperatingData.LaunchCount + 1

    Writefile("./Data/OperatingData.json", Json.encode(OperatingData))
end

-- PATHs part

DataDriverModule.Paths = {}

function DataDriverModule.Paths.GetMinecraft()

    local Paths = require("../Configuration/Paths")

    if OS == "MAC" then
        return Paths.MAC
    else
        return Paths.WINDOWS
    end

end

-- Mods Part

DataDriverModule.Mods = {}

function DataDriverModule.Mods.GetModInformation(Path)

    

end

function DataDriverModule.Mods.GetAllMods()

    

end

return DataDriverModule