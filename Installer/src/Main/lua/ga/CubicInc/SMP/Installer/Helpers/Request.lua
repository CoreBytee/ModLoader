local Json = require("json")

local Request = require("coro-http").request
local function JsonRequest(Method, Url, Headers, Body)
    local Response, Body = Request(Method, Url, Headers, Body)
    return Response, Json.decode(Body)
end

return {
    JsonRequest = JsonRequest,
    Request = Request,
}