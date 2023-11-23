#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi


rave_print "Decrypting encrypted tally..."

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunTrustedTallyDecryption \
    -in ${WORKSPACE_DIR}/eg \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg

rave_print "[DONE] Decrypted tally in ${WORKSPACE_DIR}/eg/tally.json"
