#!/bin/bash

sudo apt install jq openjdk-17-jdk curl zip nodejs
curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install kotlin
