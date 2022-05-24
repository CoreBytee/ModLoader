local Github = Object:extend()

local Json = require("json")
local Request = require("coro-http").request
local function JsonRequest(Method, Url, Headers, Data)
    local Response, Body = Request(Method, Url, Headers, Data)
    return Response, Json.decode(Body)
end

function Github:initialize(Author, Repository, Branch, Path)
    self.Author = Author
    self.Repository = Repository
    self.Branch = Branch
    self.Path = Path
    self.Hashes = {}
end

function Github:FetchTree()
    local _, Data = JsonRequest(
        "GET",
        string.format(
            "https://api.github.com/repos/%s/%s/git/trees/%s?recursive=1",
            self.Author,
            self.Repository,
            self.Branch
        ),
        {
            {"User-Agent", "Modloader"}
        }
    )

    local Files = {}
    for Index, File in pairs(Data.tree) do
        if string.startswith(File.path, self.Path) then
            table.insert(
                Files,
                {
                    Path = string.sub(File.path, #self.Path + 2),
                    FullPath = File.path,
                    Type = File.type,
                }
            )
        end
    end
    p(Files)
    self.Tree = Files
    return self
end

function Github:FindHashFiles()
    local Hashes = {}
    for Index, File in pairs(self.Tree) do
        if File.Path:endswith(".hash") then
            table.insert(Hashes, File)
        end
    end
    return Hashes
end

function Github:FetchRemoteHashes()
    if self.Hashes.Remote ~= nil then
        return self
    end
    self.Hashes.Remote = {}
    local HashFiles = self:FindHashFiles()
    for Index, File in pairs(HashFiles) do
        Log(File)
        Log(Index, #HashFiles)
        local Response, Data = JsonRequest(
            "GET",
            string.format(
                "https://raw.githubusercontent.com/%s/%s/%s/%s",
                self.Author,
                self.Repository,
                self.Branch,
                File.FullPath
            ),
            {
                {"User-Agent", "Modloader"}
            }
        )
        Log(Data)
    end
end

function Github:FetchLocalHashes()
    if self.Hashes.Local ~= nil then
        return self
    end
    self.Hashes.Local = {}
    
end

function Github:Sync()
    self:FetchRemoteHashes()
    self:FetchLocalHashes()
end

return Github