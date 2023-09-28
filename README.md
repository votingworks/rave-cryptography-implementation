# RAVE ElectionGuard Client

This is a client of the electionguard library for RAVE purposes.

## Install Basics

This is for Linux.

- Get SDKMan! https://sdkman.io/

- Install kotlin

`sdk install kotlin`

## Install ElectionGuard

```
./scripts/install-electionguard.sh
```

## Install Verificatum

```
./scripts/install-verificatum.sh
```

## Initialize a Workspace for all the files

```
mkdir <WORKSPACE_DIR>
```

## Initialize with a VotingWorks definition

```
./scripts/initialize-election.sh <WORKSPACE_DIR> <vx_definition_file> 
```

## Generate keypair

```
./scripts/generate-keypair.sh <WORKSPACE_DIR> 
```

## Generate and Encrypt Ballots

```
./scripts/generate-and-encrypt-ballots.sh <WORKSPACE_DIR> <num_ballots>
```

This will output the encrypted ballot, which should be written to a file.

## Proof of Concept of Mixnet

```
./scripts/shuffle-proof-of-concept.sh <WORKSPACE_DIR> <directory_of_encrypted_ballots>
```

This will extract the first ciphertext from each encrypted ballot and pass them through a verificatum mixnet configured with the right public key.

## Homomorphically Tally Ballots

```
./scripts/tabulate-encrypted-ballots.sh <WORKSPACE_DIR> <directory_of_encrypted_ballots>
```

This will return the tally JSON, which should be written to a file

## Decrypt the Tally

```
./scripts/decrypt-encrypted-tally.sh <WORKSPACE_DIR> <encrypted_tally_file>
```

## 

# Old stuff

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

## Encrypt a Ballot

We have to use the initialized configuration now, coming out of the key ceremony.

Start the server

```
java \
  -classpath ${EG_HOME}/encryptserver/build/libs/encryptserver-all.jar \
  electionguard.webapps.server.RunEgkServerKt \
  --inputDir testOut/cliWorkflow/keyceremony \
  --outputDir testOut/encrypt/RunEgkServer
```

Encrypt a ballot against the server

```
java \
  -classpath ${EG_HOME}/encryptclient/build/libs/encryptclient-all.jar \
  electionguard.webapps.client.RunEgkClientKt \
  --inputDir testOut/cliWorkflow/keyceremony \
  --outputDir testOut/encrypt/RunEgkServer
```

## Accumulate the Tally

```
java \
  -classpath ${EG_HOME}/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunAccumulateTally \
    -in testOut/encrypt/RunEgkServer \
    -out testOut/encrypt/RunEgkServer 
```

## Run Tally Decryption

```
java \
  -classpath ${EG_HOME}/egklib/build/libs/egklib-all.jar \
  electionguard.cli.RunTrustedTallyDecryption \
    -in testOut/encrypt/RunEgkServer \
    -trustees testOut/cliWorkflow/keyceremony/trustees \
    -out testOut/encrypt/RunEgkServer 
```

