return {
    Name = "Create Game folder",
    F = function ()
        
        local FabricResponse, FabricData = JsonRequest("GET", "https://meta.fabricmc.net/v2/versions/installer")
        --p(FabricData)

        local StableVersion
        for Index, Version in pairs(FabricData) do
            if Version.stable == true then
                StableVersion = Version
                break
            end
        end

        local InstallerResponse, InstallerData = Request("GET", StableVersion.url)

        FS.writeFileSync("./CubicLoader/FabricInstaller.jar", InstallerData)

        p(os.execute('java -jar ./CubicLoader/FabricInstaller.jar client -mcversion 1.18.1 -loader 0.12.12'))

    end
}