



#echo ░█████╗░██╗░░░██╗██████╗░██╗░█████╗░  ██╗███╗░░██╗░█████╗░
#echo ██╔══██╗██║░░░██║██╔══██╗██║██╔══██╗  ██║████╗░██║██╔══██╗
#echo ██║░░╚═╝██║░░░██║██████╦╝██║██║░░╚═╝  ██║██╔██╗██║██║░░╚═╝
#echo ██║░░██╗██║░░░██║██╔══██╗██║██║░░██╗  ██║██║╚████║██║░░██╗
#echo ╚█████╔╝╚██████╔╝██████╦╝██║╚█████╔╝  ██║██║░╚███║╚█████╔╝
#echo ░╚════╝░░╚═════╝░╚═════╝░╚═╝░╚════╝░  ╚═╝╚═╝░░╚══╝░╚════╝░

echo "Modloader - Created by Corebyte"
echo ""

echo "!!! JE HEBT JAVA NODIG OM DIT TE DOEN !!!"
echo "!!! VOOR MEER INFO GA NAAR: JAVA.COM  !!!"
echo "" 




echo "Starting setup wizard"
echo ""

if ( $args[0] -eq "Client" )
{
    ./Luvit/luvit ./Client/Main
}
elseif ( $args[0] -eq "Server" )
{
    ./Luvit/luvit ./Server/Main
}
else
{
    Write-Host "Geef '" -ForegroundColor Red -NoNewline
    Write-Host "Server" -ForegroundColor Green -NoNewline
    Write-Host "' of '" -ForegroundColor Red -NoNewline
    Write-Host "Client" -ForegroundColor Green -NoNewline
    Write-Host "' op" -ForegroundColor Red -NoNewline
}