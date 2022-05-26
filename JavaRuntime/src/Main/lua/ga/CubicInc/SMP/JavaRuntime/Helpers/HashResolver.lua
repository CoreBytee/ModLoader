local HashResolver = Object:extend()

local JsonRequest = Import("ga.CubicInc.SMP.JavaRuntime.Helpers.Request").JsonRequest
local FS = require("fs")
local Json = require("json")
local GameFolder = Import("ga.CubicInc.SMP.JavaRuntime.Locations.GameFolder")

function HashResolver:initialize()
    self.Hashes = {}
end

function HashResolver:ResolveRemoteHashes()
    if self.Hashes.Remote then return end
    local _, Hashes = JsonRequest(
        "GET",
        "https://raw.githubusercontent.com/CoreBytee/ModLoader/main/Meta/Hashes.json"
    )
    self.Hashes.Remote = Hashes
end

function HashResolver:ResolveLocalHashes()
    if self.Hashes.Local then return end
    local HashFile = GameFolder .. "/CubicLoader/Hashes.json"
    if not FS.existsSync(HashFile) then
        FS.writeFileSync(HashFile, "{}")
    end
    self.Hashes.Local = Json.decode(FS.readFileSync(HashFile))
end

function HashResolver:Resolve()
    self:ResolveLocalHashes()
    self:ResolveRemoteHashes()
    return self
end

function HashResolver:GetLocalHashes()
    return self.Hashes.Local
end

function HashResolver:GetRemoteHashes()
    return self.Hashes.Remote
end

function HashResolver:StoreHashes()
    FS.writeFileSync(
        GameFolder .. "/CubicLoader/Hashes.json",
        Json.encode(
            self:GetRemoteHashes(),
            { indent = true }
        )
    )
end

return HashResolver