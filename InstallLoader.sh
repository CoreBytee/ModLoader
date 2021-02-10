echo "Downloading"

DownloadURL=https://github.com/CoreBytee/ModLoader/archive/main.zip

curl -L $DownloadURL > loader.zip

unzip loader.zip

echo "Removing ZIP"
rm loader.zip

echo "Renaming"
mv ModLoader-main/ ModLoader

echo "Done"