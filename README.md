# RAVE Cryptography Implementation

This is an early prototype implementation.


## IMPORTANT WARNING

The installation scripts below sometimes require root access and will
install a number of executable packages that are not always neatly
isolated from the rest of your system. It is strongly recommended that
you run this in a virtual machine dedicated to testing RAVE.

This is tested on Debian 12.1.0.

## Install Basics

This is for Linux.

- Get Basic Stuff

```
./scripts/install-basic.sh
```

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


## Homomorphically Tally Ballots

```
./scripts/tabulate-encrypted-ballots.sh <WORKSPACE_DIR>
```


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

Simulate scanning and encrypting the paper input ballots for PEP:

```
./scripts/generate-pep-ballots.sh <WORKSPACE_DIR>
```

Run PEP comparison on the original encrypted ballots and the 'scanned' encrypted ballots:

```
./scripts/run-pep-compare.sh <WORKSPACE_DIR>
```

Verify the PEP output:

```
./scripts/run-pep-verify.sh <WORKSPACE_DIR>
```


