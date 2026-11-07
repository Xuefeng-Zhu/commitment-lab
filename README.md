# Commitment Lab

Practice a difficult workplace conversation with a human mentor and AI agents in a Switch room. A salesperson has promised a customer a Friday integration; the learner must find out what engineering can deliver, negotiate a response, and leave the room with a clear record of what is agreed and what remains open.

The exercise is fictional and self-directed. Its coach offers reflection, not a validated assessment of professional skill.

## How it works

1. **Learner:** starts the exercise, asks questions, and proposes a plan.
2. **Stakeholder agent:** plays Sales and reacts to the learner and mentor.
3. **Human mentor:** plays the engineering lead, supplies an independent constraint, and accepts or revises the engineering portion of the proposal.
4. **Coach agent:** creates a debrief from the actual round, distinguishing agreed, proposed, and unresolved items.

Switch connects these participants in one shared room. The mentor's contribution and subsequent handoffs happen in the room, and the coach uses that conversation as evidence. The room is necessary to this implementation; a different multi-person system or a sufficiently integrated single agent could also support a similar exercise.

## Requirements

- [Switch Console](https://github.com/sandbox-quantum/switch) and a working Switch server, either local or on a remote host. Current Console versions can run a local core server without Docker; Docker is needed for its optional bundled Mattermost, and other versions may differ. See the [official quickstart](https://docs.switchagents.ai/), [remote-host setup](https://docs.switchagents.ai/flintai/switch/deploy/host-remotely), and [hackathon resources](https://www.wemakedevs.org/hackathons/switch/resources).
- An installed, authenticated supported agent provider, such as Codex, Claude Code, or OpenCode. Any provider subscription or API costs are yours.
- A chat bridge configured in Switch and a learner account. For a real mentor, the mentor must also be able to join the chosen room/channel. `{$creator}` in the template adds only the creator.
- Python 3 only if you want to change the instructions and regenerate the template. The ready-to-import template needs no project dependencies.

## Set up the lab

1. Clone this repository. Start Switch Console and start or connect to a Switch server (on your local Docker backend or an onboarded remote host). Ensure a messaging bridge and a signed-in provider are available. Follow the official quickstart for your installed Console version.
2. In Console, open **Templates → Import template**. Choose or paste [`commitment-lab.template.yaml`](commitment-lab.template.yaml), save it to the workspace, then select **Use**.
3. Choose a lowercase name prefix of at most 10 characters, the messaging bridge, and, under advanced settings if necessary, the provider, location and parent working directory. The limit keeps the stakeholder bot name within Mattermost's 22-character username limit. Each agent uses a named folder within the parent directory. Run the template. It requests two agents and a room; the kickoff asks the stakeholder to begin.
4. The template requests a private channel and private Switch room visibility; confirm the bridge and server actually applied both. Add the mentor to the actual room/channel using your Switch and chat-app controls, and grant any Switch room access your deployment requires. The template cannot add a mentor whose identity it does not know. If no second person is available, explicitly label the mentor messages as role-played.
5. Confirm the agents are online and addressable. The template uses `addressing: anyone` so room members and the other agent can address them; use it only in a room whose participants you trust. This setting is not a general guarantee of private data isolation or enforced approvals.

Switch's examples indicate that an agent usually responds when explicitly addressed; a normal room message supplies context but does not necessarily wake it. Use the created names rather than generic role labels, and check the agent's session if it does not respond. Agents starting late need to read earlier messages from the room, which is why the instructions ask them to use `read_context` and handle truncated history. Agent and channel behavior depends on the installed Switch version and bridge.

The recorded live test used one operator playing both human roles. A separate mentor joining through Mattermost has not yet been verified. On the tested server, private Switch room metadata is owner/admin-only; inviting a non-admin to a private Mattermost channel does not establish their Switch Console or metadata access. The tested bridge also ignores messages from its configured Mattermost admin account, so use a different chat identity as mentor. Verify both the mentor's channel participation and any required Switch permissions for your deployment.

### Using an existing server on a VM

For a server bound to the VM's loopback, connect through SSH rather than exposing the services to the internet. First independently verify the VM's current public IP and SSH host key, then use a trusted known-host entry and your own SSH identity. For example, if the existing server really uses VM ports 8000 (API), 3000 (gateway), and 8065 (Mattermost), the following creates separate local forwards; adjust the ports to the actual deployment:

```sh
ssh -N -L 127.0.0.1:38001:127.0.0.1:8000 \
  -L 127.0.0.1:33000:127.0.0.1:3000 \
  -L 127.0.0.1:38065:127.0.0.1:8065 USER@VERIFIED_PUBLIC_IP
```

Keep the tunnel running while using it. Add or select the existing server in Console using the API address `http://127.0.0.1:38001` and sign in with that server's account; older Console/server combinations may ask separately for the gateway address. The tunnel is for the machine running it: a remote mentor needs access to a shared messaging bridge through their own authorized connection, such as a properly configured Discord or Slack bridge, or their own secure tunnel. Do not assume a localhost Mattermost URL is accessible to them.

## Run a round

Names below assume the default `commitment` prefix; replace them if you chose a different prefix. The fictional situation and the mentor's sample constraints are in [`lab/scenario.md`](lab/scenario.md).

1. If the kickoff has not already started the exercise, say: `@commitment-stakeholder Start the Friday launch exercise.`
2. As learner, respond in the room and ask the human mentor for engineering feasibility. Ask `@commitment-stakeholder` to respond to the mentor's input as needed; do not assume an unmentioned agent will reply automatically.
3. The mentor supplies their own constraint, such as: `Mentor: CSV is possible May 15; full integration needs May 22.` These dates are fixed fictional scenario dates, not live delivery promises.
4. Propose a plan with an owner and date. Ask the mentor to confirm or correct the engineering portion, and ask the stakeholder to respond as Sales. Customer acceptance remains unknown unless explicitly supplied by someone representing the customer in this exercise.
5. Say: `@commitment-coach Please debrief this round and make a commitment record.` The agent posts the debrief to the room. Copy it to a file if desired; it is not automatically saved into this repository. [`lab/debrief-template.md`](lab/debrief-template.md) shows the expected sections.

For a complete walkthrough and two comparison rounds, see [`DEMO.md`](DEMO.md).

Do not post real customer information or production credentials in this fictional exercise. Whether an agent may read its environment or use tools depends on its provider and Switch configuration. Agent instructions are guidance, not a security sandbox, and do not enforce approval or prevent external actions.

## Verify that the mentor matters

Start a clearly marked **new round**, or create a fresh room for the cleanest comparison. If running the template again, choose a different prefix so its new agent and room names do not collide; address those new names in the second round. Repeat the conversation with a different mentor constraint: neither CSV nor the integration can be delivered before May 22. Address the stakeholder after the new constraint and the coach after the new proposal.

Check that the stakeholder acknowledges the new constraint, the plan and debrief reflect the current round, and unconfirmed customer acceptance stays unresolved. Try a round with no mentor response: the coach should say the input is missing, rather than inventing it. Model behavior can vary, so review each result; this is a manual acceptance check, not an automated guarantee.

## Files and maintenance

- [`commitment-lab.template.yaml`](commitment-lab.template.yaml): standalone Switch template with embedded agent instructions. It creates agents with separate working directories, so it does not require them to read this checkout.
- [`lab/scenario.md`](lab/scenario.md): fictional scenario and suggested mentor constraints.
- [`lab/stakeholder-instructions.md`](lab/stakeholder-instructions.md) and [`lab/coach-instructions.md`](lab/coach-instructions.md): editable agent instructions.
- [`lab/debrief-template.md`](lab/debrief-template.md): example output format for humans; the coach's embedded instructions specify the required sections.
- [`evidence/round-a-transcript.md`](evidence/round-a-transcript.md): a fictional live test transcript with its single-operator role-play and observed attribution error explicitly identified.
- [`scripts/build_template.py`](scripts/build_template.py): rebuilds the importable template from the editable instructions.

After changing either agent instruction file, run:

```sh
python3 scripts/build_template.py
python3 scripts/build_template.py --check
ruby tests/template_test.rb
```

The template configures behavior with instructions; it does not enforce phases, guarantee model output, validate learning outcomes, or create an external customer commitment. Review the generated template before importing it, and never grant more tool or room access than participants need.
