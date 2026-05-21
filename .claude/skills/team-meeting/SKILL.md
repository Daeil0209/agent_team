---
name: team-meeting
description: Own a critical marathon meeting for an operator-provided agenda. Team-lead drafts an audit-applied solution. Participants deliver critical improvement opinions. Drafter iterates persuasive best-current solutions until every item reaches unanimous participant consent and operator acceptance.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

## 1. Purpose
Own a critical marathon meeting for the operator's agenda.
Turn the agenda into a fully consensus-converged solution through drafter writing and critic opinion.
Keep procedures owned by `task-execution`, `Skill(governance-modification)`, or other named owners with those owners throughout the meeting.
Require unanimous participant consent for every solution item before the operator gate.
End the meeting after full consent and operator acceptance.
Drafter treats dissent as solution material.
Drafter converts every material objection before `HOLD`.
Drafter converts objections through a revised solution item, evidence-backed persuasive rationale, or bounded operator-choice tradeoff.
Drafter continuously proposes the current best persuasive solution for each unresolved objection.
Drafter continues until the objection is satisfied, narrowed to a valid tradeoff, or escalated with evidence.

## 2. Participants
Drafter is fixed as `team-lead`.
Drafter writes the solution draft.
Drafter integrates useful opinions.
Drafter states the final recommendation.
Critics read the draft from a critical stance.
Critics provide improvement opinions.
The meeting keeps the fixed drafter and at least one critic.
Operator specifies which agents fill the critic roles at meeting opening.

All participants use `Skill(review-verification)` as a bounded critical lens.
Participants use the lens to find defects, risks, missing evidence, owner-boundary problems, and better alternatives.
Treat lens authority as bounded critique authority.
Keep final acceptance, mutation authority, and full-workflow authority with their named owners.
The lens operates as free-form critical thinking during the meeting.
Use the standalone `Skill(review-verification)` workflow for formal `review_verification_packet`, verdict table, and review record outputs.
Default lenses: `design-intent-lens`, `coherence-integrity-lens`, `owner-boundary-lens`.
Use `patch-worthiness-lens` when the agenda is a governance-patch solution.
All participants use Section 3-5 `MEETING-AUDIT-CRITERIA` as the shared evaluation standard for drafts, opinions, revisions, consent, and operator-gate readiness.

## 3. Meeting Procedure

### 3-1. Activation
Activate when the operator explicitly asks for a meeting.
Activate when the operator's agenda needs critical improvement from more than one perspective.
Use the clear single-owner action when it already solves the request.

### 3-2. Agenda
Drafter freezes the operator's agenda as `MEETING-AGENDA`.
Drafter records the desired result as `TARGET-OUTCOME`.
Drafter asks for clarification when the agenda or desired result is materially ambiguous.
Operator agenda change re-freezes `MEETING-AGENDA`.
A re-frozen agenda restarts the procedure from Section 3-3.

### 3-3. Solution Draft
Drafter writes one solution draft.
Drafter applies Section 3-5 `MEETING-AUDIT-CRITERIA` while drafting the initial solution from the operator's agenda.
Treat the initial draft as the drafter's first audit-applied best solution.
The draft's SOLUTION may contain multiple items.
Each item is independently identifiable and independently iteratable.
Use the default template below.
Reduce the template when the agenda clearly needs less.
```
AGENDA:
SOLUTION:
WHY THIS SOLVES IT:
MAIN RISKS OR TRADEOFFS:
NEXT ACTION:
```
The draft is concrete enough that the next owner can act.

### 3-4. Opinion Round
Participants deliver opinions to the drafter.
An opinion targets the whole draft or a specific solution item.
Critic opinion is sufficient when the drafter can identify the objection, suggested improvement, and controlling reason or evidence.
Critics evaluate the draft and each proposed revision against Section 3-5 `MEETING-AUDIT-CRITERIA`.
Critics name the failed audit criterion when that criterion controls the objection.
Drafter accepts a useful opinion regardless of its shape.
Drafter accepts opinions in free-form delivery.

Critics work in parallel when runtime support exists.
Each critic delivers opinions independently.
Apply serial waiting when a critic's opinion depends on another critic's evidence.
Serial convenience over independent opinions is a bottleneck defect.

Drafter reads all opinions together.
Drafter revises the draft once per round when possible.
Drafter keeps a brief basis when rejecting a material objection or improvement.
Drafter triggers pairwise debate when a direct contradiction blocks solution correctness.
Drafter answers each unresolved objection by proposing the best-current persuasive solution.
Drafter uses discussion requests to obtain evidence.
Drafter uses discussion requests to resolve a direct contradiction.
Drafter converts every remaining material objection into a persuasion target before the next round.
Persuasion target options:
- revise the item so the objection is satisfied.
- add evidence-backed rationale showing why the current item already satisfies the objection.
- narrow the conflict into operator-choice tradeoff options when valid goals conflict.
The next round tests the converted solution or rationale.
Repeated objection advances through changed solution content, changed evidence, or clearer tradeoff framing.

