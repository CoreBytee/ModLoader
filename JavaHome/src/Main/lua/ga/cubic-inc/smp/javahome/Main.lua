local FS = require("fs")

FS.writeFileSync(
    TypeWriter.ExeFolder .. "/JavaHome.txt",
    Import("ga.cubic-inc.smp.javahome.Find")() .. "/bin/java" .. (({["win32"] = ".exe"})[TypeWriter.Os] or "")
)