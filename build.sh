echo ""
echo "(*) Install cohomCalg"
echo ""
cd cohomCalgInterface
./installCohomCalg.sh
cd ..

echo ""
echo "(*) Install Spasm"
echo ""
cd SpasmInterface
./installSpasm.sh
cd ..

echo ""
echo "(*) Install H0Approximator"
echo ""
cd H0Approximator
./install.sh
cd ..

echo ""
echo "(*) Install QSMExplorer"
echo ""
cd QSMExplorer
./install.sh
cd ..
