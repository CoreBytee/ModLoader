local P = function (T)
    return Chat:log(T)
end

local Split = function(TheString, Decr)
    Lines = {}
    for s in TheString:gmatch("[^" .. Decr .. "]+") do
        table.insert(Lines, s)
    end
    return Lines
end

local p = P


if Hud:getOpenScreenName() == "3 Row Chest" and Hud:getOpenScreen():getTitleText() == "Ender Chest" and Player:getPlayer():getName():getString() == "R41PH054URU5" and string.lower(Split(World:getCurrentServerAddress(), "/")[1]) == "smp.cubic-inc.ga" and not FS:exists("./Rolled.txt") and World:getBlock(-145, -53, -67):getName() == "Bedrock" then
    JsMacros:openUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    Chat:say("/me has been rolled by himself -_-")
    Chat:say("/me is a donkey")
    FS:open("./Rolled.txt"):write("true")
end
