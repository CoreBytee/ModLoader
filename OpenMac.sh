
#vars
DevMode=true
ReinstallLuvit=false


HasUsedForge=false
HasMods=false

BackupMods=false
BackupMinecraftFolder=true

OnMac=true

ExeName=./Luvit/luvit.exe
MacName=./Luvit/luvit

echo hey


echo ░█████╗░██╗░░░██╗██████╗░██╗░█████╗░  ██╗███╗░░██╗░█████╗░
echo ██╔══██╗██║░░░██║██╔══██╗██║██╔══██╗  ██║████╗░██║██╔══██╗
echo ██║░░╚═╝██║░░░██║██████╦╝██║██║░░╚═╝  ██║██╔██╗██║██║░░╚═╝
echo ██║░░██╗██║░░░██║██╔══██╗██║██║░░██╗  ██║██║╚████║██║░░██╗
echo ╚█████╔╝╚██████╔╝██████╦╝██║╚█████╔╝  ██║██║░╚███║╚█████╔╝
echo ░╚════╝░░╚═════╝░╚═════╝░╚═╝░╚════╝░  ╚═╝╚═╝░░╚══╝░╚════╝░

echo Modloader
echo Created by Corebyte
echo

LuvitMac=false
LuvitExe=false

read -p "Zit je op mac? (y/n):" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo Je zit dus op mac!

    if test -f "$MacName"; then
        echo "Luvit Gevonden, Gaat niks downloaden..."
    else
        echo "Luvit NIET gevonden, Gaat downloaden..."
        echo

        cd Luvit
        echo Prepairing for download
        sleep 5
        curl -# -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh
    fi
else
    echo
    echo Je zit dus op windows!
fi

