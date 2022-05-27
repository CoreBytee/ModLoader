print("Hello World!")
local Information = TypeWriter.Logger.Info
TypeWriter.Logger.RegisterLogFile(TypeWriter.ExeFolder .. "/JavaRuntime.log")

TypeWriter.Logger.Info(table.concat(TypeWriter.Arguments, " "))


Import("ga.CubicInc.SMP.JavaRuntime.Runtime.Spoof")()

Import("ga.CubicInc.SMP.JavaRuntime.Helpers.HideWindow")()

Import("ga.CubicInc.SMP.JavaRuntime.Helpers.ModSyncer"):new():Sync()
Import("ga.CubicInc.SMP.JavaRuntime.Runtime.StartGame")()