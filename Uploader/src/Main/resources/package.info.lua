-- See https://github.com/Dot-lua/TypeWriter/wiki/package.info.lua-format for more info

return { InfoVersion = 1, -- Dont touch this

    ID = "Uploader", -- A unique id 
    Name = "Uploader",
    Description = "Uploader",
    Version = "1.0.0",

    Author = {
        Developers = {
            "CoreByte"
        },
        Contributors = {}
    },

    Dependencies = {
        Luvit = {
            "creationix/coro-fs",
            "creationix/sha1"
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
        Main = "ga.cubic-inc.smp.uploader",
    }

}
