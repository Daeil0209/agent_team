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

### 3-3. Draft Publication (one-time carrier share)
Drafter writes one initial solution draft to a single retained carrier file (the shared discussion baseline). The draft applies Section 3-5 `MEETING-AUDIT-CRITERIA` as the drafter's first audit-applied best solution. The draft's SOLUTION may contain multiple items; each item is independently identifiable and independently iteratable.

Use the default template, reduced when the agenda clearly needs less:
```
AGENDA:
SOLUTION:
WHY THIS SOLVES IT:
MAIN RISKS OR TRADEOFFS:
NEXT ACTION:
```
The draft is concrete enough that the next owner can act.

After publication, drafter broadcasts a SINGLE-PUBLICATION-NOTIFICATION `SendMessage` to every critic in parallel using the canonical Draft-Publication envelope shape per Section 3-4a (a): `summary` = brief class label (e.g., `draft-publication r0`), `message` body = CARRIER pointer + STATE label (≤3 lines, no inline substantive content). This single broadcast establishes the shared discussion baseline. ALL subsequent meeting communication uses Section 3-4 Synchronized Discussion turn-form, NOT additional carrier files per turn.

Drafter maintains a cumulative enumeration of every operator directive issued during the meeting (initial agenda + every operator pre-critic intervention + every operator post-critic-response intervention) and every accepted discussion outcome; this enumeration appears in each revised draft carrier as an `OPERATOR-DIRECTIVE COMPLIANCE CHECK` (or equivalent name) section that traces each prior input to its reflection in the current draft.

When discussion produces a consent-converged item, drafter updates the SAME draft carrier with the revised text + broadcasts `draft-update r<N>` notification (canonical Draft-Publication envelope) — no per-round new carrier; one carrier carries cumulative state across revisions, tagged with current revision number.

### 3-4. Synchronized Discussion (short-message turn-by-turn)
After Draft Publication, participants engage in real-time short-message turn-by-turn discussion via `SendMessage`. The meeting is REAL discussion, not assignment-aggregation: each turn is a brief substantive exchange (question, answer, claim, counter-claim, evidence pointer, agreement/disagreement signal), NOT a carrier-file batch report.

Turn form per Section 3-4a (b):
- Each turn = one `SendMessage` with `summary` = brief turn label (e.g., `discussion-turn r1 Q-to-developer`, `r1-A developer`, `r1-counter critic-A→critic-B`) and `message` body = SUBSTANTIVE short content (≤3 lines). Substantive content includes: question, direct answer, claim, counter-claim, evidence pointer (file:line citation only), agreement/disagreement signal, narrowed tradeoff option.
- Turn body examples (each is ≤3 line body): `Q: G-11 RC-H evidence?` / `A: F-S2 cognitive 가능; RC-H still hypothesis` / `Counter: S-1 stance level not surface` / `Evidence: draft-r0 line 22-23` / `Agree on (a); disagree on (b)` / `Tradeoff: speed vs coverage` / `Yield to drafter` / `Object: dimensional-independence violation`.
- NO carrier file per discussion turn (the turn IS the substance); NO inventory markers; NO multi-finding tables; NO PASS/FAIL block; NO operational rationale paragraphs; NO excerpts.

Round structure:
- Drafter broadcasts a single short turn (question/claim/follow-up) to relevant critics — one `SendMessage` per critic in parallel, canonical envelope short turn.
- Critics respond in parallel (each with one short turn). Cross-critic challenges are first-class (critic A sends short turn to critic B directly, optionally copying drafter; drafter monitors thread).
- Drafter consumes all responses, sends next short turn (follow-up question, acceptance, counter, tradeoff narrowing).
- Round closes when drafter declares item consent-converged OR escalates to next round with new question.

Real-time turn-trip latency per turn ≈ critic agent processing time (~1-3 min per opus-tier agent); total meeting latency = sum of turns. Parallel-broadcast structure parallelizes per-round latency across critics.

Discussion essentials:
- Cross-critic awareness: each turn-author consumes the prior in-round turn thread before adding a new turn. Isolated turn that ignores prior thread is a meeting-form defect (turn redo within same round).
- Cross-critic dialogue is first-class meeting content. Critic A's challenge to critic B is welcome and routed normally.
- Drafter is co-discussant, not aggregator. Drafter participates with own questions, counter-claims, evidence pointers; drafter is NOT "the one who collects the reports".
- Drafter answers every objection in same round via direct turn (acceptance, counter-evidence pointer, or tradeoff narrowing). Drafter does NOT silently defer; deferral routes to dissent-to-solution conversion in next round.
- Within-round contradictions blocking solution correctness trigger IMMEDIATE pairwise discussion turn within the same round.

Persuasion target options for unresolved objections:
- revise the item so the objection is satisfied (update draft carrier between rounds per Section 3-3).
- add evidence-backed rationale (single turn citing evidence) showing why the current item already satisfies the objection.
- narrow the conflict into operator-choice tradeoff options when valid goals conflict.

When consent converges on an item, drafter updates the SHARED draft carrier (Section 3-3 update-notification path) and the meeting proceeds to the next unresolved item OR Section 3-5 audit.

