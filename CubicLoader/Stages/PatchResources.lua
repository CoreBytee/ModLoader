return {
    Name = "PatchResources",
    F = function ()
        FS.mkdirSync("./CubicLoader/Resources/")
        FS.mkdirSync("./CubicLoader/Resources/Raw/")

        local Link, Tag = require("GetLatestLink")()

        local Response, Data = Request("GET", Link)

        FS.writeFileSync("./CubicLoader/Resources/Raw.zip", Data)

        require("Unzip")("./CubicLoader/Resources/Raw.zip", "./CubicLoader/Resources/Raw/")
    end
}