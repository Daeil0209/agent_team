MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a (lens: design-intent + coherence-integrity + patch-worthiness), reviewer-shard-b (lens: governance-continuity + minimum-executable-information + negative-risk + removal-first)
ROUND: r1 (operator pre-critic feedback incorporated — "지금 제시된 모든 내용이 반영되어야 한다"; R1-R4 open questions from draft-r0 now resolved)

## MEETING-AGENDA (unchanged from r0)
Operator directive 2026-05-26 (3-part):
1. "지금과 같은 선택 상황에서 비판적인 토론을 통해서 방향을 설정하는 것이 작업 계획과 작업 실행 스킬에 규정되고 소비되도록 해야 할 것 같은데?" — choice situations must trigger critical-discussion-based direction-setting; this rule must be regulated in and consumed by Skill(work-planning) + Skill(task-execution)
2. "선택방향은 당연히 현재 상위 철학 규정을 모두 빠짐없이 준수할 수 있는 방향이면서 그 방향에 맞게 설계된 방향이 되어야 해~!! 무조건!! 그리고 이런 선택상황에서 무조건 수행되어야 하는 절차이고~!!" — chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; team-meeting procedure UNCONDITIONALLY required in choice situations
3. "팀 회의 스킬을 활용하여 내가 제시한 이 규정을 설계하고 적용하여 현재의 구멍을 틀어 막아!! 그래서 앞으로는 이러한 절차적 결함이 발생하지 않도록 먼저 작업 한 후, 새롭게 도입한 절차를 통해 다음 작업으로 이어나가~!" — USE team-meeting NOW to design + install this rule; then USE the new procedure for downstream work (Phase 4-5)
4. Operator pre-critic feedback (this turn): "지금 제시된 모든 내용이 반영되어야 한다" — all R1-R4 open questions from draft-r0 must be resolved in the rule design (not deferred to critic round)

## TARGET-OUTCOME (unchanged + R1-R4 resolutions reflected)
- Generalized rule installed at canonical owner (work-execution-core-law `## Autonomy And Escalation Law`) covering 3 bullets: trigger definition + mandatory team-meeting + fallback chain (R2/R4 resolution)
- Synchronization patches at 3 consumer surfaces: Skill(work-planning) + Skill(task-execution) + Skill(governance-modification) (R3 resolution: governance-modification ALSO consumes the rule for Step 4 design choice situations)
- Non-choice-situation enumeration explicit at canonical owner (R1 resolution: "trivially equivalent" carve-out)
- All patches respect dimensional-independence + minimum-executable-information + removal-first per `.claude/reference/modification-core-law.md`
- Post-install: new rule applied to Phase 4-5 best-direction decision via fresh team-meeting under newly-installed canonical rule

## SOLUTION (revised — 4 items, R1-R4 reflected)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` rule addition (canonical mapped-core-law)
TARGET: `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` — insert 3 bullets after current line 90 user-escalation rule and before current line 91 hard-design-decision team-meeting mandate
EDIT-OPERATION: additive insertion of 3 bullets

NEW-TEXT (proposed):
```
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; the team-meeting solution must be designed for full §1-§8 upper-philosophy compliance per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes, and direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- Fallback chain when `Skill(team-meeting)` form is infeasible per the 3-condition convergence-tractable test (line 92 above) OR the meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap: route to operator-policy-choice user escalation per the standard exception classes at lines 95-99; direct user escalation that bypasses the team-meeting attempt is invalid.
```

### Item 2 — Skill(work-planning) trigger consumption (operational layer; R3 resolution included)
TARGET: `.claude/skills/work-planning/SKILL.md` `## Step 2: Q1-Q5 Work Analysis` — insert 1 bullet after the existing Q5 + Hold rule
EDIT-OPERATION: additive insertion of 1 bullet citing canonical owner

NEW-TEXT (proposed):
```
- If Q1-Q5 or any later planning step reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before Step 3 work-plan build or Step 4 freeze; the team-meeting solution must satisfy §1-§8 upper-philosophy compliance and becomes the frozen route basis; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD`.
```

### Item 3 — Skill(task-execution) trigger consumption (operational layer; R3 resolution included)
TARGET: `.claude/skills/task-execution/SKILL.md` `## Step 1: Activate Frozen Route` — insert 1 bullet at end of step
EDIT-OPERATION: additive insertion of 1 bullet citing canonical owner

