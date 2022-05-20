local Locations = {}
local LOS = require("los")
local OS = LOS.type()

function Locations.ParentPath()
    local Paths = {
        ["win32"] = _G.Process.env.APPDATA,
        ["darwin"] = "~/Library/Application Support/"
    }

    return Paths[OS]
end

function Locations.MinecraftPath()
    local MinecraftNames = {
        ["win32"] = ".minecraft",
        ["darwin"] = "minecraft"
    }
    return Locations.ParentPath() .. (MinecraftNames[OS])
end

function Locations.CustomPath()
    return Locations.ParentPath(OS) .. ("\\.cubiccraft\\")
end

function Locations.ProfilesFile()
    
end

return Locations