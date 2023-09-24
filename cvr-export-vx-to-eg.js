
const fs = require('fs');

const [electionDefinitionPath, cvrInputPath, cvrOutputPath] = process.argv.slice(3);

if (!electionDefinitionPath || !cvrInputPath || !cvrOutputPath) {
  console.error("Please provide a VotingWorks election def, a VotingWorks CVR, and an output path for the EG CVR.");
  process.exit(1);
}

const electionDef = JSON.parse(fs.readFileSync(electionDefinitionPath, 'utf-8'));
const inputCvr = JSON.parse(fs.readFileSync(cvrInputPath, 'utf-8'));

const egCvr = {
	ballot_id: "foobar",
  ballot_style: "FILL IN",
  contests: electionDef.contests.map((contest, contest_num) => {
    return {
      contest_id: `contest-${contest.id}`,
      sequence_order: contest_num,
      electoral_district_id: `district-${contest.districtId}`,
      vote_variation: "one_of_m",
      number_elected: contest.seats,
	votes_allowed: contest.seats,
	name: `contest-${contest.id}`,
      ballot_selections: contest.candidates.map((cand, cand_num) => {
        return {
          object_id: `cand-${cand.id}`,
          sequence_order: cand_num,
          candidate_id: `cand-${cand.id}`,
        };
      }),
      ballot_title: contest.title,
      ballot_subtitle: contest.section,
    }
  }),
  ballot_styles: vxElectionDefinition.ballotStyles.map(ballotStyle => {
    return {
      object_id: `ballot-style-${ballotStyle.id}`,
	geopolitical_unit_ids: ballotStyle.districts.map(d => `district-${d}`),
      party_ids: [`party-${ballotStyle.partyId}`],
      image_url: null
    };
  }),
  name: [],
  contact_information: {
    address_line: [],
    email: null,
    phone: "",
    name: "contact",
  }
}

fs.writeFileSync(outputFilePath, JSON.stringify(egElectionDefinition, null, 2));
