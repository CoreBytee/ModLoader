local ProfileHelper = Object:extend()

local JsonRequest = Import('ga.CubicInc.SMP.Installer.Helpers.Request').JsonRequest
local Json = require('json')
local FS = require("fs")

function ProfileHelper:initialize()
    local _, Profile = JsonRequest(
        "GET",
        "https://raw.githubusercontent.com/CoreBytee/ModLoader/main/Meta/Profile.json"
    )
    self.Profile = Profile
end

function ProfileHelper:ReplaceValues(Values)
    for Index, Value in pairs(Values) do
        self.Profile[Index] = Value
    end
end

function ProfileHelper:Insert()
    local ProfilesFile = Import("ga.CubicInc.SMP.Installer.Locations.MinecraftFolder") .. "/launcher_profiles.json"

    local ProfileData = Json.decode(
        FS.readFileSync(
            ProfilesFile
        )
    )
    ProfileData.profiles["CubicLoader"] = self.Profile

    TypeWriter.Logger.Info(FS.writeFileSync(
        ProfilesFile,
        Json.encode(
            ProfileData,
            {
                indent = true
            }
        )
    ))
end

return ProfileHelper