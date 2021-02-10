
coroutine.wrap(function()
Wait = require("timer").sleep
local ModCats = require("./Categories.lua")

print("░██████╗███████╗████████╗██╗░░░██╗██████╗░")
print("██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗")
print("╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝")
print("░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░")
print("██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░")
print("╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░")

print("Dit is een makkelijk process, het duurt niet lang!")

print()

Wait(1500)

print("INFO:")
print("GAME VERSION: 1.16.5")
print("MOD CATEGORIES:")

for i, v in pairs(ModCats) do
    print("     Name: " .. v.Name)
    print("     Description: " .. v.Description)
    print("     Game Version: " .. v.GameVersion)
    print("     Folder Name: " .. v.FolderName)
    print()
end



end)()