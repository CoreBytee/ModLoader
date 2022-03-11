local Unzip = require("Unzip")
local FS = require("fs")
local Folders = require("Folders")

return {
    Name = "Patch Files",
    Function = function ()
        
        print("Patch Files > Unzipping")
        Unzip("./.CubicLoader/mods.zip", "./.CubicLoader/mods/")

        for Index, FileName in pairs(FS.readdirSync("./.CubicLoader/mods/Minecraft Map")) do
            print("Patch Files > Moving " .. FileName)
            FS.renameSync("./.CubicLoader/mods/Minecraft Map/" .. FileName, Folders.GetCustomFolder() .. FileName)
        end

    end
}