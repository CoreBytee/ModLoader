local Json = require("json")
local FS = require("fs")
local Folders = require("Folders")
local Bundle = require("luvi").bundle

return {
    Name = "Create Profile",
    Function = function ()
        local Profile = Json.decode(Bundle.readfile("ProfileArtifact.json")).CubicCraft
        Profile.gameDir = Folders.GetCustomFolder()

        local Profiles = Json.decode(FS.readFileSync(Folders.GetProfilesFile()))
        Profiles.profiles.CubicCraft = Profile

        print(FS.writeFileSync(Folders.GetProfilesFile(), Json.encode(Profiles, {indent = true})))
        print("Create Profile > Created Profile!")

    end
}