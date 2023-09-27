
const fs = require('fs');
const path = require('path');

const [inputDirectory, outputDirectory] = process.argv.slice(2);

if (!inputDirectory || !outputDirectory) {
  console.error("Please provide an input directory of EG ballots, and an output directory of verificatum ciphertexts.");
  process.exit(1);
}

const files = fs.readdirSync(inputDirectory);
const jsonFiles = files.filter(file => path.extname(file) === '.json');

// for each one
jsonFiles.forEach(jsonFile => {
  const fileContents = fs.readFileSync(inputDirectory + "/" + jsonFile, 'utf-8');
  const ballot = JSON.parse(fileContents);

  if (!ballot.ballot_id) {
    return;
  }

  eg_ciphertext = ballot.contests[0].selections[0].encrypted_vote;
  
  verificatum_ciphertext = {
    "alpha": BigInt("0x"+eg_ciphertext.pad).toString(10),
    "beta": BigInt("0x"+eg_ciphertext.data).toString(10)
  };

  const outputPath = outputDirectory + "/verificatum-" + jsonFile;
  fs.writeFileSync(outputPath, JSON.stringify(verificatum_ciphertext));  
});



