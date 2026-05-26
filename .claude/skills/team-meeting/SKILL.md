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

### 3-4. Synchronized Discussion (carrier-log append turn-by-turn)
After Draft Publication, participants engage in real-time turn-by-turn discussion via SHORT append-style writes to a SHARED RUNNING DISCUSSION LOG CARRIER, exchanged via canonical carrier-pointer `SendMessage` envelopes. The meeting is REAL discussion (short fast turns), not assignment-aggregation (long batch reports), AND every meeting message uses carrier-only envelope so meeting deliberation content stays in retained carriers and never appears in `SendMessage` rendered body (which would expose to host UI).

Substance transport architecture:
- All discussion substance (questions, answers, claims, counter-claims, evidence pointers, agreement signals, tradeoff options) lives in a SHARED retained carrier file — typically a running discussion log (`discussion-log.md`) co-located with the draft carrier — appended in short turn-by-turn entries.
- Every meeting `SendMessage` (drafter or critic) uses canonical carrier-pointer envelope per Section 3-4a: `summary` = brief turn label; `message` body = `CARRIER: <log-path>` + `TURN: <turn-id>` + brief `STATE` label, ≤3 lines, NO substantive content inline. The SendMessage IS a notification that a new turn was appended to the log, NOT the turn content itself.
- Receiving participant reads the LOG (not the envelope body) for substance; the envelope is a wake/index signal only.

Turn append pattern (real-time short turns via carrier append, NOT body content):
- Each turn appended to `discussion-log.md` is SHORT and SUBSTANTIVE: 1-5 lines of substantive content (question, answer, claim, counter, evidence pointer, agreement signal, tradeoff option) per appended turn entry. Turn entries are atomic; multi-paragraph batch critiques are decomposed into multiple short turn appends, not bundled.
- Turn entry header carries TURN-ID + AUTHOR + ROUND + TARGET (whole-draft / item / prior-turn-id) + brief CONTENT.
- Author appends turn entry to log carrier file (`Edit` append or `Write` if first turn), then sends canonical carrier-pointer `SendMessage` to recipient(s) as wake/index signal.

Round structure:
- Drafter appends short Q turn to discussion-log, broadcasts canonical carrier-pointer envelope to relevant critics (one envelope per critic, parallel).
- Critics read log (consuming Q + every prior in-round turn entry), each appends short A turn to SAME log, sends canonical carrier-pointer envelope back (drafter receives wake signals; cross-critic dialogue uses critic-to-critic envelope wake to same log).
- Drafter reads new log entries, appends next short turn (follow-up Q, acceptance, counter, tradeoff narrowing), broadcasts carrier-pointer envelope.
- Round closes when drafter declares item consent-converged OR escalates to next round.

Real-time turn-trip latency per turn ≈ critic agent processing time (1-3 min per opus-tier agent); total meeting latency = sum of turns. Parallel-broadcast envelopes (each carrier-pointer-only) parallelize per-round latency across critics. Substance never enters envelope body — meeting deliberation stays in the discussion-log carrier (not exposed to host UI render).

Discussion essentials:
- Cross-critic awareness: each turn-author reads the discussion-log carrier (every prior in-round turn entry) before appending a new turn. Isolated turn that ignores prior log entries is a meeting-form defect (turn redo within same round).
- Cross-critic dialogue is first-class meeting content. Critic A's append targeting critic B's prior turn is welcome (TARGET field cites prior TURN-ID); the carrier-pointer envelope wake goes to critic B (optionally to drafter as observer).
- Drafter is co-discussant, not aggregator. Drafter participates with own appended turns (questions, counter-claims, evidence pointers); drafter is NOT "the one who collects the reports".
- Drafter answers every objection via direct appended turn (acceptance, counter-evidence pointer, or tradeoff narrowing) within the same round. Drafter does NOT silently defer; deferral routes to dissent-to-solution conversion in next round.
- Within-round contradictions blocking solution correctness trigger IMMEDIATE pairwise discussion turn (appended to log + wake envelope) within the same round.

Persuasion target options for unresolved objections:
- revise the item so the objection is satisfied (update draft carrier between rounds per Section 3-3).
- add evidence-backed rationale (single turn citing evidence) showing why the current item already satisfies the objection.
- narrow the conflict into operator-choice tradeoff options when valid goals conflict.

When consent converges on an item, drafter updates the SHARED draft carrier (Section 3-3 update-notification path) and the meeting proceeds to the next unresolved item OR Section 3-5 audit.

Carrier-file batch correspondence (writing long carrier file per turn, sending carrier pointer per discussion turn, producing 100+ line critique carriers per round) is the PROHIBITED anti-form: it converts real discussion into assignment-aggregation, the same defect that drove this Skill's redesign. Detected carrier-file batch turn (multi-line substantive carrier per turn, or any turn body exceeding ≤3 lines with substantive content) routes the turn to redo in short-message form.

Critic discussion turns may run in parallel when team-agent runtime is active with `ACTIVE-CONCURRENT-AGENT-CAP` at or above critic count and the live process-backed roster includes all critic lanes. Apply serial waiting when a critic's turn depends on another critic's evidence. Forced single-lane execution despite available parallel runtime fit — "serial convenience" — is a bottleneck defect.

