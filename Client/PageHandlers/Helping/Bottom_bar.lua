return function(App)

    App.route(
        {path = "/helping/bottom_bar", method = "GET"},
        function(Request, Response, Go)

            Response.body = Readfile(GetWebPage("Helping/Bottom_bar.html"))
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

end