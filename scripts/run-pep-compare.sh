#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Run PEP comparison on the original encrypted ballots and the 'scanned' encrypted ballots."

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunTrustedPep \
    -in ${WORKSPACE_DIR}/eg/encryption \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -scanned ${WORKSPACE_DIR}/eg/pep/encrypted/encrypted_ballots/scanned \
    -out ${WORKSPACE_DIR}/eg/pep/ \

rave_print "[DONE] PEP comparison."
