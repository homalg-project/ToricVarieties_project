#!/bin/sh

echo ""
echo "Downloading Topcom"
echo ""

curl -sS http://www.rambau.wm.uni-bayreuth.de/Software/TOPCOM-0.17.8.tar.gz > Topcom.tar.gz
tar -xf Topcom.tar.gz 
rm Topcom.tar.gz

echo ""
echo "Build topcom"
echo ""

cd topcom-0.17.8
./configure CFLAGS="-m64" CXXFLAGS="-m64"
make -j $(nproc)
make check
make install
make clean
