local Spawn = require("coro-spawn")

local Functions = {
    ["win32"] = function ()
        --TypeWriter.Logger.Info(
        --    require("json").encode(
        --        {
        --            os.execute(
        --                'powershell -executionpolicy unrestricted -command "echo "hi"; `$PPID=' .. process.pid .. '; ' .. require("path").resolve(TypeWriter.ExeFolder .. '/HideWindow.ps1') .. '"'
        --            )
        --        },
        --        {
        --            indent = true
        --        }
        --    )
        --)
        --TypeWriter.Logger.Info('powershell -executionpolicy unrestricted -command "$PPID=' .. process.pid .. '; ' .. TypeWriter.ExeFolder .. '/HideWindow.ps1"')
        local Result = Spawn(
            "powershell.exe",
            {
                args = {
                    "-executionpolicy",
                    "unrestricted",
                    "-command",
                    '$PPID=' .. TypeWriter.Pid .. '; ' .. require("path").resolve(TypeWriter.ExeFolder .. '/HideWindow.ps1')
                }
            }
        )
        TypeWriter.Logger.Info(
            table.concat(
                {
                    "powershell.exe",
                    "-executionpolicy",
                    "unrestricted",
                    "-command",
                    '$PPID=' .. TypeWriter.Pid .. '; ' .. require("path").resolve(TypeWriter.ExeFolder .. '/HideWindow.ps1')
                },
                " "
            )
        )
        Result.waitExit()
        TypeWriter.Logger.Info(Result.stdout.read())
        TypeWriter.Logger.Info(Result.stderr.read())
        TypeWriter.Logger.Info(TypeWriter.Pid)
    end,
    ["darwin"] = function ()
        
    end
}

return Functions[TypeWriter.Os]