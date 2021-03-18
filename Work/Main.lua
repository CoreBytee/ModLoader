
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

MinePath = "%appdata%/.minecraft"

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
--[[
while true do

    if RenewCursor == true then
        Write("> ")
        io.flush()
        RenewCursor = false
        
    end

    local GottenCommandData = Read("*a")
    print(GottenCommandData)

    if GottenCommandData then
        print()
        print(GottenCommandData)

        Commands[GottenCommandData].Function()

        RenewCursor = true
    end


end]]


function AskYesNo(Text)
    local Answer
    repeat
        io.write(Text .. " (y/n) " or "nil ")
        io.flush()
        Answer=string.lower(io.read())
    until Answer == "y" or Answer == "n"

    return Answer == "y"
end

_G.AskYesNo = AskYesNo

local TheQuests = {

    require("./Commands/TempCommands/AskYes.lua"),
    --require("./Commands/TempCommands/AskBackup.lua"),
    require("./Commands/TempCommands/AskFabric.lua"),
    require("./Commands/TempCommands/AskHasFabric.lua"),

}

for i, v in pairs(TheQuests) do
    v()
end

end)()