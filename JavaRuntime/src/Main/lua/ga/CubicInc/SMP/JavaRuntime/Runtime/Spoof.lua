return function ()
    if string.find(TypeWriter.Arguments[2], "JavaCheck.jar") then
        print("java.version=17.0.1")
        TypeWriter.Logger.Info("Spoofing")
        process:exit()
    end
end