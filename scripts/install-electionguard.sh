#!/bin/bash

mkdir -p tools
cd tools
rm -rf electionguard
mkdir electionguard
cd electionguard

git clone https://github.com/JohnLCaron/egk-webapps
cd egk-webapps
./gradlew clean assemble
./gradlew fatJar
