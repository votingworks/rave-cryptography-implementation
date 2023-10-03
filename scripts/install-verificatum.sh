#!/bin/bash

source $(dirname "$0")/functions.sh

rave_print "Installing ElectionGuard..."

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

# initialize randomness
vog -rndinit RandomDevice /dev/urandom

rave_print "[DONE] Installing ElectionGuard."
