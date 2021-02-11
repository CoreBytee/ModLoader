
coroutine.wrap(function()
Wait = require("timer").sleep


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
print("Type: 'help'")

Read = io.read

local Commands = {

    Cats = {
        Name = "Cats",
        Desc = "Verkrijg alle mod categoriën",
        Function = require("./Commands/Cats.lua")
    },
    
    Version = {
        Name = "Cats",
        Desc = "Krijg de game versie van alle mods",
        Function = require("./Commands/Cats.lua")
    },

}

while true do

    print("Enter Command > ")

    local GottenCommandData = Read()

    Commands[GottenCommandData].Function()

end




end)()