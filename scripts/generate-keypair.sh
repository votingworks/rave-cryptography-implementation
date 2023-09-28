#!/bin/bash

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    exit 1
fi

java \
  -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunCreateElectionConfig \
    -manifest ${WORKSPACE_DIR}/eg/manifest.json \
    -nguardians 3 \
    -quorum 3 \
    -out ${WORKSPACE_DIR}/eg/initialized \
    --baux0 device42


java \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunTrustedKeyCeremony \
    -in ${WORKSPACE_DIR}/eg/initialized \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg/keyceremony 
