---
name: team-meeting
description: Run a critical marathon meeting for an operator-provided agenda. Team-lead drafts an audit-applied solution. Participants deliver critical improvement opinions. Drafter iterates persuasive best-current solutions until every item reaches unanimous participant consent and any explicitly required operator decision is captured.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

## 1. Purpose
Run a critical marathon meeting for the operator's agenda.
Turn the agenda into a fully consensus-converged solution through drafter writing and critic opinion.
Keep procedures on `task-execution`, `Skill(governance-modification)`, or other named procedure paths throughout the meeting.
Require unanimous participant consent for every solution item before downstream routing.
End the meeting after full consent opens the named downstream owner/action, unless the agenda explicitly requires operator acceptance.
Drafter treats dissent as solution material.
Drafter converts every material objection before blocker-routing.
Drafter converts objections through a revised solution item, evidence-backed persuasive rationale, or bounded operator-choice tradeoff.
Drafter continuously proposes the current best persuasive solution for each unresolved objection.
Drafter continues until the objection is satisfied, narrowed to a valid tradeoff with a best-current executable recommendation, or routed to the next internal owner/action with evidence.

## 2. Participants
Drafter is fixed as `team-lead`.
Drafter writes the solution draft.
Drafter integrates opinions that name an objection, suggested improvement, and controlling reason or evidence.
Drafter states the final recommendation.
Critics read the draft from a critical stance.
Critics provide improvement opinions.
The meeting keeps the fixed drafter and at least one critic.
Operator-specified critic roles apply when provided at meeting opening.
Drafter assigns available fitting critics or uses the current participants when the operator does not specify critic roles.

All participants use review-verification-derived critique criteria as bounded critical thinking.
Participants use those criteria to find defects, risks, missing evidence, boundary problems, and better alternatives.
Treat critique coverage as meeting critique coverage, not formal `Skill(review-verification)` consumption.
Keep final acceptance, mutation rules, and full-workflow checks on their named procedure paths.
The criteria operate as free-form critical thinking during the meeting.
Use the standalone `Skill(review-verification)` workflow and current Step 14 packet for formal skill-consumption claims, `review_verification_packet`, verdict table, and review record outputs.
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
Drafter resolves derivable agenda or desired-result ambiguity with evidence-backed reversible defaults before any clarification request.
Drafter asks for clarification only for irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blockers after internal defaults and recovery routes are exhausted.
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
Drafter accepts an opinion regardless of delivery shape when it names an objection, suggested improvement, and controlling reason or evidence.
Drafter accepts opinions in free-form delivery.

Critics work in parallel when team-agent runtime is active with `ACTIVE-CONCURRENT-AGENT-CAP` at or above critic count and the live process-backed roster includes all critic lanes.
Each critic delivers opinions independently.
Apply serial waiting when a critic's opinion depends on another critic's evidence.
Forced single-lane execution despite available parallel runtime fit — "serial convenience" — is a bottleneck defect.

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
The marathon default continues until full consent on every item or until a default cap is reached.
Default round cap is five rounds; when full consent is not reached within the cap, drafter records objection-persistence evidence, chooses the best-current upper-philosophy-compliant executable solution or next internal owner/action, and uses blocker-routing only for unresolved correctness blockers after every executable internal resolution route is exhausted.
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
- functional-independence
- comprehension-as-execution-force

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
Operator-set round limit reached before full consent records the best-current executable recommendation, unresolved objection evidence, and next internal owner/action.
Use blocker-routing only when an unresolved correctness blocker cannot be resolved by revision, evidence gathering, critic reassignment, route correction, or lawful downstream owner review.
Blocker-routing owner is drafter.
Blocker-routing basis is the exact unresolved correctness blocker and exhausted internal route.
Blocker-routing next safe owner/action is the smallest internal evidence, revision, review, or downstream procedure step that can still advance the agenda.

### 3-7. Operator Gate
Operator gate runs only when the agenda explicitly requires operator acceptance, operator choice, or operator modification before downstream execution.
Without an explicit operator-gate basis, drafter records the final solution in the compact draft format and opens the named downstream owner/action per Section 4-1.
When the operator gate is active, drafter presents the final solution in the compact draft format.
Operator accept opens the named downstream owner/action per Section 4-1.
Operator reject with reason reopens the smallest affected step.
Operator modification request updates the agenda or draft.
Operator-unclear response triggers one clarification request only when the response controls an irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker.
An explicitly required operator-owned action that remains absent uses blocker-routing only after no reversible default, internal owner route, or safe downstream review can advance the agenda.
Blocker-routing owner is drafter.
Blocker-routing basis is the exact required operator-owned action.
Blocker-routing next safe owner/action is the preserved resume owner/action after the operator-owned action arrives.

## 4. Downstream Owner & Recovery

### 4-1. Downstream Owner
File mutation, implementation execution, test execution, and final acceptance happen at the named downstream owners below.
Governance mutation routes to `Skill(governance-modification)`.
Implementation routes to `developer`.
Evidence gathering routes to `researcher`.
Proof routes to `tester`.
Final acceptance routes to `validator`.
Dispatch to separate agents routes through `Skill(task-execution)`.

### 4-2. Recovery
Pre-existing monologue output becomes the first solution draft.
Treat missing agent runtime as material when separate participants must run as agents.
Idle participant receives one prompt containing the current draft and requested opinion.
Sustained idle triggers critic reassignment, remaining-critic continuation when coverage is still sufficient, or blocker-routing only when the named participant's missing opinion is required for the agenda's correctness.
Blocker-routing owner is drafter.
Blocker-routing basis is the named idle participant's required missing opinion and exhausted reassignment/continuation route.
Blocker-routing next safe owner/action is participant recovery, critic reassignment, or the smallest downstream review step that can still test the issue.
Out-of-turn content is treated as an opinion for the next revision.

## 5. Resolve Next Owner And Action
Each transition below opens the next owner/action in the same turn per `.claude/CLAUDE.md` `## 5. Modification Philosophy` `upper-lower execution-drive`.

- Agenda clear → Section 3-3 Solution Draft.
- Agenda ambiguous → reversible default, internal basis recovery, or clarification only for proven user-owned blocker.
- Draft ready → Section 3-4 Opinion Round.
- Opinions received → drafter revision.
- Material objection remains → dissent-to-solution conversion in Section 3-4.
- Material objections cleared → Section 3-5 MEETING-AUDIT-CRITERIA.
- MEETING-AUDIT-CRITERIA passed → named downstream owner per Section 4-1, or Section 3-7 Operator Gate only when explicitly required.
- Operator accept when operator gate is active → named downstream owner per Section 4-1.
- Operator reject or modify → smallest affected step.
- Correctness blocker unresolved → next opinion round, evidence gathering, critic reassignment, downstream review, or blocker-routing after internal routes are exhausted.
- Operator-set round limit reached before full consent → best-current executable recommendation or blocker-routing per Section 3-6.
- Governance mutation need → `Skill(governance-modification)`.
- Separate-agent dispatch need → `Skill(task-execution)`.
- Unlisted blocker → blocker-routing with owner, blocker, exhausted internal recovery basis, and next safe owner/action.
