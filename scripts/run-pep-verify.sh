#!/bin/bash

source $(dirname "$0")/functions.sh

WORKSPACE_DIR=$1

if [ -z "${WORKSPACE_DIR}" ]; then
    rave_print "No workspace provided."
    exit 1
fi

rave_print "Verify the PEP output."

java \
  -classpath ./tools/electionguard/egk-webapps/libs/egklib-all.jar \
  electionguard.cli.RunVerifyPep \
    -in ${WORKSPACE_DIR}/eg/encryption \
    -pep ${WORKSPACE_DIR}/eg/pep/ \

rave_print "[DONE] PEP verify."
