TypeWriter.Runtime.LoadFile(Import("ga.CubicInc.SMP.JavaRuntime.Locations.GameFolder") .. "/CubicLoader/BrowserView-Bootstrap.twr")
local Window = Import("ga.corebyte.BrowserView.Wrapper").Download().LoadAll().NewWindow(
    {
        Options = {
            frame = false
        }
    }
)
Window:Start()
Window:SetSize(500, 200)
Window:SetAlwaysOnTop(true)
Window:SetSkipTaskbar(true)
Window:Center()
Window:SetMovable(false)
Window:SetResizable(false)
Window:SetClosable(false)
_G.Window = Window
--[[
    Window:LoadFile(
        "C:/Users/Thijmen/Documents/Github/Self/ModLoader/.TypeWriter/Build/Index.html",
        {
            query = {
                display = string.format(
                    "%s/%s | %s",
                    tostring(Complete),
                    tostring(ActionCount),
                    tostring(Per),
                ),
                desc = D
            }
        }
    )
]]

function ResetWindow(Display, Desc, Buttons)
    Window:LoadFile(
        "C:/Users/Thijmen/Documents/Github/Self/ModLoader/.TypeWriter/Build/Index.html",
        {
            query = {
                display = Display,
                desc = Desc,
                buttons = Buttons or false
            }
        }
    )
end
ResetWindow("Preparing", "Game should start soon")
