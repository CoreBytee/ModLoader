local FS = require("fs")
local CFS = require("coro-fs")
local Folders = require("Folders")

return {
    Name = "Create Loader Folder",
    Function = function ()
        if FS.existsSync("./.CubicLoader/") then
            print("Create Folders > Removing old loader folder")
            CFS.rmrf("./.CubicLoader/")
        end
        FS.mkdirSync("./.CubicLoader/")
        
        if FS.existsSync(Folders.GetCustomFolder()) then
            print("Create Folders > Removing old folder")
            CFS.rmrf(Folders.GetCustomFolder())
        end

        print("Create Folders > Creating game folder")
        FS.mkdirSync(Folders.GetCustomFolder())
    end
}