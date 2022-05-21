print((event or {isGameStart = false}).isGameStart)

FS:open("../../../CubicLoader/PlayerName.txt"):write(Player:getPlayer():getName():getString())
print(JsMacros:open("../../../CubicLoader/CubicModReporter.exe"))