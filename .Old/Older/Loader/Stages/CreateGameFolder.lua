return {
    Name = "Create Game folder",
    F = function ()
        
        FS.mkdirSync(Locations.CustomPath())

        FS.mkdirSync(Locations.CustomPath() .. "/mods")
        FS.mkdirSync(Locations.CustomPath() .. "/resourcepacks")

        local Add = {
            {
                Name = "options.txt",
                Url = "https://github.com/CoreBytee/ModLoader/raw/main/Data/GameFolder/options.txt"
            },

            {
                Name = "servers.dat",
                Url = "https://github.com/CoreBytee/ModLoader/raw/main/Data/GameFolder/servers.dat"
            }
        }

        for Index, File in pairs(Add) do
            local Response, Data = Request("GET", File.Url)
            p(Locations.CustomPath() .. "/" .. File.Name)
            FS.writeFileSync(Locations.CustomPath() .. "/" .. File.Name, Data)
        end



    end
}