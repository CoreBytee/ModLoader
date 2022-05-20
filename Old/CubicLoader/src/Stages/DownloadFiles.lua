local FS = require("fs")
local Request = require("coro-http").request
local Sleep = require("timer").sleep
local Folders = require("Folders")

return {
    Name = "Download Files",
    Function = function ()
        
        print("Download Files > Downloading files, This may take a while.")
        local Response, Body = Request("GET", "http://mods.corebyte.ga")
        print("Download Files > Writing data")
        FS.writeFileSync("./.CubicLoader/mods.zip", Body)
        print("Download Files > Done writing")

    end
}