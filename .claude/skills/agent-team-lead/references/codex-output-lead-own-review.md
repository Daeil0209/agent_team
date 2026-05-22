---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "procedure/evidence-over-memory; stale-basis-correction; consumed-surface; minimum-executable-information; configured-review-result; same-pass-own-review; convergence-adjudication"
---
# team-lead: Configured-Review Output Lead Own-Review Discipline

## Purpose
Configured independent-review result is evidence only; consume this reference before team-lead uses configured-review or same-boundary correction result for freeze, convergence, relay, completion, carry-forward, or redispatch.

## Consume When
- Configured independent-review result shapes planning, artifact judgment, review, redesign, or correction.
- A same-boundary correction pass repeats after configured-review input.
- Team-lead is about to accept configured-review consensus, relay configured-review result, freeze from it, claim convergence from it, carry forward prior own-review, complete from it, or redispatch from it.

## Required Output
Record:
- configured-review pass identity
- same-pass team-lead own-review basis
- material skill/reference basis consumed for accepted, rejected, and unresolved points
- accepted configured-review points
- rejected configured-review points
- unresolved configured-review gaps

## Routing Gate
Freeze, convergence, completion, or redispatch from configured-review result requires same-pass team-lead own-review.
Configured-review agreement requires a governing reference that permits agreement rather than fail-open only.
Relay requires team-lead adjudication of the result.
Defect, patch-worthiness, patch-readiness, removal, or correction-priority claims require current `Skill(review-verification)` promotion basis.

## Resolve Next Owner And Action
- A freeze, convergence, completion, or redispatch gap opens same-pass team-lead own-review.
- A configured-review agreement gap opens governing-reference check.
- A relay gap opens team-lead adjudication.

## Rules
- Treat every same-boundary correction pass as a new configured-review pass.
- Satisfy own-review only with same-pass team-lead defect-seeking review that names accepted points, rejected points, and unresolved gaps.
- Treat prior-pass own-review as non-current context.
- Team-lead plan/design/redesign, own-review, and reconciliation consume only material skill/reference basis needed to classify configured-review points before freeze, convergence acceptance, completion, or redispatch.
- Carry-forward, landing confirmation, spot-check, relay, and consensus wording do not satisfy same-pass own-review.
- Lawful fail-open applies only when the owning reference names it.
