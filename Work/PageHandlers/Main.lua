return function(App)

    App.route(
        {path = "/home", method = "GET"},
        function(Request, Response, Go)

            Response.body = Readfile("./Work/Pages/Home.html")
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

end