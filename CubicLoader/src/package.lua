return {
    name = "CubicLoader",
    version = "1.0.0",
    description = "A mod loader for mc",
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
        "creationix/coro-spawn"
    },
    files = {
      "**.lua",
      "!test*"
    }
}
  