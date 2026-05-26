---
name: team-meeting
description: Run a critical marathon meeting for an operator-provided agenda. Team-lead drafts an audit-applied solution. Participants deliver critical improvement opinions. Drafter iterates persuasive best-current solutions until every item reaches unanimous participant consent and operator acceptance.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

## 1. Purpose
Run a critical marathon meeting for the operator's agenda.
Turn the agenda into a fully consensus-converged solution through drafter writing and critic opinion.
Keep procedures on `task-execution`, `Skill(governance-modification)`, or other named procedure paths throughout the meeting.
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
Participants use the lens to find defects, risks, missing evidence, boundary problems, and better alternatives.
Treat lens coverage as bounded critique coverage.
Keep final acceptance, mutation rules, and full-workflow checks on their named procedure paths.
The lens operates as free-form critical thinking during the meeting.
Use the standalone `Skill(review-verification)` workflow for formal `review_verification_packet`, verdict table, and review record outputs.
Default lenses: `design-intent-lens`, `coherence-integrity-lens`, `owner-boundary-lens`.
Use `patch-worthiness-lens` when the agenda is a governance-patch solution.
All participants use Section 3-5 `MEETING-AUDIT-CRITERIA` as the shared evaluation standard for drafts, opinions, revisions, consent, and operator-gate readiness.

## 3. Meeting Procedure

### 3-1. Activation
Activate when the operator explicitly asks for a meeting.
Activate when the operator's agenda needs critical improvement from more than one perspective.
Activate when `.claude/reference/work-execution-core-law.md` `[NO-NEEDLESS-ASK]` convergence-tractable mandate triggers mandatory consumption (hard design decisions — operator-policy-choice surfaces, constitutional-protected surface mutation, or trade-off-bearing patch design — when convergence-tractable form applies per that rule); skipping team-meeting to escalate trade-off choice directly in those cases is a `[NO-NEEDLESS-ASK]` violation per that rule.
Use the clear single-owner action when it already solves the request.
Activate when an active owner detects a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety, after proven-user-owned-blocker pre-test fails); choice-situation activation is unconditionally mandatory per that rule.

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
Drafter maintains a cumulative enumeration of every operator directive issued during the meeting (initial agenda + every operator pre-critic intervention + every operator post-critic-response intervention) and every accepted critic opinion; this enumeration appears in each revised draft as an `OPERATOR-DIRECTIVE COMPLIANCE CHECK` (or equivalent name) section that traces each prior input to its reflection in the current draft.

### 3-4. Discussion Round
The meeting is a discussion among participants, not a drafter-issued assignment with aggregated reports. Drafter and critics are co-discussants: drafter proposes drafts and responds to challenges; critics challenge drafts and respond to drafter and to each other. Treating critics as work-assignees who produce isolated critique reports for drafter consumption is a meeting-form defect that routes the round to redo.

Each discussion round runs against the current draft. Within a round:
- Drafter surfaces the current draft for discussion via carrier reference; the draft itself is the discussion target, not an assignment specification for shaped critic reports.
- Every critic consumes the current draft AND every prior in-round discussion entry (prior critic opinions, drafter responses, evidence pointers) BEFORE adding its own opinion. A critic opinion submitted without consuming prior in-round entries is an isolated-report defect and routes to redo within the same round.
- A critic opinion targets the whole draft, a specific solution item, OR a prior critic opinion or drafter response. Cross-critic dialogue is first-class meeting content, not noise.
- Critic opinion is sufficient when the drafter can identify the objection, suggested improvement, and controlling reason or evidence. Critics name the failed `MEETING-AUDIT-CRITERIA` criterion when that criterion controls the objection.
- Drafter responds inline within the round to each unresolved opinion (acceptance, revision proposal, evidence-backed rejection, or tradeoff narrowing). Drafter response is itself a discussion entry that subsequent critics consume before adding their own.
- Within-round contradictions between critics, or between a critic and drafter, trigger IMMEDIATE pairwise discussion within the same round when the contradiction blocks solution correctness; deferring contradictions to the next round is a meeting-form defect.

Critic discussion entries may run in parallel when team-agent runtime is active with `ACTIVE-CONCURRENT-AGENT-CAP` at or above critic count and the live process-backed roster includes all critic lanes; parallel critic entry remains discussion form when each critic consumes the prior in-round thread before contributing. Apply serial waiting when a critic's contribution depends on another critic's evidence. Forced single-lane execution despite available parallel runtime fit — "serial convenience" — is a bottleneck defect.

Drafter revises the draft once per round when possible. Each revision MUST verify cumulative input integration: every prior operator directive and every accepted critic opinion remains reflected in the revised draft. Silently dropping prior input across revisions is a procedure-adherence violation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` and disqualifies the revision from advancing to `### 3-5 MEETING-AUDIT-CRITERIA` convergence-readiness.

Drafter keeps a brief basis when rejecting a material objection or improvement. Drafter answers each unresolved objection by proposing the best-current persuasive solution. Drafter uses discussion requests to obtain evidence or resolve direct contradictions. Drafter converts every remaining material objection into a persuasion target before the next round.

Persuasion target options:
- revise the item so the objection is satisfied.
- add evidence-backed rationale showing why the current item already satisfies the objection.
- narrow the conflict into operator-choice tradeoff options when valid goals conflict.

The next round tests the converted solution or rationale. Repeated objection advances through changed solution content, changed evidence, or clearer tradeoff framing.

