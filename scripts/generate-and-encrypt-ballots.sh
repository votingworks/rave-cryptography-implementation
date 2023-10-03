#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1
NUM_BALLOTS=$2

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

if [ -z "${NUM_BALLOTS}" ]; then
    rave_print "No number of ballots provided."
    exit 1
fi

rave_print "Generating and Encrypting ${NUM_BALLOTS} ballots..."

# run the encryption server
java \
  -classpath ./tools/electionguard/egk-webapps/encryptserver/build/libs/encryptserver-all.jar \
  electionguard.webapps.server.RunEgkServerKt \
  --inputDir ${WORKSPACE_DIR}/eg/keyceremony \
  --outputDir ${WORKSPACE_DIR}/eg/encryption &

SERVER_PID=$!

sleep 5

# generate a bunch of ballots and encrypt them
java \
  -classpath ./tools/electionguard/egk-webapps/encryptclient/build/libs/encryptclient-all.jar \
  electionguard.webapps.client.RunEgkClientKt \
  --inputDir ${WORKSPACE_DIR}/eg/keyceremony \
  --outputDir ${WORKSPACE_DIR}/eg/encryption \
  --nballots ${NUM_BALLOTS}

kill ${SERVER_PID}

rave_print "[DONE] Generating encrypted ballots: ${WORKSPACE_DIR}/eg/encryption/encrypted_ballots"
