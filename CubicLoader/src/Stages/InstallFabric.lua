local JsonRequest = require("JsonRequest")
local Request = require("coro-http").request
local FS = require("fs")
local Spawn = require("coro-spawn")

local function FindStableFabric()
    local Request, Data = JsonRequest("GET", "https://meta.fabricmc.net/v2/versions/installer")
    for Index, Release in pairs(Data) do
        if Release.stable == true then
            return Release
        end
    end
end

return {
    Name = "Install Fabric",
    Function = function ()
        local FabricRelease = FindStableFabric()
        print("Install Fabric > Downloading fabric installer v" .. FabricRelease.version)
        local Response, Body = Request("GET", FabricRelease.url)
        FS.writeFileSync("./.CubicLoader/FabricInstaller.jar", Body)

        local Result, Error = Spawn(
            "java",
            {
                args = {
                    "-jar", "./.CubicLoader/FabricInstaller.jar",
                    "client",
                    "-mcversion", "1.18.1",
                    "-loader", "0.13.3",
                    "-noprofile"
                }
            }
        )

        if Result then
            Result.waitExit()
        end
        
        print("Install Fabric > " .. (Result.stdout.read() or "No Info"))
        print("Install Fabric > " .. (Result.stderr.read() or "No Error"))
        print("Install Fabric > " .. (Error or "Install Successfull"))


    end
}