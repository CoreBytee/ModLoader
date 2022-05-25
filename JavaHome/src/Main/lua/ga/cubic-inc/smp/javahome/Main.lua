local FS = require("fs")

FS.writeFileSync(TypeWriter.ExeFolder .. "/JavaHome.txt", Import("ga.cubic-inc.smp.javahome.Find")())
p(TypeWriter.ExeFolder)