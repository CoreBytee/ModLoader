return function(App)

    App.route(
        {path = "/", method = "GET"},
        function(Request, Response, Go)

            local LoginData = Json.decode(Readfile("./Data/LoginData.json"))

            print("Logged in as " .. tostring(LoginData.name))

            if LoginData.name then
                Response.body = Redirect("/home")
            else
                Response.body = Redirect("/login")
            end

            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

    App.route(
        {path = "/login", method = "GET"},
        function(Request, Response, Go)

            Response.body = Readfile("./Work/Pages/Login.html")
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

    App.route(
        {path = "/login_form", method = "GET"},
        function(Request, Response, Go)

            print("New User " .. Request.query.username)

            local LoginData = Json.decode(Readfile("./Data/LoginData.json"))

            LoginData.name = Request.query.username

            Writefile("./Data/LoginData.json", Json.encode(LoginData))

            Response.body = Redirect("/home")
            Response.code = 200
            Response.headers["Content-Type"] = "text/html"

        end
    )

end