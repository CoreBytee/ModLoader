print("Hello World!")
local FS = require("fs")
local RecurseRemove = require("coro-fs").rmrf
local Hash = require("sha1")
local Json = require("json")

local function ClearFolder(Path)
    RecurseRemove(Path)
    FS.mkdir(Path)
end

local function CopyFile(Source, Destination)
    local FileData = FS.readFileSync(Source)
    FS.writeFileSync(Destination, FileData)
    return FileData
end

local function HashFile(DestinationPath, File, SourcePath, FileData, Index, Length)
    print("Copied " .. File)
    print("Compiling hash")
    local HashData = {
        File = File,
        Size = #FileData,
        Hash = Hash(FileData)
    }
    print("Writing hash")
    FS.writeFileSync(DestinationPath .. ".hash", Json.encode(HashData, { indent = true, keyorder = {"File, Size, Hash"} }))
    print("Wrote hash")
    print(Index .. "/" .. Length)
    print()
end

local function CopyFolder(Source, Destination, Callback)
    if Callback == nil then
        Callback = function() end
    end
    local Length = #FS.readdirSync(Source)
    local Index = 0
    FS.mkdirSync(Destination)
    for File, Type in FS.scandirSync(Source) do
        coroutine.wrap(function ()
            local SourcePath = Source .. "/" .. File
            local DestinationPath = Destination .. "/" .. File
            if string.endswith(File, ".ignore") or FS.existsSync(Source .. "/" .. File .. ".ignore") then
                -- just ignore this duhh
            elseif Type == "directory" then
                FS.mkdirSync(DestinationPath)
                CopyFolder(SourcePath, DestinationPath, Callback)
            else
                local FileData = CopyFile(SourcePath, DestinationPath)
                HashFile(DestinationPath, File, SourcePath, FileData, Index + 1, Length - 1)
                Callback(DestinationPath, File, SourcePath, FileData, Index + 1, Length)
            end
            Index = Index + 1
        end)()
    end
    repeat
        Wait(1)
    until Index == Length
end

local MetaGameFolder = TypeWriter.Here .. "/Meta/GameFolder/"
local GameFolder = FS.readFileSync("./GameFolder.Path")

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