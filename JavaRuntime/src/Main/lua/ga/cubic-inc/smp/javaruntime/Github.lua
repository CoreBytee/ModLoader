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
    Log(Files)
    return self
end

return Github