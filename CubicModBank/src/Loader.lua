local App = require("weblit-app")

local Webhook = require("Webhook"):new(require("json").decode(require("fs").readFileSync("./Webhooks.json")).Main)

App.bind(
    {
        host = "0.0.0.0",
        port = 8080
    }
)

App.use(require('weblit-logger'))
App.use(require('weblit-auto-headers'))

App.route(
    {
        method = "GET",
        path = "/"
    },
    function (Request, Response)
        Response.body = "Pong"
        Response.code = 200
    end
)

App.route(
    {
        method = "POST",
        path = "/report/"
    },
    function (Request, Response)
        p(Request.body)
    end
)

App.start()