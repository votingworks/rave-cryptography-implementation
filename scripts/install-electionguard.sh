#!/bin/bash

source $(dirname "$0")/functions.sh

rave_print "Installing ElectionGuard..."

mkdir -p tools
cd tools
rm -rf electionguard
mkdir electionguard
cd electionguard

git clone https://github.com/JohnLCaron/egk-webapps
cd egk-webapps
./gradlew clean assemble
./gradlew fatJar

rave_print "[DONE] Installing ElectionGuard."
