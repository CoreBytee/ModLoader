local LoaderHelper = Object:extend()

local JsonRequest = Import('ga.CubicInc.SMP.Installer.Helpers.Request').JsonRequest
local Request = Import('ga.CubicInc.SMP.Installer.Helpers.Request').Request

local FS = require("fs")

local LoaderFolder = Import('ga.CubicInc.SMP.Installer.Locations.Loader')

function LoaderHelper:initialize()
    local _, VersionInfo = JsonRequest(
        "GET",
        "https://raw.githubusercontent.com/CoreBytee/ModLoader/main/Meta/GameVersion.json"
    )
    VersionInfo.VersionString = string.format(
        "quilt-loader-%s-%s",
        VersionInfo.QuiltVersion,
        VersionInfo.MinecraftVersion
    )
    self.VersionInfo = VersionInfo
    p(self.VersionInfo)
end

function LoaderHelper:GetVersionString()
    return self.VersionInfo.VersionString
end

function LoaderHelper:DownloadInstaller()
    local _, Installer = Request(
        "GET",
        "https://maven.quiltmc.org/repository/release/org/quiltmc/quilt-installer/latest/quilt-installer-latest.jar"
    )
    FS.writeFileSync(
        LoaderFolder .. "quilt-installer.jar",
        Installer
    )
end

function LoaderHelper:InstallLoader()
    local Result = require("coro-spawn")(
        "java",
        {
            args = {
                "-jar", LoaderFolder .. "quilt-installer.jar",
                "install", "client",
                self.VersionInfo.MinecraftVersion, self.VersionInfo.QuiltVersion,
                "--no-profile"
            }
        }
    )
    coroutine.wrap(function ()
        for Message in Result.stdout.read do
            local ParsedMessage = table.concat(
                table.concat(
                    Message:Split("\r")
                ):Split("\n")
            )
            
            TypeWriter.Logger.Info("Quilt > " .. ParsedMessage)
        end
    end)()
    Result.waitExit()
end

function LoaderHelper:Install()
    TypeWriter.Logger.Info("Downloading quilt-installer.jar")
    self:DownloadInstaller()
    TypeWriter.Logger.Info("Downloaded quilt-installer.jar")
    self:InstallLoader()
    TypeWriter.Logger.Info("Loader Installed")
end

return LoaderHelper