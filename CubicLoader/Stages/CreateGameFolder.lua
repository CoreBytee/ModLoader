local Locations = require("Locations")
local FS = require("fs")

return {
    Name = "Create Game folder",
    F = function ()
        
        FS.mkdirSync(Locations.CustomPath())

    end
}