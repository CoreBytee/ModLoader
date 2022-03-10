local FS = require("fs")

FS.mkdirSync("./CubicLoader")


local Stages = {
    require("./Stages/CreateGameFolder.lua"),
    require("./Stages/PatchLauncher.lua"),
}

p("Starting Stages")

for Index, Stage in pairs(Stages) do
    p("Starting Stage " .. Stage.Name)
    Stage.F()
    p("Done")
end