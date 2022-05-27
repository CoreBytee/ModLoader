local FS = require("fs")

local File = Import("ga.cubic-inc.smp.javahome.Find")() .. "/bin/java" .. (({["win32"] = ".exe"})[TypeWriter.Os] or "")

FS.writeFileSync(
    TypeWriter.ExeFolder .. "/JavaHome.txt",
    File
)

local Spawn = require("coro-spawn")

local Result = Spawn(
    File,
    {
        args = {
            "-version"
        }
    }
)
Result.waitExit()
local Version = Result.stderr.read():split("\n")[1]:split("\"")[2]

if Version:sub(0, 2) ~= "17" then
    print("false")
    return
end

print("true")