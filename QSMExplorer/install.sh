echo ""
echo "----------------------------"
echo "Building the root counter..."

cd bin/RootCounter
g++ -c WDiagram.cpp
g++ -c $(realpath main.cpp) -lpthread
g++ -o counter WDiagram.o main.o -lpthread
cd ../..

echo "Completed"
echo "----------------------------"
echo ""

