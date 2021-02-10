echo Downloading

DownloadURL=https://github.com/CoreBytee/ModLoader/archive/main.zip

curl -L $DownloadURL > loader.zip

unzip loader.zip
rm loader.zip

echo Done