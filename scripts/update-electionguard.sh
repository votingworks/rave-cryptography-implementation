#!/bin/bash

source $(dirname "$0")/functions.sh

rave_print "Updating ElectionGuard..."

cd tools
cd electionguard
cd egk-webapps

git fetch origin
git rebase -i origin/main
./gradlew clean assemble

rave_print "[DONE] Updating ElectionGuard."
