print("hello")

FS.mkdirSync("./CubicLoader")


local Stages = {
    require("./Stages/DownloadFo.lua")
}

p("Starting Stages")

for Index, Stage in pairs(Stages) do
    p("Starting Stage " .. Stage.Name)
    Stage.F()
    p("Done")
end