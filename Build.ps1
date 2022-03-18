cd $args[0]
rmdir ./.Build/ -Force -Recurse
mkdir ./.Build/
echo ""
C:/luvit/luvi.exe "./src/" -o "./.Build/Build.exe"
echo ""
./.Build/Build.exe $args
cd ..
echo ""