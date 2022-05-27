local FolderNames = {
    ["win32"] = ".minecraft",
    ["darwin"] = "minecraft"
}

return Import("ga.CubicInc.SMP.Installer.Locations.AppData") .. string.format(
    "/%s/",
    FolderNames[TypeWriter.Os]
)