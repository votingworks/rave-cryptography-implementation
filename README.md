# RAVE ElectionGuard Client

This is a client of the electionguard library for RAVE purposes.

## Install

This is for Linux.

- Get SDKMan! https://sdkman.io/

- Install kotlin

`sdk install kotlin`

- Install ElectionGuard via

https://github.com/JohnLCaron/egk-webapps

set an environment variable for what follows

```
export EG_HOME=<your egk-webapps path>
```


## Prepare ElectionGuard Election Manifest and All

Convert the VotingWorks format -- this is basically the ballot definition

```
mkdir testOut
node ./convert-vx-to-eg.js ./famous-names-election.json testOut/manifest.json
```

Create the full EG Election Configuration

```
java \
  -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 \
  -classpath ${EG_HOME}/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunCreateElectionConfig \
    -manifest testOut/manifest.json \
    -nguardians 3 \
    -quorum 3 \
    -out testOut/cliWorkflow/config \
    --baux0 device42 \
    --chainCodes
```


## Generate Trustee Keypairs and Election KeyPairs (aka Key Ceremony)

```
java \
  -classpath ${EG_HOME}/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunTrustedKeyCeremony \
    -in testOut/cliWorkflow/config \
    -trustees testOut/cliWorkflow/keyceremony/trustees \
    -out testOut/cliWorkflow/keyceremony 
```

