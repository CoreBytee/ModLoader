local Spawn = require("coro-spawn")

local Functions = {
    ["win32"] = function ()
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
        Result.waitExit()
        TypeWriter.Logger.Info(TypeWriter.Pid)
    end,
    ["darwin"] = function ()
        
    end
}

return Functions[TypeWriter.Os]