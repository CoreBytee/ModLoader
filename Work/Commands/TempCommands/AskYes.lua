return function ()
    
    if AskYesNo("Wil je Fabic met mods installeren? ") then
        print("Gaat verder met het process..")
    else
        print("Doei!!!")
        os.exit()
    end

end