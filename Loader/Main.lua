_G.UV = require("uv")
_G.Process = require("process").globalProcess()
_G.require = require("require")
_G.p = require("pretty-print").prettyPrint
_G.FS = require("fs")

_G.Json = require("json")
_G.Timer = require("timer")

_G.Locations = require("Locations")

_G.Request = require("coro-http").request
_G.JsonRequest = require("JsonRequest")

coroutine.wrap(
    function ()
        require("./Loader.lua")
    end
)()

UV.run()