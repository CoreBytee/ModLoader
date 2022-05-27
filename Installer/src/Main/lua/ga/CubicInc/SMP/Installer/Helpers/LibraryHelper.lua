local LibraryHelper = Object:extend()

local Request = Import('ga.CubicInc.SMP.Installer.Helpers.Request').Request
local FS = require("fs")
local Spawn = require("coro-spawn")

function LibraryHelper:initialize()

end

function LibraryHelper:Download()
    local FileNames = {
        ["win32"] = "Windows.zip",
        ["darwin"] = "Mac.zip"
    }
    TypeWriter.Logger.Info("Downloading libraries...")
    local _, Data = Request(
        "GET",
        "https://github.com/CoreBytee/ModLoader/releases/latest/download/CubicLoader-Libraries-" .. FileNames[TypeWriter.Os]
    )
    TypeWriter.Logger.Info("Downloaded libraries")
    FS.writeFileSync(
        Import("ga.CubicInc.SMP.Installer.Locations.Loader") .. "/Libraries.zip",
        Data
    )

    FS.writeFileSync(
        Import("ga.CubicInc.SMP.Installer.Locations.Loader") .. "/HideWindow.ps1",
        ({Request("GET", "https://raw.githubusercontent.com/CoreBytee/ModLoader/main/.Scripts/HideWindow.ps1")})[2]
    )
end

function LibraryHelper:Unpack()
    local Result = Spawn(
        "tar",
        {
            args = {
                "-xf",
                Import("ga.CubicInc.SMP.Installer.Locations.Loader") .. "/Libraries.zip",
                "-C", Import("ga.CubicInc.SMP.Installer.Locations.Loader")
            }
        }
    )
    Result.waitExit()
end

function LibraryHelper:Run()
    local Result = Spawn(
        Import("ga.CubicInc.SMP.Installer.Locations.Loader") .. "/" .. "JavaHome" .. (({["win32"] = ".exe"})[TypeWriter.Os] or ""),
        {}
    )
    Result.waitExit()
    local Output = Result.stdout.read()

    if Output == "true\n" then
        TypeWriter.Logger.Info("Correct java version found")
    else
        local Error = TypeWriter.Logger.Error
        Error("Incorrect java version found")
        Error("Please download java 17 from https://adoptium.net")
        Error("Ask for help if your stuck!")
        Wait(500000)
    end
end

function LibraryHelper:Install()
    self:Download()
    self:Unpack()
    self:Run()
end

return LibraryHelper