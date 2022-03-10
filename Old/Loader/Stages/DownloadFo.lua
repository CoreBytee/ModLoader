return {
    Name = "Download Fabulously Optimized",
    F = function ()
        local ModsResponse, Mods = JsonRequest("GET", "https://raw.githubusercontent.com/Fabulously-Optimized/fabulously-optimized/main/Modrinth/modrinth.index.json")

        local Ignore = {
            "slight-gui-modifications",
            "antighost",
            "borderless-mining",
            "Capes",
            "fabrishot",
            "language-reload",
            "WI-Zoom"
        }

        print("Starting Download")
        local Downloaded = 0

        function CheckIgnore(Name)
            local Is = true

            for Index, IgnoredName in pairs(Ignore) do
                if Name:match("mods/" .. IgnoredName .. "*") then
                    Is = false
                    break
                end
            end

            return Is
        end

        for Index, Mod in pairs(Mods.files) do
            coroutine.wrap(function ()
                p()
                p(Mod.path)
                if CheckIgnore(Mod.path) then
                    p(true)
                    local Response, File = Request("GET", Mod.downloads[1])
                    FS.writeFileSync("./CubicLoader/" .. Mod.path, File)
                else
                    p(false)
                end
                Downloaded = Downloaded + 1
            end)()
        end

        repeat
            Timer.sleep(20)
        until Downloaded == #Mods.files

        p("Downloaded Mods")
    end
}