echo ""
echo "------------------------------------------------------------------------"
echo "Welcome!"
echo "This script attempts to clone the Spasms repository and install it"
echo "(https://github.com/cbouilla/spasm)"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "------------------------------------------------------------------------"
echo "Step1: Clone spasm"
echo "------------------------------------------------------------------------"
echo ""

git clone https://github.com/cbouilla/spasm.git
cd spasm
git checkout -b prepared
git remote add MartinBies https://github.com/HereAround/spasm
git pull MartinBies martin_devel


echo ""
echo "------------------------------------------------------------------------"
echo "Step2: Build spasm"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "(*) Install Spasm"
echo ""
aclocal
autoconf
autoreconf --install
./configure
make -j4

echo ""
echo "(*) Configure SpasmInterface"
echo ""
cd bench/
touch set.gi
echo 'LoadPackage( "SpasmInterface" );' >> set.gi
echo 'path := DirectoriesSystemPrograms();;' >> set.gi
echo 'pwd := Filename( path, "pwd" );;' >> set.gi
echo 'stdin := InputTextUser();;' >> set.gi
echo 'str := "";;' >> set.gi
echo 'stdout := OutputTextString(str,true);;' >> set.gi
echo 'String ( Process( DirectoryCurrent(), pwd, stdin, stdout, [] ) );;' >> set.gi
echo 'SetSpasmDirectory( str );' >> set.gi
echo 'QUIT;;' >> set.gi
gap set.gi
rm set.gi


echo ""
echo "------------------------------------------------------------------------"
echo "Installation complete"
echo "------------------------------------------------------------------------"
echo ""
