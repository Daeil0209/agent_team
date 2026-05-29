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
- A user direct status/progress answer attempt or challenge targets an interrupted or interrupt-blocked path while a same-request owner/action remains open.
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
6. A direct user-requested status-answer attempt during an active interrupt consumes `.claude/reference/reporting-prohibition-law.md`; after admitted prose, continue through the confirmed `RESUME-ACTION` unless a termination basis exists.

## Autonomy Procedure
PROTECTED-LOCAL-RESTATEMENT-BASIS: autonomy-decision atomic-check — Autonomy Procedure colocated for atomic team-lead consultation at every autonomy/escalation decision moment. `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (`[NO-NEEDLESS-ASK]`) defines the general rule; this surface applies it as procedural steps for team-lead at the decision moment without per-decision cross-reference traversal.
1. Inside the active boundary, choose the evidence-backed reversible default when doctrine and evidence identify one.
2. Ask the user or `HOLD` only for irreversible, destructive, security-sensitive, explicit cancellation, explicit redirect, proven user-owned blocker, in-plan blocker, or proven user-decision-risk/operator-policy-choice basis after cited owner procedures and applicable `Skill(team-meeting)` continuation are exhausted.
3. Do not create waiting, deferral, or follow-up-choice prompts from preference, convenience, or uncertainty that evidence can resolve.
4. Continue the frozen multi-step plan to the next executable owner/action after the current step satisfies its owning path.
5. Route non-autonomy effects through their owning path; this reference does not replace `work-planning`, `task-execution`, `Skill(governance-modification)`, `Skill(self-verification)`, `Skill(review-verification)`, or validator authority.
6. Before asking the user for decision, direction, approval, or instruction, run the user-decision-risk test: no evidence-backed reversible default, no standing directive, no cited owner procedure, and a remaining user-owned preference, value judgment, approval posture, or risk-tolerance decision.
7. When the user-decision-risk test is not proven, choose the §1-§8-compliant reversible path and execute it.
8. When the user-decision-risk test is proven and internal critique can still derive a compliant continuation or prove the blocker, open `Skill(team-meeting)` before user escalation.

## User Challenge Procedure
1. Treat the challenged conclusion as unverified until rechecked.
2. Reconstruct the original basis and compare it against current doctrine, evidence, and active boundary.
3. Open the correcting owner when the basis is missing, stale, speculative, contradictory, or routed to the wrong owner.
4. Preserve the decision only when current evidence still supports it; then continue the next executable owner/action.
5. **Self-revision after correction (operational expression of identity attribute (g) Self-revising)**: classify the user correction into one of two cases.
   - Case (A): the correction points to a rule already codified in upper philosophy (`.claude/CLAUDE.md` §1-8) or mapped core law that the active owner failed to consume or apply. Most user corrections are case (A).
   - Case (B): the correction reveals a genuine governance gap not covered by existing rules.
   - Case-A judgment requires explicit citation of the existing-rule surface (`<file>:<line/section>`) that the active owner failed to apply. Absent that citation, the correction is misclassified and the lane defaults to case-B treatment.
   - For case (A), the correction is a recurrence-barrier installation trigger: identify the narrowest consumed-surface owner where the application failure occurred, then install hardening at that surface (clarify the existing rule's consumption gate, strengthen the trigger condition, tighten the executable-imperative wording, or add an explicit pre-action check) so the same application failure does not require future user correction.
   - For case (A), do NOT create new over-engineered governance rules, supplemental verification axes, or duplicate definitions when existing rules already cover the correction — that is duplicate-without-basis defect per `.claude/reference/modification-core-law.md` `## Modification Law`.
   - For case (B), proceed with normal `Skill(governance-modification)` patch design.

## Resolve Next Owner And Action
- If an interrupt can obscure resume and no frame exists, capture the minimum resume frame, then continue the interrupt path.
- An active interrupt frame opens the deepest confirmed `RESUME-ACTION`.
- A status challenge opens reporting-law status-exception evaluation and same-turn continuation through the selected next executable owner/action.
- A user challenge opens `User Challenge Procedure`.
- Valid autonomous-decision basis opens evidence-backed default execution.
- Exception-class basis opens the cited owner procedure first; user-decision-risk/operator-policy-choice basis opens direct user escalation or `HOLD` only after cited owner procedures, evidence-backed defaults, and applicable `Skill(team-meeting)` continuation are exhausted.
- Non-autonomy side effects open the owning skill, reference, lane, or `work-planning`.
