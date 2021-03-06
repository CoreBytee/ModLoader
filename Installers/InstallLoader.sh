Name=ModLoader
DownloadURL=https://github.com/CoreBytee/ModLoader/archive/main.zip

#cd "~/Library/Application Support/minecraft"

cd ~
cd Library
cd "Application Support"
cd minecraft

echo removing old..
rm -r ModLoader/

sleep 3

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

echo "Done installing LUVIT"

cd ../

sleep 2

echo "Pakketten downloaden"

sleep 2

echo "Downloading Weblit"

sleep 1

./Luvit/lit install creationix/weblit

echo "also done!"

sleep 2

echo "Data template renaming"

cd Client
cd Data
cd Template

mv DataTemplate/ Data
mv ConfigurationTemplate/ Config

mv Data ../Data
mv Config ../Config

cd ..

rm -r Template/

cd ..
cd ..

sleep 1

#echo "Making temp folder"

#mkdir Temp


echo starting
./Open-Mac.sh Client
