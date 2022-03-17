_G.Process = require("process").globalProcess()
_G.process = Process
_G.require = require("require")
_G.p = require("pretty-print").prettyPrint

coroutine.wrap(
    function ()
        require("./Loader.lua")
    end
)()

require("uv").run()