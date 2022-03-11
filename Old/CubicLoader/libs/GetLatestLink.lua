return function ()
    local ResponseData, UnpackedData = JsonRequest("GET", "https://api.github.com/repos/CoreBytee/SMP-Resources/releases", {{"user-agent", "TypeWriter installer"}})

    return "https://codeload.github.com/CoreBytee/SMP-Resources/legacy.zip/refs/tags/" .. UnpackedData[1].tag_name, UnpackedData[1].tag_name
end