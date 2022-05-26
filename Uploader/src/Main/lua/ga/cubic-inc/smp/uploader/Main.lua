print("Hello World!")
local FS = require("fs")
local RecurseRemove = require("coro-fs").rmrf
local Hash = require("sha1")
local Json = require("json")
local PathLibrary = require("path")
local Logger = TypeWriter.Logger


local MetaGameFolder = TypeWriter.Here .. "/Meta/GameFolder/"
local GameFolder = FS.readFileSync(TypeWriter.ExeFolder .. "/TestingGameFolder.Path")

local function ClearFolder(Path)
    RecurseRemove(Path)
    FS.mkdir(Path)
end

local Hashes = {}
local function HashFile(DestinationPath, FileData)
    local Location = table.concat(PathLibrary.resolve(DestinationPath):split(PathLibrary.resolve(MetaGameFolder))[2]:split("\\"), "/")
    Logger.Info("Compiling hash for " .. Location)
    local SplitPath = DestinationPath:split("/")
    local HashData = {
        File = SplitPath[#SplitPath],
        DestinationPath = Location,
        Size = #FileData,
        Hash = Hash(FileData)
    }
    p(HashData)
    table.insert(Hashes, HashData)
    Logger.Info("Compiled hash")
    Logger.Info()
end

local function SaveHashes(To)
    FS.writeFileSync(To .. "/Hashes.json", Json.encode(Hashes, { indent = true, keyorder = {"File", "Size", "Hash"} }))
end

local function CopyFile(Source, Destination)
    local FileData = FS.readFileSync(Source)
    FS.writeFileSync(Destination, FileData)
    HashFile(Destination, FileData)
    return FileData
end

local function CopyFolder(Source, Destination)
    local Length = #FS.readdirSync(Source)
    local Index = 0
    FS.mkdirSync(Destination)
    for _, File in pairs(FS.readdirSync(Source)) do
        local SourcePath = Source .. "/" .. File
        local DestinationPath = Destination .. "/" .. File
        local Type = FS.statSync(SourcePath).type
        coroutine.resume(coroutine.create(function ()
            if string.endswith(File, ".ignore") or FS.existsSync(Source .. "/" .. File .. ".ignore") then
                -- just ignore this duhh
            elseif Type == "directory" then
                FS.mkdirSync(DestinationPath)
                CopyFolder(SourcePath, DestinationPath, Callback)
            else
                local FileData = CopyFile(SourcePath, DestinationPath)
            end
            Index = Index + 1
        end))
    end
    repeat
        Wait(1)
    until Index == Length
end


print("MetaGameFolder: " .. MetaGameFolder)
print("GameFolder: " .. GameFolder)

ClearFolder(MetaGameFolder)

CopyFolder(
    GameFolder .. "/mods/",
    MetaGameFolder .. "/mods/"
)

CopyFolder(
    GameFolder .. "/config/",
    MetaGameFolder .. "/config/"
)

CopyFolder(
    GameFolder .. "/resourcepacks/",
    MetaGameFolder .. "/resourcepacks/"
)

CopyFile(
    GameFolder .. "/options.txt",
    MetaGameFolder .. "/options.txt"
)

CopyFile(
    GameFolder .. "/servers.dat",
    MetaGameFolder .. "/servers.dat"
)

SaveHashes(TypeWriter.Here .. "/Meta/")