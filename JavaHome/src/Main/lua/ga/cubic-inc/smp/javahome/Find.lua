local Spawn = require("coro-spawn")

local Commands = {
    ["win32"] = {
        Exe = "cmd.exe",
        Args = {
            "/c", "echo %JAVA_HOME%"
        }
    }
}

return function ()
    local Command = Commands[TypeWriter.Os]
    local Result, Error = Spawn(
        Command.Exe,
        {
            args = Command.Args,
            cwd = "/",
            verbatim = true,
            detached = true,
            hide = true
        }
    )
    Result.waitExit()
    local Out = Result.stdout:read()
    return table.concat(
        string.split(
            require("path").resolve(
                table.concat(
                    string.split(
                        Out,
                        "\r\n"
                    )
                ) .. "/bin/javaw" .. (({["win32"] = ".exe"})[TypeWriter.Os] or "")
            ),
            "\\"
        ), "/"
    )
end