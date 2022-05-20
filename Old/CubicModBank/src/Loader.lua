local App = require("weblit-app")
local Json = require("json")
local FS = require("fs")

local Webhook = require("Webhook"):new(require("json").decode(require("fs").readFileSync("./Webhooks.json")).Main)
local DefaultHashes = Json.decode(FS.readFileSync("./Hashes.json"))
p(DefaultHashes)

App.bind(
    {
        host = "0.0.0.0",
        port = 8080
    }
)

App.use(require('weblit-logger'))
App.use(require('weblit-auto-headers'))

App.route(
    {
        method = "GET",
        path = "/"
    },
    function (Request, Response)
        Response.body = "Pong"
        Response.code = 200
    end
)

local function Count(Table)
    local C = 0
    for Index, Value in pairs(Table) do
        C = C + 1
    end
    return C
end

App.route(
    {
        method = "POST",
        path = "/report/"
    },
    function (Request, Response)
        if not Request.body then return end

        local ReportOk = true
        local ReceivedHashes = Json.decode(Request.body)

        local Fields = {}
        local UnknownModsField = {
            name = "Unknown mods",
            value = "",
            inline = true
        }
        table.insert(Fields, UnknownModsField)
        table.insert(
            Fields,
            {
                name = "Statistics",
                value = Count(ReceivedHashes.Mods.Hashes) .. "/" .. Count(DefaultHashes.Mods.Hashes) .. " mods in folder\n" .. 
                Count(ReceivedHashes.ResourcePacks.FileHashes) .. "/" .. Count(DefaultHashes.ResourcePacks.FileHashes) .. " resource packs in folder",
                inline = true
            }
        )
        

        for Hash, HashData in pairs(ReceivedHashes.Mods.Hashes) do
            if not DefaultHashes.Mods.Hashes[Hash] then
                ReportOk = false
                UnknownModsField.value = UnknownModsField.value .. "+ " .. HashData.Name .. "\n"
            end
        end

        local Content = "Received hash report from **" .. ReceivedHashes.PlayerName .. "**"

        local Color = 0x5afc03
        if ReportOk == false then
            Content = "<@533536581055938580>" .. Content
            Color = 0xfc0303
        end
        if #UnknownModsField.value == 0 then
            UnknownModsField.value = "n/a"
        end

        Webhook:Send(
            {
                content = Content,
                embeds = {
                    {
                        title = "Report data",
                        color = Color,
                        fields = {unpack(Fields)}
                    }
                }
                
            }
        )

        p(#ReceivedHashes.Mods.Hashes)

    end
)

App.route(
    {
        method = "GET",
        path = "/start/"
    },
    function (Request, Response)
        if not Request.query then return end
        if not Request.query.username then return end
        local Types = {
            ["true"] = "starting",
            ["false"] = "reloading"
        }
        Webhook:Send(
            {
                content = "Player **" .. Request.query.username .. "** is " .. (Types[Request.query.start] or "nil") .. " his game\nHash report coming soon"
            }
        )
    end
)

App.start()