MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a, reviewer-shard-b, researcher, developer
ROUND: r3 (operator pre-critic feedback #3 incorporated — "토론을 통해서 쓸데없이 방향 결정해달라고 아무것도 안하고 멈춰있는 병신 같은 상황에 사라져야 해" + "이건 또 새로운 결함인데... 이 상황도 포함시켜" — ANTI-PASSIVE-WAIT clause added explicitly; verification that ALL prior operator-directive conditions are reflected)

## MEETING-AGENDA (cumulative — all operator directives from session)
Operator directive 2026-05-26 (now 7-part):
1. Choice situations must trigger critical-discussion-based direction-setting; regulated in + consumed by Skill(work-planning) + Skill(task-execution) [r0]
2. Chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; UNCONDITIONALLY required [r0]
3. USE team-meeting NOW to design + install rule; plug gap; then USE for downstream work [r0]
4. All R1-R4 open questions resolved in design (not deferred to critic round) [r1 pre-critic feedback #1]
5. INVARIANT: chosen direction MUST satisfy ALL §1-§8 upper-philosophy conditions; if presented options fail → mandatory REDESIGN within meeting until compliant; "best of incompliant options" forbidden; non-negotiable [r2 pre-critic feedback #2]
6. **(r3 NEW)** ANTI-PASSIVE-WAIT: the defect where active owner asks user "what direction?" then passively waits doing nothing must DISAPPEAR; unconditional defect-removal [r3 pre-critic feedback #3]
7. **(r3 NEW)** Anti-passive-wait is a new defect that must ALSO be included in the rule design [r3 pre-critic feedback #3]

## TARGET-OUTCOME (cumulative + ANTI-PASSIVE-WAIT)
- Canonical owner rule (work-execution-core-law `## Autonomy And Escalation Law`) covering **5 bullets** now: trigger definition + mandatory team-meeting + INVARIANT compliance + ANTI-PASSIVE-WAIT + fallback chain
- 3 consumer-surface synchronization triggers (Skill(work-planning) + Skill(task-execution) + Skill(governance-modification))
- All R1-R8 risks named + mitigated
- Post-install: apply to Phase 4-5 best-direction decision via fresh team-meeting under new rule (with INVARIANT + ANTI-PASSIVE-WAIT enforced)

## SOLUTION (revised r3 — 4 items; canonical Item 1 now 5 bullets including ANTI-PASSIVE-WAIT)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` rule addition (canonical mapped-core-law)
TARGET: `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` — insert 5 bullets after current line 90 user-escalation rule and before current line 91 hard-design-decision team-meeting mandate
EDIT-OPERATION: additive insertion of **5 bullets** (was 4 in r2; ANTI-PASSIVE-WAIT clause added as new bullet 4)

NEW-TEXT (proposed, r3):
```
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- INVARIANT: the team-meeting outcome direction MUST satisfy ALL §1-§8 upper-philosophy conditions per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes; when any presented option fails to satisfy ALL conditions, the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `## 3-4. Opinion Round`) until at least one option satisfies all upper-philosophy conditions. Selection of an upper-philosophy-incompliant option, picking the "best of incompliant options", or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation.
- ANTI-PASSIVE-WAIT: after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately in the same execution segment per `## Execution Progress Law` (line 158 "Process state report opens the next truthful action in the same turn") and `[NO-NEEDLESS-ASK]` (line 88 "Choose the evidence-backed best solution"); the active owner does NOT pause to ask the user "which direction?" or "shall I proceed?" or seek any direction-confirmation after the meeting has decided. Passive waiting for user direction-confirmation post-team-meeting is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation; the team-meeting outcome IS the direction, and execution is the next-truthful-action.
- Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test (line 92 below — bounded, reversible, ≥2 critics with material lens basis) OR when the meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap after exhausting redesign rounds: route to operator-policy-choice user escalation per the standard exception classes at lines 95-99 with explicit record of which upper-philosophy conditions remain incompliant in every option; direct user escalation that bypasses the team-meeting attempt, skips the redesign requirement, OR pauses for direction-confirmation after team-meeting convergence is invalid.
```

### Item 2 — Skill(work-planning) trigger consumption (r3 — clause about post-meeting execute added)
TARGET: `.claude/skills/work-planning/SKILL.md` `## Step 2: Q1-Q5 Work Analysis`
NEW-TEXT (proposed, r3):
```
- If Q1-Q5 or any later planning step reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before Step 3 work-plan build or Step 4 freeze; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the frozen route basis; post-meeting, execute the frozen route immediately per canonical ANTI-PASSIVE-WAIT without seeking user direction-confirmation; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

### Item 3 — Skill(task-execution) trigger consumption (r3 — clause about post-meeting execute added)
TARGET: `.claude/skills/task-execution/SKILL.md` `## Step 1: Activate Frozen Route`
NEW-TEXT (proposed, r3):
```
- If Step 1 reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible execution moves with material variance — e.g., wave-by-wave vs all-wave, sequential vs parallel, multiple equally-defensible dispatch shapes), open `Skill(team-meeting)` before execution-move selection; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the executed move; post-meeting, execute the move immediately per canonical ANTI-PASSIVE-WAIT without seeking user direction-confirmation; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

### Item 4 — Skill(governance-modification) trigger consumption (r3 — clause about post-meeting execute added)
TARGET: `.claude/skills/governance-modification/SKILL.md` `# Step 4: Change Sequence Design`
NEW-TEXT (proposed, r3):
```
- If multiple defensible CHANGE-SEQUENCE-DESIGN options exist for the same `PROBLEM-BASIS` per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (e.g., re-home vs delete vs split vs merge with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before design row selection; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the chosen design row; post-meeting, proceed to Step 5 + Patch Execution Method immediately per canonical ANTI-PASSIVE-WAIT without seeking user direction-confirmation; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

## WHY THIS SOLVES IT (r3 — S1-S11 from r2 + S12 ANTI-PASSIVE-WAIT)
- (S1-S11) Carried from r2 unchanged: operator-gap closure, generalization, unconditional procedure, upper-philosophy binding, R1-R4 resolutions, minimum-info, dimensional-independence, coherence, INVARIANT.
- (S12 r3 NEW) **ANTI-PASSIVE-WAIT enforcement**: canonical Item 1 bullet 4 forbids the team-lead behavior pattern operator demonstrated as defect (asking "which direction?" then passively waiting). Anchored to existing execution-drive rules: `## Execution Progress Law` line 158 (process state → next truthful action in same turn) + `[NO-NEEDLESS-ASK]` line 88 (choose evidence-backed best). Each consumer trigger (Items 2-4) restates "execute immediately per canonical ANTI-PASSIVE-WAIT without seeking user direction-confirmation" so the anti-passive-wait propagates to every consumption surface. Fallback chain (Item 1 bullet 5) explicitly invalidates "pause for direction-confirmation after team-meeting convergence".

## MAIN RISKS OR TRADEOFFS (r3 — R5/R6/R7 from r1 + R8 from r2 + R9 ANTI-PASSIVE-WAIT edge)

### R9 (NEW r3) — Edge case: team-meeting converges on direction whose execution genuinely needs user input
- Risk: rare case where team-meeting agrees on direction "X is best" but X's execution requires a piece of information only user has (e.g., a credential, an external authorization, an operator-private preference)
- Mitigation: this is NOT a choice situation per the trigger definition — it's a true `proven user-owned blocker` per line 94 "(a) named user-owned constraint, (b) evidence the constraint blocks safe continuation, (c) absence of evidence-backed reversible default within the active boundary". Such blockers route directly to user escalation per the existing rule WITHOUT going through team-meeting (no multiple defensible options exist when one piece is genuinely user-owned)
- Residual: if team-meeting fails to recognize the user-owned-blocker boundary and produces a direction that triggers blocker, then post-meeting execution correctly stops AT the blocker and routes through user-owned-blocker escalation (lawful); not an anti-passive-wait violation since it's NOT post-meeting direction-confirmation, it's blocker-driven escalation

### R5/R6/R7 (carried from r1) + R8 (carried from r2)
- R5 material-variance qualifier judgment burden — mitigated by `## Material And Materiality Law` anchor
- R6 existing line 91-93 hard-design-decision rule overlap — co-exist; line 91-93 = specific hard-decision classes; new rule = broader generalization
- R7 cap-overflow risk when team-meeting needs critics — fallback chain handles infeasibility
- R8 redesign exhaustion — fallback chain provides escape valve only after redesign exhaustion documented

## NEXT ACTION
After unanimous critics' consent on r3 + operator gate accept, route to `Skill(governance-modification)` for **4-patch loop** (work-execution-core-law canonical 5-bullet addition + 3 consumer trigger bullets each with ANTI-PASSIVE-WAIT clause). Each patch follows Step 3 review-verification + Step 4 design + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract.

After all 4 patches applied + post-verified, the new rule (with INVARIANT + ANTI-PASSIVE-WAIT) is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule. The Phase 4-5 meeting MUST produce a direction satisfying ALL §1-§8 upper philosophy (INVARIANT); after convergence, team-lead EXECUTES Phase 4-5 immediately per ANTI-PASSIVE-WAIT (no further user direction-confirmation).

## OPERATOR-DIRECTIVE COMPLIANCE CHECK (r3 verification of "지금 제시된 모든 내용이 반영")
For each operator directive issued in this session, verify reflection in r3:
- Directive 1 (choice-situation team-meeting in work-planning + work-execution) → Items 1+2+3 ✓
- Directive 2 (ALL upper philosophy compliance + UNCONDITIONAL) → Item 1 bullets 2-3 ✓
- Directive 3 (use team-meeting to design + install + apply) → NEXT ACTION ✓
- Directive 4 (all open questions resolved) → r1 + r2 + r3 risks (R1-R9) all named + mitigated ✓
- Directive 5 (INVARIANT redesign) → Item 1 bullet 3 ✓
- Directive 6 (anti-passive-wait defect must disappear) → Item 1 bullet 4 NEW ✓
- Directive 7 (include anti-passive-wait as new defect in rule) → Item 1 bullet 4 + S12 + each consumer trigger + Item 1 bullet 5 fallback chain explicit "pauses for direction-confirmation after team-meeting convergence is invalid" ✓

ALL 7 operator directives reflected. No omissions.

## MEETING-AUDIT-CRITERIA Self-Check (drafter, r3)
- agenda fit: ✓ (r3 addresses all 7 operator-directive parts)
- simplicity: ✓ (8 bullets total across 4 surfaces; minimum-executable-information)
- correctness: ✓ (R1-R9 named + mitigated)
- feasibility: ✓ (NEXT ACTION executable owner = Skill(governance-modification) 4-patch loop)
- bottleneck control: ✓ (4 patches independent per dimensional-independence)
- 8 operator-emphasized keywords (CLAUDE.md §5):
  - `removal-first` ✓ (additive 8 bullets; existing line 91-93 retained as special case)
  - `consumed-surface` ✓ (canonical + 3 consumers)
  - `no-compression` ✓ (each bullet one rule)
  - `upper-lower execution-drive` ✓ (top-doctrine §3 [NO-NEEDLESS-ASK] line 88 + Execution Progress Law line 158 explicitly cited in ANTI-PASSIVE-WAIT bullet)
  - `executable-imperative` ✓ ("unconditionally mandatory" + "MUST" + "EXECUTES" + "forbidden" + "violation" + "INVARIANT")
  - `minimum-executable-information` ✓ (8 bullets; no examples beyond brief illustrative parenthetical)
  - `dimensional-independence` ✓ (mapped-core-law + operational; no identity-layer)
  - `comprehension-as-execution-force` ✓ (5 variance criteria + carve-out + INVARIANT + ANTI-PASSIVE-WAIT + fallback enumerated)

## OPINION-ROUND REQUEST TO CRITICS (r3 supersedes r2; r2 superseded r1)
Each critic deliver opinion targeting:
- the 4 SOLUTION items (Item 1 canonical 5 bullets including NEW ANTI-PASSIVE-WAIT bullet 4 + Items 2-4 consumer triggers)
- the ANTI-PASSIVE-WAIT clause specifically: is "EXECUTES immediately" enforceable? does "no pause for direction-confirmation" cover all loophole shapes? is the §3 line 158 + line 88 anchor sufficient?
- the R9 edge case (user-owned blocker boundary): correctly excluded from anti-passive-wait scope?
- the WHY THIS SOLVES IT rationale (S1-S12)
- the OPERATOR-DIRECTIVE COMPLIANCE CHECK (any directive missed?)
- the MEETING-AUDIT-CRITERIA self-check (any failed criterion?)
- any new defect or risk not covered

Critique-response delivery: SendMessage MESSAGE-CLASS: critique-response with carrier pointer to `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r3-<your-member-name>.md`.
