local Locations = {}
local OS = require("los").type()
local Path = require("path")

function Locations.GetAppdata()
    local Folders = {
        ["win32"] = Process.env.APPDATA,
        ["darwin"] = "/Users/" .. (Process.env.USER or "") .. "/Library/Application Support/"
    }

    return Folders[OS]
end

function Locations.GetGameFolder()
    local Folders = {
        ["win32"] = "/.minecraft/",
        ["darwin"] = "/minecraft/"
    }

    return Locations.GetAppdata() .. Folders[OS]
end

function Locations.GetCustomFolder()
    local Folders = {
        ["win32"] = "/.CubicCraft/",
        ["darwin"] = "/CubicCraft/"
    }

    return Locations.GetAppdata() .. Folders[OS]
end

function Locations.GetProfilesFile()
    return Locations.GetGameFolder() .. "/launcher_profiles.json"
end

return Locations