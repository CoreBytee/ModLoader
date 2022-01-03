local Locations = {}
local LOS = require("los")

function Locations.ParentPath(OS)
    local Paths = {
        ["win32"] = _G.Process.env.APPDATA,
        ["darwin"] = "~/Library/Application Support/"
    }

    return Paths[OS or LOS.type()]
end

function Locations.MinecraftPath(OS)
    return Locations.ParentPath(OS) .. ("\\.minecraft\\")
end

function Locations.CustomPath(OS)
    return Locations.ParentPath(OS) .. ("\\.cubiccraft\\")
end

return Locations