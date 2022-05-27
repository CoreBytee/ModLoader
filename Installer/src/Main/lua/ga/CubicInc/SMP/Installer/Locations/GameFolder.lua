local FolderNames = {
    ["win32"] = ".CubicCraft",
    ["darwin"] = "CubicCraft"
}

return Import("ga.CubicInc.SMP.Installer.Locations.AppData") .. string.format(
    "/%s/",
    FolderNames[TypeWriter.Os]
)