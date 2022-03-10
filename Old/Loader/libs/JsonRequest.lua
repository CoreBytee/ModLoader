return function (Method, Url, Headers, Body)
    local Response, Body = Request(Method, Url, Headers, Body)

    return Response, Json.decode(Body)
end