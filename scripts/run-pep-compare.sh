#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Checking mixnet output against the encrypted ballots with PEP algorithm"

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunMixnetBlindTrustPep \
    -in ${WORKSPACE_DIR}/eg/encryption \
    --mixnetFile ${WORKSPACE_DIR}/vf/after-mix-2-ciphertexts.json \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/eg/pep


rave_print "[DONE] Checking mixnet output."
