return function ()
    if AskYesNo("Heb je al fabric?") then
        print("yes")
    else

        os.execute("pwd")
        os.execute("./FabricInstaller.jar")
    end
end