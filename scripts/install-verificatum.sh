#!/bin/bash

mkdir -p tools
cd tools
rm -rf verificatum
mkdir verificatum
cd verificatum

git clone https://github.com/verificatum/verificatum-vcr
git clone https://github.com/verificatum/verificatum-vmn

sudo apt install autotools-dev automake

cd verificatum-vcr
make -f Makefile.build
./configure
make
sudo make install

cd ../

cd verificatum-vmn
make -f Makefile.build
./configure
make
sudo make install

