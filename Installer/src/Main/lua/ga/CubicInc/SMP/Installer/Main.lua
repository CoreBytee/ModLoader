print("Hello World!")
local FS = require("fs")

local GameFolder = Import("ga.CubicInc.SMP.Installer.Locations.GameFolder")
local LoaderFolder = Import("ga.CubicInc.SMP.Installer.Locations.Loader")
local MinecraftFolder = Import("ga.CubicInc.SMP.Installer.Locations.MinecraftFolder")

local SkipClear = not FS.mkdirSync(GameFolder)
require("coro-fs").rmrf(LoaderFolder)
FS.mkdirSync(LoaderFolder)
FS.writeFileSync(
    LoaderFolder .. "/Library.version",
    Import("ga.CubicInc.SMP.Installer.Helpers.ReleaseHelper")()
)


Import("ga.CubicInc.SMP.Installer.Helpers.LoaderCheck")(SkipClear)
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

