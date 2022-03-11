local OS = require("los").type()
local Spawn = require("coro-spawn")
local Path = require("path")
local FS = require("fs")

local Functions = {
    ["win32"] = function (From, To)
        FS.mkdirSync(To)
        local Result, Error = Spawn(
            "tar",
            {
                args = {
                    "-xf", Path.resolve(From),
                    "-C", Path.resolve(To)
                }
            }
        )
        Result.waitExit()

    end,
    ["darwin"] = function (From, To)
        FS.mkdirSync(To)
        local Result, Error = Spawn(
            "unzip",
            {
                args = {
                    From
                },
                cwd = To,
                stdio = {true, true, true},
                hide = true
            }
        )
        Result.waitExit()
    end
}

return function (From, To)
    return Functions[OS](From, To)
end