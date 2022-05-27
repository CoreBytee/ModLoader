print("Hello World!")
local Information = TypeWriter.Logger.Info
TypeWriter.Logger.RegisterLogFile(TypeWriter.ExeFolder .. "/JavaRuntime.log")

TypeWriter.Logger.Info(table.concat(TypeWriter.Arguments, " "))


Import("ga.CubicInc.SMP.JavaRuntime.Runtime.Spoof")()

Import("ga.CubicInc.SMP.JavaRuntime.Helpers.HideWindow")()

if Import("ga.CubicInc.SMP.JavaRuntime.Helpers.ReleaseHelper")() ~= require("fs").readFileSync(TypeWriter.ExeFolder .. "/Library.version") then
    Import("ga.CubicInc.SMP.JavaRuntime.Helpers.Popup")("Please update your modloader!")
    process:exit()
end

Import("ga.CubicInc.SMP.JavaRuntime.Helpers.ModSyncer"):new():Sync()
Import("ga.CubicInc.SMP.JavaRuntime.Runtime.StartGame")()