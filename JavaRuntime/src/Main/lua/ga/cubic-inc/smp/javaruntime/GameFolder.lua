local FS = require("fs")

return function ()
    return FS.readFileSync(TypeWriter.ExeFolder .. "/GameFolder.path")
end