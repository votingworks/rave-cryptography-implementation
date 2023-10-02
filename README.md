# RAVE ElectionGuard Client

This is a client of the electionguard library for RAVE purposes.

## Install Basics

This is for Linux.

- Get Java 17

```
sudo apt install openjdk-17-jre
```

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

## Homomorphically Tally Ballots

```
./scripts/tabulate-encrypted-ballots.sh <WORKSPACE_DIR>
```

This will return the tally JSON, which should be written to a file

## Decrypt the Tally

```
./scripts/decrypt-tally.sh <WORKSPACE_DIR>
```

## Shuffle the Ciphertexts

```
./scripts/shuffle-ciphertexts.sh <WORKSPACE_DIR>
```

This extracts only the ciphertexts from ElectionGuard encrypted ballots (no proofs), and passes them through the Verificatum Mixnet.


## Plaintext Equivalence Proof

coming soon.


