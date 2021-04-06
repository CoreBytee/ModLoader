return function()


    local App = require('weblit-app')
    local pathJoin = require('luvi').path.join
    local Static = require("weblit-static")

    local Pages = {

        Login = GetPageHandler("Login"),
        Main = GetPageHandler("Main"),
        ModList = GetPageHandler("ModList"),

    } 

    _G.Readfile = require("fs").readFileSync
    _G.Writefile = require("fs").writeFileSync


    _G.Redirect = function(URL)
        return "<meta http-equiv=\"refresh\" content=\"0; URL=" .. URL .. "\" />"
    end

    _G.GetWebPage = function(Name)
        return "./SharedAssets/Client/Web/Pages/" .. Name
    end

    App.bind({
        host = "0.0.0.0",
        port = 8080
    })

    App.use(require('weblit-auto-headers'))
    App.use(require('weblit-etag-cache'))
    App.route({method = "GET", path = "/static/:path:"}, Static("./SharedAssets/Shared/Web/Static"))
    
    print("Starting website pages")

    for i, v in pairs(Pages) do
        print("Starting " .. i)
        v(App)
        print("Done starting " .. i)
    end

    App.start()

    print("Website started!")

    


end