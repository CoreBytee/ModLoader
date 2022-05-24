return {
    name = "CubicModReporter",
    version = "1.0.0",
    description = "Client side anti cheat",
    tags = {},
    license = "MIT",
    author = { name = "CoreByte" },
    dependencies = {
        "luvit/process",
        "luvit/require",
        "luvit/fs",
        "luvit/json",
        "luvit/pretty-print",
        "luvit/los",
        "luvit/secure-socket",
        "luvit/path",

        "creationix/coro-http",
        "creationix/coro-fs",
        "creationix/coro-spawn",
        "creationix/sha1"
    },
    files = {
      "**.lua",
      "!test*"
    }
}
