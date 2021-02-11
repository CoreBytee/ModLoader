Name=ModLoader
DownloadURL=https://github.com/CoreBytee/ModLoader/archive/main.zip

echo removing old..
rm -r ModLoader/

sleep 2

echo "Downloading"



curl -L $DownloadURL > Loader.zip

unzip Loader.zip

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

curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh

sleep 3

echo "Done"

echo cd up
cd ..

echo starting
./Open-Mac.sh
