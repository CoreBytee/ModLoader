local Functions = {
    ["win32"] = function (Msg)
        local Result = require("coro-spawn")(
            "powershell",
            {
                args = {
                    "-executionpolicy", "unrestricted",
                    "-command",
                    "Add-Type -AssemblyName PresentationFramework; [system.windows.messagebox]::Show('" .. Msg .. "')"
                }
            }
        )
        Result.waitExit()
        TypeWriter.Logger.Info(Result.stdout.read())
        TypeWriter.Logger.Info(Result.stderr.read())

    end,
    ["darwin"] = function (Msg)
        os.execute('osascript -e \'tell app "Finder" to display dialog "' .. Msg .. '"\' ')
    end
}

return Functions[TypeWriter.Os]