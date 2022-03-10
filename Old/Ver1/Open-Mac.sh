



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




echo Starting setup wizard

echo

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if test "$1" = "Client"; then
    ./Luvit/luvit ./Client/Main.lua
elif test "$1" = "Server"; then
    ./Luvit/luvit ./Server/Main.lua
else
    echo "${red}Geef '${green}Server${red}' of '${green}Client${red}' op${reset}"
fi