Operator may set a round limit at meeting opening. The marathon default continues until full consent on every item or until a default cap is reached. Default round cap is five rounds; drafter declares `HOLD` with documented objection-persistence basis when full consent is not reached within the cap, and operator may extend the cap explicitly. Per-item iteration closes after every critic clears material objections on that item.

### 3-4a. Meeting Transport Envelope Discipline
Every meeting-internal `SendMessage` (drafter discussion prompts, critic discussion contributions, peer critic dialogue, `critique-request` / `critique-response` / `discussion-entry` / `verdict` / any other meeting class) MUST use the canonical envelope-plus-retained-carrier-pointer shape per `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload` non-state-class rule:
- `summary` parameter carries a canonical no-detail signal: brief class label plus round/task pointer only (e.g., `discussion-entry r3 reviewer-shard-a`, `critique-response r5 carrier-only`, `redirect for active draft-r6`).
- `message` body carries minimum carrier pointer only — 1-3 lines naming the retained carrier path plus a brief intent label or single-class status word (e.g., `CARRIER: claude_doc/.../critique-r5-reviewer-shard-a.md`, `STATE: candidate-classified-with-revision`); no inline opinion body, no `FINDING-STATE-LADDER-SUMMARY`, no `PATCH-WORTHINESS`, no `DRAFTER MEETING-AUDIT-CRITERIA REASSESSMENT`, no `META-CONCERN`, no `NEXT-OWNER-ACTION` block, no `SELF-VERIFICATION` inventory, no `OPEN-SURFACES` inventory, no `OPINION-ROUND PROMPT RESPONSES`, no operational rationale, no excerpts.
- Full discussion-entry content (opinions, finding inventories, rationale, evidence citations, audit-criteria reassessment, META observations, next-owner-action, self-verification record, open surfaces) lives in the retained carrier referenced via the envelope pointer; the receiving participant consumes that carrier for all decision-affecting body.

Inline full-content body in any meeting `SendMessage` is a Constitutional Reporting Curtain violation per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain` and `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`; the rendered body becomes user-visible host UI content carrying meeting work-product into the user surface, violating the curtain. Senders MUST author meeting messages with carrier-based delivery from the outset; receivers MUST treat inline-body delivery as carrier-citation defect and route correction.

Runtime enforcement: `.claude/hooks/reporting-curtain-envelope-gate.sh` extends beyond upward state classes to reject any `SendMessage` body carrying bulk meeting/critique inventory markers (`FINDING-STATE-LADDER-SUMMARY`, `PATCH-WORTHINESS`, `META-CONCERN`, `OPINION-ROUND PROMPT`, `DRAFTER MEETING-AUDIT-CRITERIA`, `FINDING-STATE-INVENTORY`, `CITATION-EVIDENCE-INVENTORY` with body). This is a runtime safety net; the primary control is identity-layer Curtained Communication and this section's discipline.

### 3-5. MEETING-AUDIT-CRITERIA
This section is the meeting's audit regulation.
Every participant can identify it by the section title `MEETING-AUDIT-CRITERIA`.
Drafter checks every criterion below before publishing the initial draft.
Drafter checks every criterion below before accepting a revised item as consent-ready.
Drafter checks every criterion below before presenting the solution.
Critics use the same criteria when challenging, accepting, or proposing improvements.

Operator-emphasized meeting compliance criteria — solution passes every operator-emphasized keyword per the canonical 8-keyword list at `.claude/CLAUDE.md` `## 5. Modification Philosophy`. Drafter and critics consume that canonical list directly at audit time.

No-compression source:
- Apply `CLAUDE.md` `no-compression` definition when deciding whether a sentence is an allowed same-subject repeated-pattern line or a prohibited bundled clause.

Solution essentials:
- agenda fit: solution answers `MEETING-AGENDA` and `TARGET-OUTCOME`.
- simplicity: solution keeps necessary procedure, packet, role, and gate elements.
- correctness: material risks, assumptions, and evidence gaps are named.
- feasibility: the `NEXT ACTION` names an executable owner/action.
- bottleneck control: independent review or execution keeps parallel order unless evidence dependency requires serial order.
- cumulative input integration: every prior operator directive and accepted critic opinion is traced + reflected in the current draft via `OPERATOR-DIRECTIVE COMPLIANCE CHECK` enumeration; missing prior input is a failed criterion that returns the solution to revision before `### 3-6` convergence.

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
- Draft ready → Section 3-4 Discussion Round.
- Discussion contributions received → drafter inline response within round; round-end → drafter revision.
- Within-round contradiction blocking correctness → immediate pairwise discussion within the same round per Section 3-4.
- Material objection remains after round-close revision → dissent-to-solution conversion in Section 3-4.
- Material objections cleared → Section 3-5 MEETING-AUDIT-CRITERIA.
- Meeting `SendMessage` envelope shape violation → reject and resend with canonical envelope-plus-carrier-pointer per Section 3-4a.
- MEETING-AUDIT-CRITERIA passed → Section 3-7 Operator Gate.
- Operator accept → named downstream owner per Section 4-1.
- Operator reject or modify → smallest affected step.
- Correctness blocker unresolved → next opinion round or `HOLD`.
- Operator-set round limit reached before full consent → `HOLD` per Section 3-6.
- `HOLD` escalation with operator continuation → reopen meeting.
- Accepted governance mutation need → `Skill(governance-modification)`.
- Accepted separate-agent dispatch need → `Skill(task-execution)`.
- Unlisted blocker → `HOLD` with owner, blocker, and next safe evidence step.