Carrier-file batch correspondence (writing long carrier file per turn, sending carrier pointer per discussion turn, producing 100+ line critique carriers per round) is the PROHIBITED anti-form: it converts real discussion into assignment-aggregation, the same defect that drove this Skill's redesign. Detected carrier-file batch turn (multi-line substantive carrier per turn, or any turn body exceeding ≤3 lines with substantive content) routes the turn to redo in short-message form.

Critic discussion turns may run in parallel when team-agent runtime is active with `ACTIVE-CONCURRENT-AGENT-CAP` at or above critic count and the live process-backed roster includes all critic lanes. Apply serial waiting when a critic's turn depends on another critic's evidence. Forced single-lane execution despite available parallel runtime fit — "serial convenience" — is a bottleneck defect.

Drafter revises the SHARED draft carrier when consent converges on an item, not on every turn. Each revision MUST verify cumulative input integration: every prior operator directive and every accepted discussion outcome remains reflected in the revised carrier per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` cumulative-input mandate.

Operator may set a round limit at meeting opening. Marathon default continues until full consent on every item or until default cap is reached. Default round cap is five rounds; drafter declares `HOLD` with documented objection-persistence basis when full consent is not reached within the cap, and operator may extend the cap explicitly. Per-item iteration closes after every critic clears material objections on that item.

### 3-4a. Discussion Envelope Form
Every meeting-internal `SendMessage` uses ONE of TWO valid canonical-envelope body shapes per `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload` non-state-class rule:

(a) **Draft-Publication shape** (used ONCE per draft revision in Section 3-3): `summary` = brief class label (e.g., `draft-publication r0`, `draft-update r3`); `message` body = CARRIER pointer + STATE label only (≤3 lines, e.g., `CARRIER: claude_doc/.../draft-r0.md` + `STATE: published` + `ROUND: r0`). NO inline substantive content; the carrier file IS the publication.

(b) **Discussion-Turn shape** (used per turn in Section 3-4): `summary` = brief turn label (e.g., `discussion-turn r1 Q-to-developer`, `r1-A developer`, `r1-counter critic-A→critic-B`); `message` body = short SUBSTANTIVE content (≤3 lines, examples in Section 3-4 above). NO carrier pointer (the turn IS the substance); NO inventory markers; NO enumeration blocks; NO multi-finding tables; NO PASS/FAIL block; NO operational rationale paragraphs; NO excerpts; NO ego prose. If substance does not fit in ≤3 lines the question/answer needs decomposition into multiple turns (each ≤3 lines).

Bulk inventory body (FINDING-STATE-LADDER-SUMMARY, PATCH-WORTHINESS, META-CONCERN, OPINION-ROUND PROMPT, DRAFTER MEETING-AUDIT-CRITERIA, FINDING-STATE-INVENTORY, CITATION-EVIDENCE-INVENTORY, and other lane-completion-spine field markers per the runtime hook regex) is PROHIBITED in BOTH shapes; such content lives in the SINGLE draft carrier (shape (a) update via Section 3-3) OR is decomposed into multiple short discussion turns (shape (b)).

Inline full-content body in any meeting `SendMessage` (carrier-file-batch-correspondence form, long substantive body exceeding ≤3 lines, body containing inventory markers) is a Constitutional Reporting Curtain violation per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain` AND a real-discussion-form violation per Section 3-4; it is treated as a meeting-form defect with mandatory turn redo in shape (a) or shape (b).

Runtime enforcement: `.claude/hooks/reporting-curtain-envelope-gate.sh` PART A rejects bodies carrying inventory markers regardless of MESSAGE-CLASS; PART B rejects non-downward-delivery bodies with >3 newlines. Both apply to meeting `SendMessage`. The hook is the runtime safety net; the primary control is identity-layer Curtained Communication + this Section's discipline + the drafter-and-critics shared commitment to real-discussion form over batch-correspondence anti-form.

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
- Draft published (Section 3-3) → Section 3-4 Synchronized Discussion.
- Discussion turn received → drafter responds via short turn (Section 3-4a (b)); consent-converged item → drafter updates SHARED draft carrier (Section 3-3 update-notification path).
- Within-round contradiction blocking correctness → immediate pairwise discussion TURN within the same round per Section 3-4.
- Material objection remains after round-close revision → dissent-to-solution conversion in Section 3-4.
- Material objections cleared → Section 3-5 MEETING-AUDIT-CRITERIA.
- Meeting `SendMessage` envelope shape violation → reject and resend per Section 3-4a (shape (a) Draft-Publication OR shape (b) Discussion-Turn).
- Carrier-file batch turn detected (multi-line substantive body per discussion turn, inventory markers, long carrier per turn) → turn redo in shape (b) Discussion-Turn per Section 3-4.
- MEETING-AUDIT-CRITERIA passed → Section 3-7 Operator Gate.
- Operator accept → named downstream owner per Section 4-1.
- Operator reject or modify → smallest affected step.
- Correctness blocker unresolved → next opinion round or `HOLD`.
- Operator-set round limit reached before full consent → `HOLD` per Section 3-6.
- `HOLD` escalation with operator continuation → reopen meeting.
- Accepted governance mutation need → `Skill(governance-modification)`.
- Accepted separate-agent dispatch need → `Skill(task-execution)`.
- Unlisted blocker → `HOLD` with owner, blocker, and next safe evidence step.
