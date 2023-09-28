#!/bin/bash

WORKSPACE_DIR=$1
VX_DEF=$2

if [ -z "${WORKSPACE_DIR}" ]; then
    exit 1
fi

if [ -z "${VX_DEF}" ]; then
    exit 1
fi

rm -rf ${WORKSPACE_DIR}/*

mkdir -p  ${WORKSPACE_DIR}/eg

node ./election-definition-convert-vx-to-eg.js ${VX_DEF} ${WORKSPACE_DIR}/eg/manifest.json

java \
  -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 \
  -classpath ./tools/electionguard/egk-webapps/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunCreateElectionConfig \
    -manifest ${WORKSPACE_DIR}/eg/manifest.json \
    -nguardians 3 \
    -quorum 3 \
    -out ${WORKSPACE_DIR}/eg/initialized \
    --baux0 device42

