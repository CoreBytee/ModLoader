return function (Method, Url, Headers, Settings)
    local Response, Body = require("coro-http").request(Method, Url, Headers, Settings)
    return Response, require("json").decode(Body)
end