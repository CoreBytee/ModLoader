local Webhook = require("core").Object:extend()

local Request = require("coro-http").request
local Json = require("json")

function Webhook:initialize(Url)
    self.Url = Url
end

function Webhook:Send(Data)
    local Response, Body = Request(
        "POST",
        self.Url .. "?wait=true",
        {
            {
                "Content-Type",
                "application/json"
            }
        },
        Json.encode(Data)
    )
    return Json.decode(Body)
end

return Webhook