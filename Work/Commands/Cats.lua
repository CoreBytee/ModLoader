return function(Args)

    local ModCats = require("./Categories.lua")

    print("MOD CATEGORIES:")

    for i, v in pairs(ModCats) do
        print("     Name: " .. v.Name)
        print("     Description: " .. v.Description)
        print("     Game Version: " .. v.GameVersion)
        print("     Folder Name: " .. v.FolderName)
        print()
    end

end