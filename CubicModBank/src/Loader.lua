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
        if not Request.body then return end
        local ReceivedHashes = Json.decode(Request.body)

    end
)

App.route(
    {
        method = "GET",
        path = "/start/"
    },
    function (Request, Response)
        if not Request.query then return end
        if not Request.query.username then return end
        Webhook:Send(
            {
                content = "Player **" .. Request.query.username .. "** is starting his game\nHash report coming soon"
            }
        )
        p(Request.body)
    end
)

App.start()