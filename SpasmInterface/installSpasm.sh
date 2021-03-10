echo ""
echo "------------------------------------------------------------------------"
echo "Welcome!"
echo "This script attempts to clone the Spasms repository and install it"
echo "(https://github.com/cbouilla/spasm)"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "------------------------------------------------------------------------"
echo "Step1: Save path to file which by default stores the SpasmDirectory"
echo "------------------------------------------------------------------------"
echo ""

cd gap
FILE_PATH=$(readlink -f SpasmDirectory.txt)
cd ..

echo ""
echo "------------------------------------------------------------------------"
echo "Step2: Clone spasm"
echo "------------------------------------------------------------------------"
echo ""

git clone https://github.com/cbouilla/spasm.git
cd spasm
git remote add MartinBies https://github.com/HereAround/spasm
git fetch MartinBies martin_devel:martin_devel
git checkout martin_devel


echo ""
echo "------------------------------------------------------------------------"
echo "Step3: Build spasm"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "(*) Install Spasm"
echo ""
aclocal
autoconf
autoreconf --install
./configure
make -j$(nproc)

echo ""
echo "(*) Configure SpasmInterface"
echo ""
cd bench/
pwd > $FILE_PATH
cd ../../..

echo ""
echo "------------------------------------------------------------------------"
echo "Installation complete"
echo "------------------------------------------------------------------------"
echo ""
