local ResourcePackFolder = require("Folders").GetCustomFolder() .. "/resourcepacks/"
local FS = require("fs")
local Sha = require("sha1")

local IgnoreNames = {
    [".DS_Store"] = true
}

return function ()
    local ResourceReport = {}
    ResourceReport.HasSubFolder = false
    ResourceReport.FileHashes = {}
    ResourceReport.Folders = {}

    for FileName, FileType in FS.scandirSync(ResourcePackFolder) do
        if not IgnoreNames[FileName] then
            if FileType == "file" then
                ResourceReport.FileHashes[Sha(FS.readFileSync(ResourcePackFolder .. "/" .. FileName))] = {Name = FileName}
            end
            print(FileName, FileType)
        else
            print("Ignoring file " .. FileName)
        end
        if FileType == "directory" then
            ResourceReport.HasSubFolder = true
            ResourceReport.Folders[FileName] = true
        end
        
    end
    return ResourceReport
end