#!/bin/bash

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    exit 1
fi

java \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunAccumulateTally \
    -in ${WORKSPACE_DIR}/eg/encryption \
    -out ${WORKSPACE_DIR}/eg/encryption 
