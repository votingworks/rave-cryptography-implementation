#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Tabulating encrypted ballots..."

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunAccumulateTally \
    -in ${WORKSPACE_DIR}/eg/encryption \
    -out ${WORKSPACE_DIR}/eg/encryption 

rave_print "[DONE] Tabulating encrypted ballots."
