#!/bin/bash

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    exit 1
fi

java \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunTrustedTallyDecryption \
    -in ${WORKSPACE_DIR}/eg/encryption \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg/encryption 

echo "look at file ${WORKSPACE_DIR}/eg/encryption/tally.json"
