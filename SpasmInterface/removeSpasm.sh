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

touch set.gi
echo 'LoadPackage( "SpasmInterface" );' >> set.gi
echo 'SetSpasmDirectory( "" );' >> set.gi
echo 'QUIT;;' >> set.gi
gap set.gi
rm set.gi


echo ""
echo "------------------------------------------------------------------------"
echo "Successfully removed the spasm installation"
echo "------------------------------------------------------------------------"
echo ""
