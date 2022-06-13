local ModSyncer = Object:extend()

local FindTableWithKey = Import("ga.CubicInc.SMP.JavaRuntime.Helpers.FindTableWithKey")
local GameFolder = Import("ga.CubicInc.SMP.JavaRuntime.Locations.GameFolder")
local Request = Import("ga.CubicInc.SMP.JavaRuntime.Helpers.Request").Request
local RawUrl = "https://raw.githubusercontent.com/CoreBytee/ModLoader/main/Meta/GameFolder/"
local FS = require("fs")
local Mkdirp = require("coro-fs").mkdirp
local DirName = require("path").dirname
local ResolvePath = require("path").resolve

function ModSyncer:initialize()
    self.HashResolver = Import("ga.CubicInc.SMP.JavaRuntime.Helpers.HashResolver"):new()
    self.Actions = {}
end

function ModSyncer:SyncRemote()
    local LocalHashes = self.HashResolver:GetLocalHashes()
    local RemoteHashes = self.HashResolver:GetRemoteHashes()
    for Index, RemoteHash in pairs(RemoteHashes) do
        local LocalHash = FindTableWithKey(LocalHashes, "Hash", RemoteHash.Hash)
        p(RemoteHash)
        local function AddAction()
            table.insert(
                self.Actions,
                {
                    DestPath = RemoteHash.DestinationPath,
                    Type = "Download",
                    Url = RawUrl .. RemoteHash.DestinationPath,
                    Path = GameFolder .. "/" .. RemoteHash.DestinationPath
                }
            )
        end
        if not LocalHash then
            TypeWriter.Logger.Error("Hash for " .. RemoteHash.DestinationPath .. " not found")
            AddAction()
        elseif not FS.existsSync(GameFolder .. "/" .. LocalHash.DestinationPath) then
            TypeWriter.Logger.Error("File " .. LocalHash.DestinationPath .. " not found")
            AddAction()
        end
    end
end

function ModSyncer:SyncLocal()
    local LocalHashes = self.HashResolver:GetLocalHashes()
    local RemoteHashes = self.HashResolver:GetRemoteHashes()

    for Index, Hash in pairs(LocalHashes) do
        local RemoteHash = FindTableWithKey(RemoteHashes, "Hash", Hash.Hash)
        if not RemoteHash then
            TypeWriter.Logger.Error("Hash for " .. Hash.File .. " not found")
            TypeWriter.Logger.Error(Hash.DestinationPath)
            TypeWriter.Logger.Error()
            table.insert(
                self.Actions,
                {
                    Type = "Remove",
                    Path = GameFolder .. "/" .. Hash.DestinationPath
                }
            )
        end
    end
end

local function CreateDirForPath(Path)
    return Mkdirp(DirName(Path))
end

local function CollapseEmpty(Path)
    if #FS.readdirSync(Path) == 0 then
        TypeWriter.Logger.Error("Empty %s", Path)
        FS.rmdirSync(Path)
        CollapseEmpty(ResolvePath(Path, "../"))
    end
end

local ActionRunners = {
    Download = function (Data)
        TypeWriter.Logger.Info("Downloading " .. Data.Url)
        CreateDirForPath(Data.Path)
        local _, FileData = Request(
            "GET",
            Data.Url
        )
        TypeWriter.Logger.Info("Download complete")
        TypeWriter.Logger.Info("Writing to " .. Data.Path)
        return FS.writeFileSync(Data.Path, FileData)
    end,
    Remove = function (Data)
        TypeWriter.Logger.Info("Removing " .. Data.Path)
        FS.unlinkSync(Data.Path)
        CollapseEmpty(DirName(Data.Path))
        return 
    end
}

function ModSyncer:ExecuteActions()
    local Complete = 0
    local ActionCount = #self.Actions
    if ActionCount ~= 0 then
        
        local function Refresh(D)
            local Fac = Complete / ActionCount
            local Per = Fac * 100
            ResetWindow(
                string.format(
                    "Syncing %d/%d (%d%%)",
                    Complete,
                    ActionCount,
                    Per
                ),
                D,
                false
            )
        end
        Refresh("")
        for Index, Action in pairs(self.Actions) do
            if Action.Type == "Download" then
                Refresh(string.format("Downloading %s", Action.DestPath))
            else
                Refresh(string.format("Removing %s", Action.Path))
            end
            
            ActionRunners[Action.Type](Action)
            TypeWriter.Logger.Info("%s/%s", Complete + 1, ActionCount)
            Complete = Complete + 1
        end
        Refresh("Done syncing")
    end
    
end

function ModSyncer:Sync()
    self.HashResolver:Resolve()
    self:SyncRemote()
    self:SyncLocal()

    p(self.Actions)
    self:ExecuteActions()
    self.HashResolver:StoreHashes()
end

return ModSyncer