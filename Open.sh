
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


echo ░█████╗░██╗░░░██╗██████╗░██╗░█████╗░  ██╗███╗░░██╗░█████╗░
echo ██╔══██╗██║░░░██║██╔══██╗██║██╔══██╗  ██║████╗░██║██╔══██╗
echo ██║░░╚═╝██║░░░██║██████╦╝██║██║░░╚═╝  ██║██╔██╗██║██║░░╚═╝
echo ██║░░██╗██║░░░██║██╔══██╗██║██║░░██╗  ██║██║╚████║██║░░██╗
echo ╚█████╔╝╚██████╔╝██████╦╝██║╚█████╔╝  ██║██║░╚███║╚█████╔╝
echo ░╚════╝░░╚═════╝░╚═════╝░╚═╝░╚════╝░  ╚═╝╚═╝░░╚══╝░╚════╝░

echo Modloader - Created by Corebyte
echo

echo !!! JE HEBT JAVA NODIG OM DIT TE DOEN !!!
echo !!! VOOR MEER INFO GA NAAR: JAVA.COM  !!!
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
        echo "Prepairing for download (5 secs)..."
        sleep 5
        curl -# -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh
    fi

    echo
    echo Done!

else
    echo
    echo Je zit dus op windows!

    if test -f "$ExeName"; then
        echo "Luvit Gevonden, Gaat niks downloaden..."
    else
        echo "Luvit NIET gevonden, Gaat downloaden..."
        echo

        cd Luvit
        echo "Prepairing for download (5 secs)..."
        sleep 5
        PowerShell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iex ((new-object net.webclient).DownloadString('https://github.com/luvit/lit/raw/master/get-lit.ps1'))"
    fi
fi

echo Starting setup wizard

./Luvit/luvit ./Work/Main.lua