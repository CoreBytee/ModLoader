local function Log(Text)
    FS:open("./Log.log"):append("\n" .. tostring(Text))
end

local MultiPlayerButton = Hud:getOpenScreen():getButtonWidgets()[2]
Log("a")
MultiPlayerButton:setLabel("Join Server")
MultiPlayerButton:clicked(function ()
    Log("block")
end)

