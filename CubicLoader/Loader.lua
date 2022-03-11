print("Loading Cubic Loader...")

print("Loading Stage Manager")

local Stages = {
    require("./Stages/CreateFolders.lua"),
    require("./Stages/DownloadFiles.lua"),
    require("./Stages/PatchFiles.lua"),
    require("./Stages/CreateProfile.lua")
}

for Index, Stage in pairs(Stages) do
    print("Stage Manager > Starting Stage '" .. Stage.Name .. "'")
    Stage.Function()
    print("")
end