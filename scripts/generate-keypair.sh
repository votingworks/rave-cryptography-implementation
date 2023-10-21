#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Generating Election Keypair..."

java \
  -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunCreateElectionConfig \
    -manifest ${WORKSPACE_DIR}/eg/manifest.json \
    -nguardians 3 \
    -quorum 3 \
    -out ${WORKSPACE_DIR}/eg/initialized \
    --baux0 device42


java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunTrustedKeyCeremony \
    -in ${WORKSPACE_DIR}/eg/initialized \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg/keyceremony 

rave_print "[DONE] Generating Election Keypair, private data in ${WORKSPACE_DIR}/eg/trustees, election config in ${WORKSPACE_DIR}/eg/keyceremony"
