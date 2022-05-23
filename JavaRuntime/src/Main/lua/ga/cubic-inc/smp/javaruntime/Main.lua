print("Hello World!")
local FS = require("fs")
local Json = require("json")
local Spawn = require("coro-spawn")
local JavaHome = Import("ga.cubic-inc.smp.javaruntime.JavaHome")()

function Log(Text)
    require("fs").appendFileSync(
        "C:/Users/Thijmen/Documents/Github/Self/ModLoader/Java.log",
        require("json").encode(
            Text,
            {
                indent = true
            }
        ) .. "\n"
    )
end

Log(TypeWriter.Arguments)

if string.find(TypeWriter.Arguments[2], "JavaCheck.jar") then
    print("java.version=17.0.1")
    Log("Spoofing")
    process:exit()
end

local Github = Import("ga.cubic-inc.smp.javaruntime.Github"):new("CoreBytee", "Modloader", "main", "Meta/GameFolder"):FetchTree()

local Result, Error = Spawn(
    JavaHome,
    {
        stdio = {
            process.stdin.handle,
            process.stdout.handle,
            process.stderr.handle
        },
        args = TypeWriter.Arguments,
    }
)
Result.waitExit()