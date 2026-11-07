# Run the Friday launch exercise

This is a fictional example, not a real customer commitment. See the [README](README.md) for prerequisites and template import. The steps below describe the expected interactions; for a recorded live run, see [`evidence/round-d-transcript.md`](evidence/round-d-transcript.md). Responses can vary.

## People and preparation

The learner creates the room with the default `commitment` prefix. Add a second person to the room as mentor; they play the engineering lead. The template adds only its creator. If one person acts in both roles, label mentor messages as role-played. Both agents must be running and addressable.

## Round A: limited Friday option

1. If needed, the learner sends `@commitment-stakeholder Start the Friday launch exercise.`
2. The stakeholder asks whether Sales can confirm the full integration for Friday, May 15.
3. The learner asks the mentor what engineering can deliver.
4. The mentor independently answers, for example: `Mentor: A CSV export is possible May 15; the full integration needs May 22.`
5. The learner addresses `@commitment-stakeholder` and asks Sales to react. The stakeholder should reflect the mentor's actual input and identify that the customer has not confirmed whether CSV is acceptable.
6. The learner proposes: `Sales will ask the customer today whether CSV works; engineering will prepare CSV for May 15 and propose the full integration for May 22.` The learner asks the mentor and stakeholder to confirm or revise the parts they control.
7. The learner sends `@commitment-coach Debrief this round and make a commitment record.` Review its output against the messages. In particular, customer acceptance is unresolved unless explicitly supplied by a participant representing the customer.

The response to an agent must address it by the name created by the template. A non-mention may be visible as context without prompting a reply. The mentor's statements and stakeholder responses are fictional; no real message or commitment to Acme is made.

## Round B: no Friday option

For the cleanest comparison, create a new room from the template using a different prefix of at most 10 characters, such as `commit-b`, and address the newly created agent names. A repeated template run with the same prefix would collide with the existing agent names. Alternatively, explicitly mark a new round and verify that the agents do not carry the prior round's constraint forward.

Repeat the scenario, but have the mentor independently give a different constraint: `Mentor: Neither CSV nor the full integration is available before May 22.` The learner asks the stakeholder to react and proposes a new plan, then requests a coach debrief.

## Acceptance checklist

- The stakeholder reflects the latest mentor input; it does not speak for the mentor or invent customer agreement.
- The proposed plan and coach's record reflect the current round, including any missing owner, date, or response.
- The coach cites actual messages and makes specific, non-judgmental observations. It does not present its feedback as a validated score.
- If the mentor does not respond, engineering feasibility remains unknown.
- The two rounds differ appropriately. If not, document the failure and refine the instructions; this is a human-reviewed check, not a guarantee about model behavior.
