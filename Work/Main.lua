
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

--Wait(1500)

print("INFO:")
print("Type: 'help'")

Read = io.read
Write = io.write

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

RenewCursor = true

while true do

    if RenewCursor == true then
        Write("> ")
        RenewCursor = false
        
    end

    local GottenCommandData = Read("*a")


    if GottenCommandData then
        print()
        print(GottenCommandData)

        Commands[GottenCommandData].Function()

        RenewCursor = true
    end


end




end)()