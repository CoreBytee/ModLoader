-- See https://github.com/Dot-lua/TypeWriter/wiki/package.info.lua-format for more info

return { InfoVersion = 1, -- Dont touch this

    ID = "JavaRuntime", -- A unique id 
    Name = "JavaRuntime",
    Description = "JavaRuntime for my smp",
    Version = "1.0.0",

    Author = {
        Developers = {
            "CoreByte"
        },
        Contributors = {}
    },

    Dependencies = {
        Luvit = {
            "creationix/coro-spawn"
        },
        Git = {},
        Dua = {}
    },

    Contact = {
        Website = "",
        Source = "",
        Socials = {}
    },

    Entrypoints = {
        Main = "ga.cubic-inc.smp.javaruntime"
    }

}
