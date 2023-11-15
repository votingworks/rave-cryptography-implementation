# ~/.bashrc
./scripts/initialize-election.sh working famous-names-election.json
./scripts/generate-keypair.sh working 
./scripts/generate-and-encrypt-ballots.sh working 13
./scripts/tabulate-encrypted-ballots.sh working
./scripts/decrypt-tally.sh working
./scripts/make-mixnet-input.sh working
./scripts/shuffle-ciphertexts3.sh working
./scripts/run-pep-compare.sh working
./scripts/run-pep-verify.sh working

# fetch latest eg library
# cd tools/electionguard/egk-webapps
# git fetch origin
# git rebase -i origin/main
# ./gradlew clean assemble


