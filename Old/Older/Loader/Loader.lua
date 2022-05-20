print("hello")

FS.mkdirSync("./CubicLoader")


local Stages = {
    require("./Stages/CreateGameFolder.lua"),
    require("./Stages/DownloadFo.lua"),
    require("./Stages/PatchResources.lua"),
    require("./Stages/DownloadFabric.lua"),


    require("./Stages/CreateLauncherProfile.lua"),

}

p("Starting Stages")

for Index, Stage in pairs(Stages) do
    p("Starting Stage " .. Stage.Name)
    Stage.F()
    p("Done")
end