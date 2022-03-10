local Spawn = require("coro-spawn")

return function (Path, Dest)
    if OS == "debian" then
        local Result, Error = Spawn(
            "unzip",
            {
                args = {
                    Path
                },
                cwd = Dest,
                stdio = {true, true, true},
                hide = true
            }
        )

        Result.waitExit()

    elseif OS == "win32" then
        p(require("path").resolve(Path))
        p(Path)
        local Result, Error = Spawn(
            "tar",
            {
                args = {
                    "-xf",
                    require("path").resolve(Path)
                },
                stdio = {true, true, true},
                cwd = require("path").resolve(Dest),
                hide = true
            }
        )

        p(Error)
        Result.waitExit()
        p(Result.stdout.read())
        
    end
end