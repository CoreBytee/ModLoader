return function(App)

    App.route(
        {path = "/modifications/mods", method = "GET"},
        function(Request, Response, Go)

            Response.body = Redirect("/modifications/mods/all")
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

    App.route(
        {path = "/modifications/mods/:state", method = "GET"},
        function(Request, Response, Go)

            Response.body = Readfile("./Work/Pages/Modifications/Mods/All.html")
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

end