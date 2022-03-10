_G.Process = require("process").globalProcess()
_G.process = Process
_G.require = require("require")
_G.p = require("pretty-print").prettyPrint

_G.Json = require("json")
_G.Timer = require("timer")

_G.Request = require("coro-http").request
_G.JsonRequest = require("JsonRequest")

coroutine.wrap(
    function ()
        require("./Loader.lua")
    end
)()

require("uv").run()