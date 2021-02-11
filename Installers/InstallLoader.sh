Name=ModLoader
DownloadURL=https://github.com/CoreBytee/ModLoader/archive/main.zip

if test -f "./$Name"; then
        echo removing old..
        rm "$Name/"
    fi

echo "Downloading"



curl -L $DownloadURL > Loader.zip

unzip Loader.zip

echo "Removing ZIP"
rm Loader.zip

echo "Renaming"
mv ModLoader-main/ ModLoader

cd ModLoader
mkdir Luvit
cd Luvit

curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh

echo "Done"
