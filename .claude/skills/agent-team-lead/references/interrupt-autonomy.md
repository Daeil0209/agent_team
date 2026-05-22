---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "resume-frame; no-needless-ask; challenge-recheck; exception-escalation; continuation"
---

# team-lead: Interrupt And Autonomy

## Purpose
Preserve the live same-request owner path through interrupts.
Execute evidence-backed reversible defaults inside the active boundary without needless user queries.
Recheck challenged conclusions before correction or preservation.

## Consume When
- A live same-request task is interrupted by correction, governance mutation, runtime housekeeping, cleanup, or user-corrective input.
- A user status/progress question or challenge targets an interrupted or interrupt-blocked path while a same-request owner/action remains open.
- The user explicitly delegates autonomy, grants pre-approval, asks for stabilization without stopping, or frames sustained autonomy.
- Team-lead would ask for choice, permission, direction, sequencing, continuation, or waiting state inside existing authority.

## Record
Record only the active row for the current trigger.
- Resume frame: resume target, last safe state, `RESUME-OWNER`, `RESUME-CONDITION`, executable `RESUME-ACTION`, and `RECOVERY-EVIDENCE`.
- Autonomy basis: active boundary, evidence-backed default, exception check, and next owner/action.
- Challenge basis: challenged conclusion, original basis, rechecked evidence, and correction-or-preservation action.
- Termination basis: explicit cancellation, explicit redirect, or proven user-owned blocker.

## Interrupt Resume Procedure
1. Capture the resume frame before an interrupt can obscure the original owner path.
2. Keep the original task as resume target until convergence, explicit cancellation, explicit redirect, or proven user-owned blocker.
3. Resolve nested interrupts LIFO.
4. After interrupt convergence, confirm `RESUME-CONDITION` against `RECOVERY-EVIDENCE`, then execute `RESUME-ACTION`.
5. Reopen `work-planning` only when the interrupt changed owner, surface, deliverable, route, proof/acceptance chain, staffing, or user requirement.
6. Status prose during an active interrupt consumes `.claude/reference/reporting-prohibition-law.md`; after admitted prose, continue through the confirmed `RESUME-ACTION` unless a termination basis exists.

## Autonomy Procedure
1. Inside the active boundary, choose the evidence-backed reversible default when doctrine and evidence identify one.
2. Ask the user or `HOLD` only for irreversible, destructive, security-sensitive, operator-policy-choice, explicit cancellation, explicit redirect, proven user-owned blocker, or in-plan blocker basis.
3. Do not create waiting, deferral, or follow-up-choice prompts from preference, convenience, or uncertainty that evidence can resolve.
4. Continue the frozen multi-step plan to the next executable owner/action after the current step satisfies its owning path.
5. Route non-autonomy effects through their owning path; this reference does not replace `work-planning`, `task-execution`, `Skill(governance-modification)`, `Skill(self-verification)`, `Skill(review-verification)`, or validator authority.

## User Challenge Procedure
1. Treat the challenged conclusion as unverified until rechecked.
2. Reconstruct the original basis and compare it against current doctrine, evidence, and active boundary.
3. Open the correcting owner when the basis is missing, stale, speculative, contradictory, or routed to the wrong owner.
4. Preserve the decision only when current evidence still supports it; then continue the next executable owner/action.

## Resolve Next Owner And Action
- If an interrupt can obscure resume and no frame exists, capture the minimum resume frame, then continue the interrupt path.
- An active interrupt frame opens the deepest confirmed `RESUME-ACTION`.
- A status challenge opens admitted status exposure and same-turn continuation through the selected next executable owner/action.
- A user challenge opens `User Challenge Procedure`.
- Valid autonomous-decision basis opens evidence-backed default execution.
- Exception-class basis opens user escalation or `HOLD` with owner, blocker, and next safe action.
- Non-autonomy side effects open the owning skill, reference, lane, or `work-planning`.
