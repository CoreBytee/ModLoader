
echo removing old..
rm -r ModLoader/

sleep 2

echo "Downloading"



wget -O Loader.zip https://github.com/CoreBytee/ModLoader/archive/main.zip

Expand-Archive -LiteralPath ./Loader.Zip -DestinationPath ./

sleep 1

echo "Removing ZIP"
rm Loader.zip

sleep 1

echo "Renaming"
mv ModLoader-main/ ModLoader

sleep 1

cd ModLoader
mkdir Luvit
cd Luvit

sleep 1

PowerShell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iex ((new-object net.webclient).DownloadString('https://github.com/luvit/lit/raw/master/get-lit.ps1'))"

sleep 3

echo "Done"

echo "cd up"
cd ..

echo "starting"
./Open-Windows.ps1