Operator may set an opinion-round limit at meeting opening.
The marathon default continues until full consent on every item.
Per-item iteration closes after every critic clears material objections on that item.

### 3-5. MEETING-AUDIT-CRITERIA
This section is the meeting's audit regulation.
Every participant can identify it by the section title `MEETING-AUDIT-CRITERIA`.
Drafter checks every criterion below before publishing the initial draft.
Drafter checks every criterion below before accepting a revised item as consent-ready.
Drafter checks every criterion below before presenting the solution.
Critics use the same criteria when challenging, accepting, or proposing improvements.

Operator-emphasized meeting compliance criteria — solution passes every keyword per `.claude/CLAUDE.md` `## 5. Modification Philosophy`:
- removal-first
- consumed-surface
- no-compression
- upper-lower execution-drive
- executable-imperative
- minimum-executable-information

No-compression source:
- Apply `CLAUDE.md` `no-compression` definition when deciding whether a sentence is an allowed same-subject repeated-pattern line or a prohibited bundled clause.

Solution essentials:
- agenda fit: solution answers `MEETING-AGENDA` and `TARGET-OUTCOME`.
- simplicity: solution keeps necessary procedure, packet, role, and gate elements.
- correctness: material risks, assumptions, and evidence gaps are named.
- feasibility: the `NEXT ACTION` names an executable owner/action.
- bottleneck control: independent review or execution keeps parallel order unless evidence dependency requires serial order.

Any failed criterion returns the solution to revision before Section 3-6 convergence.

### 3-6. Convergence
Marathon convergence requires unanimous participant consent for every solution item.
A remaining material objection on any item triggers dissent-to-solution conversion before further opinion rounds on that item.
Record each remaining non-blocking tradeoff briefly per item.
Operator-set round limit reached before full consent records `HOLD`.
HOLD owner is drafter.
HOLD blocker is items lacking consent.
HOLD next-safe-evidence-step is operator adjudication.
Treat `HOLD` as escalation.
Reopen the meeting when the operator directs continuation.

### 3-7. Operator Gate
Drafter presents the final solution to the operator in the compact draft format.
Operator accept closes the meeting.
Operator accept opens the named downstream owner/action per Section 4-1.
Operator reject with reason reopens the smallest affected step.
Operator modification request updates the agenda or draft.
Operator-unclear response triggers one clarification request from drafter.
Required operator response that remains absent routes to `HOLD`.
HOLD owner is drafter.
HOLD blocker is operator no-response.
HOLD next-safe-evidence-step is operator direction.

## 4. Downstream Owner & Recovery

### 4-1. Downstream Owner
File mutation, implementation execution, test execution, and final acceptance happen at the named downstream owners below.
Accepted governance mutation routes to `Skill(governance-modification)`.
Accepted implementation routes to `developer`.
Accepted evidence gathering routes to `researcher`.
Accepted proof routes to `tester`.
Accepted final acceptance routes to `validator`.
Accepted dispatch to separate agents routes through `Skill(task-execution)`.

### 4-2. Recovery
Pre-existing monologue output becomes the first solution draft.
Treat missing agent runtime as material when separate participants must run as agents.
Idle participant receives one prompt containing the current draft and requested opinion.
Sustained idle routes to `HOLD`.
HOLD owner is drafter.
HOLD blocker is named idle participant.
HOLD next-safe-evidence-step is operator direction.
Out-of-turn content is treated as an opinion for the next revision.

## 5. Resolve Next Owner And Action
Each transition below opens the next owner/action in the same turn per `.claude/CLAUDE.md` `## 5. Modification Philosophy` `upper-lower execution-drive`.

- Agenda clear → Section 3-3 Solution Draft.
- Agenda ambiguous → clarification or `HOLD`.
- Draft ready → Section 3-4 Opinion Round.
- Opinions received → drafter revision.
- Material objection remains → dissent-to-solution conversion in Section 3-4.
- Material objections cleared → Section 3-5 MEETING-AUDIT-CRITERIA.
- MEETING-AUDIT-CRITERIA passed → Section 3-7 Operator Gate.
- Operator accept → named downstream owner per Section 4-1.
- Operator reject or modify → smallest affected step.
- Correctness blocker unresolved → next opinion round or `HOLD`.
- Operator-set round limit reached before full consent → `HOLD` per Section 3-6.
- `HOLD` escalation with operator continuation → reopen meeting.
- Accepted governance mutation need → `Skill(governance-modification)`.
- Accepted separate-agent dispatch need → `Skill(task-execution)`.
- Unlisted blocker → `HOLD` with owner, blocker, and next safe evidence step.
