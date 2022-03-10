return {
    Name = "Create Game folder",
    F = function ()
        
        FS.mkdirSync(Locations.CustomPath())

        FS.mkdirSync(Locations.CustomPath() .. "/mods")
        FS.mkdirSync(Locations.CustomPath() .. "/resourcespacks")

        

    end
}