#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Simulate scanning and encrypting the paper input ballots for PEP..."

java \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunBatchEncryption \
    -in ${WORKSPACE_DIR}/eg/keyceremony \
    -ballots ${WORKSPACE_DIR}/eg/encryption/private/input \
    -out ${WORKSPACE_DIR}/eg/pep/encrypted \
    -invalid ${WORKSPACE_DIR}/eg/encryption/private/invalid \
    -device scanned \
    --cleanOutput

rave_print "[DONE] Encrypting the input ballots for PEP."
