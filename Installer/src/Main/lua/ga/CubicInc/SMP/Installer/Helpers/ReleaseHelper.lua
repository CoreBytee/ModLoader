local JsonRequest = Import("ga.CubicInc.SMP.Installer.Helpers.Request").JsonRequest

return function ()
    local _, VersionData = JsonRequest(
        "GET",
        string.format(
            "https://api.github.com/repos/%s/releases?per_page=5",
            "CoreBytee/ModLoader"
        ),
        { 
            {
                "User-Agent",
                "ModLoader"
            }
        }
    )
    return (VersionData[1].tag_name)
end