#!/bin/bash

source $(dirname "$0")/functions.sh

rave_print "Installing Basic Software..."

sudo apt install -y jq openjdk-17-jdk curl zip nodejs
curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install kotlin

rave_print "Done Installing Basic Sofware."