NEW-TEXT (proposed):
```
- If Step 1 reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible execution moves with material variance — e.g., wave-by-wave vs all-wave, sequential vs parallel, multiple equally-defensible dispatch shapes), open `Skill(team-meeting)` before execution-move selection; the team-meeting solution must satisfy §1-§8 upper-philosophy compliance and becomes the executed move; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD`.
```

### Item 4 — Skill(governance-modification) trigger consumption (operational layer; R3 resolution NEW)
TARGET: `.claude/skills/governance-modification/SKILL.md` `# Step 4: Change Sequence Design` — insert 1 bullet at end of Step 4
EDIT-OPERATION: additive insertion of 1 bullet citing canonical owner

NEW-TEXT (proposed):
```
- If multiple defensible CHANGE-SEQUENCE-DESIGN options exist for the same `PROBLEM-BASIS` per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (e.g., re-home vs delete vs split vs merge with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before design row selection; the team-meeting solution must satisfy §1-§8 upper-philosophy compliance and becomes the chosen design row; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD`.
```

## WHY THIS SOLVES IT (drafter rationale; R1-R4 resolutions noted)
- (S1) **Operator-identified gap closure**: Phase 4-5 mode decision (this very engagement) demonstrated team-lead bypassing team-meeting and escalating user. New rule names this exact pattern as a violation with explicit "[NO-NEEDLESS-ASK] + procedure-adherence violation" wording.
- (S2) **Generalization principle compliance** (§5 "Distributed common execution meaning consolidates to its single owner surface"): canonical owner = work-execution-core-law (3 bullets); downstream skills cite-only (1 trigger bullet each at 3 consumers); no per-skill rule duplication.
- (S3) **Unconditional procedure** (operator directive #2 "무조건"): "unconditionally mandatory" + "violation" wording removes loophole; new rule applies to ALL choice situations (superset of existing line 91-93 "hard design decisions" scope).
- (S4) **Upper-philosophy compliance binding** (operator directive #2 "상위 철학 규정을 모두 빠짐없이 준수"): "designed for full §1-§8 upper-philosophy compliance per Skill(review-verification) `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes" — explicit anchor to existing review-verification rule; appears in canonical bullet AND each consumer trigger.
- (S5) **R1 resolution (trigger over-broadness)**: trigger requires "material variance per `## Material And Materiality Law`" (existing canonical anchor); non-choice-situation carve-out explicit ("trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance").
- (S6) **R2 + R4 resolution (convergence-tractable + operator-policy-choice fallback)**: 3rd canonical bullet names fallback chain explicitly — `Skill(team-meeting)` infeasible (3-condition test fails) OR meeting HOLD → operator-policy-choice user escalation per lines 95-99; direct user escalation bypassing team-meeting is invalid.
- (S7) **R3 resolution (cross-skill consumption)**: 4 patches total (canonical + 3 consumers including governance-modification Step 4); choice situations during patch design are now covered.
- (S8) **Minimum-executable-information** (`.claude/CLAUDE.md` §5): 3 canonical bullets + 3 consumer trigger bullets = 6 bullets total; no example/explanation prose; each bullet one independently testable rule.
- (S9) **Dimensional-independence**: canonical at mapped-core-law layer; consumers at operational layer (skills); no identity-layer change. Identity-layer (team-lead.md / lane role files) inherits via downstream consumption automatically.
- (S10) **Coherence with existing line 91-93**: existing rule (hard design decisions → team-meeting) is now a SPECIAL CASE of new rule (choice situations → team-meeting). No removal needed; new rule generalizes. Line 91-93 wording preserved as more-specific guidance for hard design decisions; new rule provides the broader generalization. Convergence-tractable 3-condition test from line 92 retained as feasibility test for the team-meeting form within choice situations.

## MAIN RISKS OR TRADEOFFS (residual after R1-R4 resolution)

### R5 — Material-variance qualifier judgment burden
- Risk: active owner may apply "material variance" inconsistently → either over-trigger (every choice triggers meeting) or under-trigger (rationalize meeting-skip as "trivially equivalent")
- Mitigation: "material variance per `## Material And Materiality Law`" cites existing canonical material-applicability test (line 82-85) which requires "evidence-backed anchor from the material applicability test"; "material" is never operator-judgment-only
- Residual: judgment still needed at consumption surface; mitigated by review-verification gate at completion (if owner skipped team-meeting and the choice had material variance, Skill(review-verification) catches it as `confirmed-defect:silent-narrowing` or `procedure-adherence` defect)

