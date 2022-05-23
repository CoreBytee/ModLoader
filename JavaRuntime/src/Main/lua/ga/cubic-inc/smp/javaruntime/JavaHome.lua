local FS = require("fs")

return function ()
    return FS.readFileSync(TypeWriter.ExeFolder .. "/JavaHome.txt")
end