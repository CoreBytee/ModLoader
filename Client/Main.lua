
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



Read = io.read
Write = io.write

_G.GetLib = function(Name)
    return require("../SharedAssets/Client/Libs/" .. Name .. ".lua")
end

_G.GetModule = function(Name)
    return require("../SharedAssets/Client/Modules/" .. Name .. ".lua")
end

_G.GetPageHandler = function(Name)
    return require("../Client/PageHandlers/" .. Name .. ".lua")
end

_G.DataDriver = GetLib("DataDriver")
_G.FS = require("fs")

_G.Json = require("json")

MinePath = "%appdata%/.minecraft"

local Modules = {

    DFU = {

        Name = "DFU",
        Function = GetModule("DataFixerUpper")

    },

    Web = {

        Name = "Web",
        Function = GetModule("Web")

    }

}

for i, v in pairs(Modules) do
    v.Function()
end

print("trying to open safari")
local _, _, MacNumber = os.execute("open -a Safari http://localhost:8080")

IsMac = MacNumber == 0

print("trying to open Edge")
os.execute("start microsoft-edge:http://localhost:8080")

print()
print("OS FOUND")

if IsMac then
    
    print("█▀▄▀█ ▄▀█ █▀▀ █▀█ █▀")
    print("█░▀░█ █▀█ █▄▄ █▄█ ▄█")



else

    print("█░█░█ █ █▄░█ █▀▄ █▀█ █░█░█ █▀")
    print("▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀ ▄█")

end

print()

end)()