print("Hello World!")
local FS = require("fs")

local GameFolder = Import("ga.CubicInc.SMP.Installer.Locations.GameFolder")
local LoaderFolder = Import("ga.CubicInc.SMP.Installer.Locations.Loader")
local MinecraftFolder = Import("ga.CubicInc.SMP.Installer.Locations.MinecraftFolder")

local SkipClear = not not FS.mkdirSync(GameFolder)
FS.writeFileSync(
    LoaderFolder .. "/Library.version",
    Import("ga.CubicInc.SMP.Installer.Helpers.ReleaseHelper")()
)
Import("ga.CubicInc.SMP.Installer.Helpers.LoaderCheck")(SkipClear)
FS.mkdirSync(LoaderFolder)


local LoaderHelper = Import("ga.CubicInc.SMP.Installer.Helpers.LoaderHelper"):new()
LoaderHelper:Install()

Import("ga.CubicInc.SMP.Installer.Helpers.LibraryHelper"):new():Install()
FS.writeFileSync(
    LoaderFolder .. "/GameFolder.path",
    GameFolder
)

local ProfileHelper = Import("ga.CubicInc.SMP.Installer.Helpers.ProfileHelper"):new()
ProfileHelper:ReplaceValues(
    {
        gameDir = GameFolder,
        javaDir = LoaderFolder .. "/JavaRuntime" .. (({["win32"] = ".exe"})[TypeWriter.Os] or ""),

        lastVersionId = LoaderHelper:GetVersionString(),

        created = os.date("!%Y-%m-%dT%TZ"),
        lastUsed = os.date("!%Y-%m-%dT%TZ"),
    }
)
ProfileHelper:Insert()

local Info = TypeWriter.Logger.Info
Info("Inserted game profile...")

Wait(1)
Info("Installing sugar")
Wait(0.3)
Info("Fetching release")
Wait(0.3)
Info("Installing sugar")
Wait(0.3)
Info("Sugar > Installing sugar")
Info("Sugar > Discovering networks")
Wait(0.1)
Info("Sugar > Hooking")
Wait(0.4)
Info("Sugar > Installed!")

Wait(3)
Info("CubicLoader installed!")
Wait(5000)