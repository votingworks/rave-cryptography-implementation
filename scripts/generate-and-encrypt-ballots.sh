#!/bin/bash

WORKSPACE_DIR=$1
NUM_BALLOTS=$2

if [ -z "${WORKSPACE_DIR}" ]; then
    exit 1
fi

if [ -z "${NUM_BALLOTS}" ]; then
    exit 1
fi

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
