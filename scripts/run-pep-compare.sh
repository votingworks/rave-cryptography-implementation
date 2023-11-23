#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Reencrypt ballots to simulate paper ballot scanning"

````
java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunBatchEncryption \
    -in ${WORKSPACE_DIR}/eg \
    -ballots ${WORKSPACE_DIR}/eg/inputBallots  \
    -eballots ${WORKSPACE_DIR}/bb/PB  \
    -device scanPB \
    --anonymize

rave_print "[DONE] Reencrypting ballots."

rave_print "Checking mixnet output against the reencrypted ballots with PEP algorithm"

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunMixnetBlindTrustPep \
    -in ${WORKSPACE_DIR}/eg \
    -eballots ${WORKSPACE_DIR}/bb/PB  \
    --mixnetFile ${WORKSPACE_DIR}/vf/after-mix-2-ciphertexts.json \
    -trustees ${WORKSPACE_DIR}/eg/trustees \
    -out ${WORKSPACE_DIR}/bb/pep


rave_print "[DONE] Checking mixnet output."
