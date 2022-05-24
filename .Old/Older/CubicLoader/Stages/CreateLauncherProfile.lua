return {
    Name = "Create Game folder",
    F = function ()
        
        local ProfileResponse, ProfilePreset = JsonRequest("GET", "https://github.com/CoreBytee/ModLoader/raw/main/Data/ProfileArtifact.json")
        --p(ProfilePreset)

        local ProfileData = Json.decode(FS.readFileSync(Locations.MinecraftPath() .. "launcher_profiles.json"))
        --p(ProfileData)

        for Index, Profile in pairs(ProfilePreset) do
            Profile.gameDir = Locations.CustomPath()
            ProfileData.profiles[Index] = Profile
        end

        FS.writeFileSync(Locations.MinecraftPath() .. "launcher_profiles.json", Json.encode(ProfileData, {indent = true}))

    end
}