### R6 — Existing line 91-93 hard-design-decision rule overlap
- Risk: new generalization may make line 91-93 redundant or contradictory
- Analysis: not redundant — line 91-93 specifies particular hard-decision classes (operator-policy-choice surfaces, constitutional-protected surface mutation, trade-off-bearing patch design) that ALWAYS trigger team-meeting regardless of variance qualifier. New rule covers BROADER choice situations. The two rules co-exist: line 91-93 = unconditional for the 3 named hard-decision classes; new rule = unconditional for any choice situation with material variance.
- Mitigation: explicit "Coherence with existing line 91-93" point in S10 above; no removal of line 91-93 required

### R7 — Cap-overflow risk when team-meeting needs critics
- Risk: opening team-meeting requires ≥2 critics; ACTIVE-CONCURRENT-AGENT-CAP may be exceeded if drafter + 2 critics overlap with other active dispatches
- Mitigation: existing rule (line 92 condition iii) requires "team has sufficient perspective coverage — drafter (team-lead) + ≥2 critics with material lens basis"; if critics unavailable, team-meeting form infeasible → fallback chain (Item 1 bullet 3) routes to operator-policy-choice user escalation. Captured in fallback chain.

## NEXT ACTION
After unanimous critics' consent + operator gate accept, route to `Skill(governance-modification)` for **4-patch loop** (work-execution-core-law canonical 3-bullet addition + work-planning Step 2 trigger + task-execution Step 1 trigger + governance-modification Step 4 trigger). Each patch follows Step 3 review-verification + Step 4 design + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract. After all 4 patches applied + post-verified, the new rule is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule.

## MEETING-AUDIT-CRITERIA Self-Check (drafter, r1)
- agenda fit: ✓ (solution addresses all 4 operator-directive parts including pre-critic feedback)
- simplicity: ✓ (6 bullets total across 4 surfaces; minimum-executable-information)
- correctness: ✓ (R1/R2/R3/R4 resolved in canonical or consumer wording; R5/R6/R7 residual risks named with mitigation)
- feasibility: ✓ (NEXT ACTION names executable owner = Skill(governance-modification) 4-patch loop)
- bottleneck control: ✓ (4 patches independent per dimensional-independence; parallel-safe if needed)
- 8 operator-emphasized keywords (CLAUDE.md §5):
  - `removal-first` ✓ (additive 6 bullets; no over-spec; line 91-93 retained as more-specific case)
  - `consumed-surface` ✓ (canonical mapped-core-law owner + 3 consumer triggers)
  - `no-compression` ✓ (each bullet one rule)
  - `upper-lower execution-drive` ✓ (top-doctrine §3 [NO-NEEDLESS-ASK] already covers; mapped core law extends; consumers cite-only)
  - `executable-imperative` ✓ ("unconditionally mandatory" + "violation" + "becomes the executed move")
  - `minimum-executable-information` ✓ (6 bullets total; no examples beyond brief illustrative parenthetical)
  - `dimensional-independence` ✓ (mapped-core-law + operational; no identity-layer; consumers at skill layer only)
  - `comprehension-as-execution-force` ✓ (5 variance criteria + non-choice carve-out enumerated for clear trigger application; fallback chain explicit)

## OPINION-ROUND REQUEST TO CRITICS (r1)
Each critic deliver opinion targeting:
- the 4 SOLUTION items (Item 1 canonical + Item 2/3/4 consumer triggers)
- the WHY THIS SOLVES IT rationale (S1-S10)
- the residual R5/R6/R7 risks (mitigation sufficient? hidden risks missed?)
- the MEETING-AUDIT-CRITERIA self-check (any failed criterion?)
- any new defect or risk not covered

Per `Skill(team-meeting)` `## 3-4. Opinion Round`: each opinion targets whole draft OR specific Item; cite lens basis when material; participants may name failed `MEETING-AUDIT-CRITERIA`; opinion delivery via SendMessage MESSAGE-CLASS: critique-response with carrier pointer to `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r1-<critic-name>.md` (each critic writes own critique carrier).
