local Spawn = require("coro-spawn") 
local JavaHome = Import("ga.CubicInc.SMP.JavaRuntime.Locations.JavaHome")

return function ()
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
end