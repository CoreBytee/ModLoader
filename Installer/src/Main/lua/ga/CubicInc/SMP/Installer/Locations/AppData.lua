local Folders = {
    ["win32"] = Process.env.APPDATA,
    ["darwin"] = "/Users/" .. (Process.env.USER or "") .. "/Library/Application Support/"
}

return Folders[TypeWriter.Os]