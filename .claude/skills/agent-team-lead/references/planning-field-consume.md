---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "request-fit; design-intent; frozen-planning-fields; route-continuity; lead-only-fact-transfer-readiness"
---
# team-lead: Planning Field Consume

## Purpose
Consume only the frozen planning fields needed for the current next owner/action before local execution, dispatch, phase movement, or reporting-law-admitted user-facing prose.
Stop the current action when the consumed plan no longer supports it.

PROTECTED-LOCAL-RESTATEMENT-BASIS: planning-consumption atomic-check — Reaction Rules, Cross-Continuity, and Lead-Only Context Guard colocated for atomic team-lead consultation at pre-dispatch and per planning-field consumption. Destinations (`.claude/skills/work-planning/references/cross-continuity.md`, `.claude/skills/task-execution/references/assignment-packet.md` Cross-Continuity Packet Check, `.claude/skills/work-planning/references/planning-record-fields.md`) are trigger-loaded; this surface preserves dispatch-readiness check atomicity by naming the consumed owners instead of restating their item sets.

## Consume When
- A local execution path, workflow, sequence, dispatch, or reporting-law-admitted user-facing prose depends on frozen `work-planning` fields.
- `TEAM-LEAD-WORK-PLAN`, `NEXT-CONSEQUENTIAL-ACTION`, route class, claim ceiling, readiness, continuity, or lead-only fact-transfer readiness can change the next action.
- A consumed field is missing, stale, contradictory, or weaker than the governing floor.

## Consumption Result
Record only the material result needed by the active owner:
- consumed field basis
- blocking field and reason
- next executable owner/action

## Decision Gate
- Execute only when every consumed field required by the current next owner/action is current, noncontradictory, and at or above the floor.
- Reopen `work-planning` when the current action lacks a frozen planning basis or the consumed basis no longer supports the action.
- Apply `Cross-Continuity` before `task-execution`.
- Apply `Lead-Only Context Guard` before team-agent runtime dispatch.

## Resolve Next Owner And Action
- Passing consumption returns to the active next owner/action.
- Missing, stale, contradictory, or weaker-than-floor consumed fields reopen `work-planning`.
- Cross-continuity gaps reopen `work-planning`.
- Lead-only context gaps block dispatch and route through `Lead-Only Context Guard`.

## Canonical Field Ownership
Consume field order, allowed values, required conditions, `not-applicable` bases, field floors, and triggered field-owner references through `.claude/skills/work-planning/references/planning-record-fields.md` `## Allowed Values`.
This reference does not redefine planning-field meaning.
Consumer surfaces use the canonical field owner, then act on the consumed result.

## Reaction Rules
- Preflight floor applies only to fields inside the current owner path.
- Fields outside every current local execution, workflow, sequence, dispatch, or reporting-law-admitted user-facing prose owner stay outside `work-planning` reopening.
- Team-lead decision basis is the consumed frozen scope, route, owner map, proof chain, acceptance chain, parallel-fit basis, and active-route mandatory fields.
- Downstream expansion stays inside the consumed basis; moved scope, owner, proof, acceptance, route, or claim boundary reopens `work-planning`.
- A consumed field whose canonical floor does not support the selected route class, owner choice, next action, reporting-law gate, blocker-routing, or claim strength reopens `work-planning`.
- Consume `TEAM-LEAD-WORK-PLAN` only when local execution, dispatch, synthesis, reporting-law-admitted user-facing prose, or termination depends on it.
- `NEXT-CONSEQUENTIAL-ACTION` must trace to the first executable row of `TEAM-LEAD-WORK-PLAN`; failed trace reopens `work-planning`.
- Claims stay at or below the consumed `CLAIM-CEILING`; a required stronger claim reopens `work-planning`.
- Frozen tier, configured independent-review, parallel-fit, and execution-readiness fields consume their canonical field owners before staffing, dispatch, checkpoint, review, proof, acceptance, or reporting-law-admitted user-facing prose.
- Pre-`work-planning`, file-only, guessed, unadjudicated, or weaker-than-canonical bases cannot authorize the current action.
- Named `ACTIVE-WORKFLOW` opens the workflow owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- Active `ACTIVE-SEQUENCE` opens the sequence owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- `EXECUTION-READINESS-BASIS` that is missing or blocked reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a verified same-route blocker-clear move.

## Cross-Continuity
Before `task-execution`, apply `.claude/skills/work-planning/references/cross-continuity.md` for the full active cross-continuity item set.
For assignment-grade dispatch, also apply `.claude/skills/task-execution/references/assignment-packet.md` `## Session Cross-Continuity Packet Check`.

Missing cross-continuity basis reopens `work-planning`.
Contradictory cross-continuity basis reopens `work-planning`.

## Lead-Only Context Guard
Before team-agent runtime dispatch, confirm receiving lanes have or will receive every material lead-context fact through a governed transfer path.
Material facts travel as:
- packet fields
- task state
- workflow state
- cited artifacts
Missing material fact transfer blocks dispatch and opens packet-field correction inside `task-execution` when `task-execution` is active or is the frozen `NEXT-CONSEQUENTIAL-ACTION`.
Missing material fact transfer reopens `work-planning` when `task-execution` is not active or frozen next, or when the missing fact changes scope, owner, route, proof, acceptance, or claim boundary.
