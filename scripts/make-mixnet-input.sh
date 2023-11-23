#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1
VERIFICATUM_WORKSPACE=${WORKSPACE_DIR}/vf
rm -rf ${VERIFICATUM_WORKSPACE}/*
mkdir -p ${VERIFICATUM_WORKSPACE}
mkdir -p ${WORKSPACE_DIR}/vf

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Creating mixnet input from the encrypted ballots"

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunMakeMixnetInput \
    -eballots ${WORKSPACE_DIR}/bb/EB \
    -out ${WORKSPACE_DIR}/vf/input-ciphertexts.json

rave_print "[DONE] Creating mixnet input."
