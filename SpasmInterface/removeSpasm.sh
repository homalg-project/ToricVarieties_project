echo ""
echo "------------------------------------------------------------------------"
echo "Welcome!"
echo "This script attempts to remove the spasm installation"
echo "(https://github.com/cbouilla/spasm)"
echo "------------------------------------------------------------------------"
echo ""

echo ""
echo "------------------------------------------------------------------------"
echo "Step1: Delete spasm"
echo "------------------------------------------------------------------------"
echo ""

rm -r -f spasm

echo ""
echo "------------------------------------------------------------------------"
echo "Step2: Unconfigure SpasmInterface"
echo "------------------------------------------------------------------------"
echo ""

cd gap
> SpasmDirectory.txt
cd ..

echo ""
echo "------------------------------------------------------------------------"
echo "Successfully removed the spasm installation"
echo "------------------------------------------------------------------------"
echo ""