Drafter revises the SHARED draft carrier when consent converges on an item, not on every turn. Each revision MUST verify cumulative input integration: every prior operator directive and every accepted discussion outcome remains reflected in the revised carrier per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` cumulative-input mandate.

Operator may set a round limit at meeting opening. Marathon default continues until full consent on every item or until default cap is reached. Default round cap is five rounds; drafter declares `HOLD` with documented objection-persistence basis when full consent is not reached within the cap, and operator may extend the cap explicitly. Per-item iteration closes after every critic clears material objections on that item.

### 3-4a. Discussion Envelope Form (CARRIER-POINTER ONLY for all meeting SendMessage)
Every meeting-internal `SendMessage` (drafter draft publication, drafter discussion-turn wake notification, critic discussion-turn wake notification, peer critic dialogue wake notification, `critique-request` / `critique-response` / `discussion-entry` / `verdict` / any other meeting class) MUST use the SAME canonical carrier-pointer envelope shape per `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload` non-state-class rule:
- `summary` parameter carries a canonical no-detail signal: brief class label plus round/turn pointer (e.g., `draft-publication r0`, `draft-update r3`, `discussion-turn r1 wake-to-developer`, `r1-turn-append critic-A`).
- `message` body carries CARRIER pointer + minimum index label only — 1-3 lines naming the retained carrier path plus a brief TURN-ID / STATE / ROUND label (e.g., `CARRIER: claude_doc/.../draft-r0.md` + `STATE: published` + `ROUND: r0`; or `CARRIER: claude_doc/.../discussion-log.md` + `TURN: r1-T07` + `STATE: appended`). NO inline substantive content of any kind: no questions, no answers, no claims, no counter-claims, no inline opinion body, no FINDING-STATE-LADDER-SUMMARY, no PATCH-WORTHINESS, no DRAFTER MEETING-AUDIT-CRITERIA REASSESSMENT, no META-CONCERN, no NEXT-OWNER-ACTION block, no SELF-VERIFICATION inventory, no OPEN-SURFACES inventory, no operational rationale, no excerpts, no convergence summary, no cross-critic synthesis.
- All discussion substance (questions, answers, claims, counter-claims, evidence pointers, agreement signals, tradeoff options, finding inventories, audit-criteria reassessment, META observations, next-owner-action, self-verification record, open surfaces, convergence sketches) lives in the retained carrier (draft carrier OR running discussion-log carrier) referenced via the envelope pointer; the receiving participant consumes that carrier for all decision-affecting body.

Why carrier-only universally (not just for batch reports):
- Host runtime renders teammate-message envelope content (summary + body) into user-visible UI as automatic out-of-curtain-scope behavior. Substantive content inline in `SendMessage` body therefore leaks meeting deliberation to the user surface every turn, regardless of REPORT-REASON status.
- Carrier files (`Read`-only for receiver) are NOT auto-rendered to user; only the envelope pointer renders. Substance in carrier = user-non-exposed; substance in body = user-exposed (curtain breach).
- Real-time short-turn dialogue is achieved by SHORT carrier appends (1-5 lines per appended turn entry) + carrier-pointer wake envelopes — not by inlining substance in body. Latency = same as body-inline form (one envelope round-trip per turn); curtain compliance preserved.

Inline substantive content in any meeting `SendMessage` body is a Constitutional Reporting Curtain violation per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain` AND a meeting-form defect per Section 3-4; the rendered body becomes user-visible host UI content carrying meeting deliberation into the user surface, violating the curtain. Senders MUST author meeting messages with carrier-only delivery from the outset; receivers MUST treat inline-body delivery as carrier-citation defect and route correction.

Runtime enforcement: `.claude/hooks/reporting-curtain-envelope-gate.sh` PART A rejects bodies carrying inventory markers regardless of MESSAGE-CLASS; PART B rejects non-downward-delivery bodies with >3 newlines. Both apply to meeting `SendMessage`. The hook is the runtime safety net; the primary control is identity-layer Curtained Communication + this Section's discipline + the drafter-and-critics shared commitment to carrier-only-envelope form so meeting substance stays out of the host-rendered user surface.

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
- Draft published (Section 3-3) → Section 3-4 Synchronized Discussion (running discussion-log carrier opened/appended).
- New discussion-log turn entry appended → author sends carrier-pointer wake envelope to recipient(s) per Section 3-4a.
- Wake envelope received → recipient reads discussion-log carrier (every prior in-round turn entry) before appending new turn; consent-converged item → drafter updates SHARED draft carrier (Section 3-3 update-notification path).
- Within-round contradiction blocking correctness → immediate pairwise discussion TURN appended to log + wake envelope to other party per Section 3-4.
- Material objection remains after round-close revision → dissent-to-solution conversion (next-round turn appended) per Section 3-4.
- Material objections cleared → Section 3-5 MEETING-AUDIT-CRITERIA.
- Meeting `SendMessage` envelope shape violation (any inline substantive body content) → reject and resend per Section 3-4a (carrier-pointer-only envelope; substance must live in carrier, never in body).
- MEETING-AUDIT-CRITERIA passed → Section 3-7 Operator Gate.
- Operator accept → named downstream owner per Section 4-1.
- Operator reject or modify → smallest affected step.
- Correctness blocker unresolved → next opinion round or `HOLD`.
- Operator-set round limit reached before full consent → `HOLD` per Section 3-6.
- `HOLD` escalation with operator continuation → reopen meeting.
- Accepted governance mutation need → `Skill(governance-modification)`.
- Accepted separate-agent dispatch need → `Skill(task-execution)`.
- Unlisted blocker → `HOLD` with owner, blocker, and next safe evidence step.
