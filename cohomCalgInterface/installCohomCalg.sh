echo ""
echo "------------------------------------------------------------------------"
echo "Welcome!"
echo "This script attempts to clone the cohomCalg repository and install it"
echo "(https://github.com/BenjaminJurke/cohomCalg)"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "------------------------------------------------------------------------"
echo "Step1: Clone cohomCalg"
echo "------------------------------------------------------------------------"
echo ""

git clone https://github.com/HereAround/cohomCalg
cd cohomCalg
git checkout -b prepared
git pull origin prepared

echo ""
echo "------------------------------------------------------------------------"
echo "Step2: Build cohomCalg"
echo "------------------------------------------------------------------------"
echo ""

make -j $(nproc)

echo ""
echo "------------------------------------------------------------------------"
echo "Step3: Place binary in separate folder"
echo "------------------------------------------------------------------------"
echo ""

cd ..
cp cohomCalg/bin/cohomcalg binAndMonomialFiles

echo ""
echo "------------------------------------------------------------------------"
echo "Installation complete"
echo "------------------------------------------------------------------------"
echo ""
