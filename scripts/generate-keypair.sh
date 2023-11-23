#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Generating Election Keypair..."

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunTrustedKeyCeremony \
    -in ${WORKSPACE_DIR}/eg \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg

rave_print "[DONE] Generating Election Keypair: election initialization in ${WORKSPACE_DIR}/eg, private data in ${WORKSPACE_DIR}/eg/trustees"
