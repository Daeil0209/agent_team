MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a (lens: design-intent + coherence-integrity + patch-worthiness), reviewer-shard-b (lens: governance-continuity + minimum-executable-information + negative-risk + removal-first)
ROUND: r0 (initial draft)

## MEETING-AGENDA
Operator directive 2026-05-26 (3-part):
1. "지금과 같은 선택 상황에서 비판적인 토론을 통해서 방향을 설정하는 것이 작업 계획과 작업 실행 스킬에 규정되고 소비되도록 해야 할 것 같은데?" — choice situations must trigger critical-discussion-based direction-setting; this rule must be regulated in and consumed by Skill(work-planning) + Skill(task-execution)
2. "선택방향은 당연히 현재 상위 철학 규정을 모두 빠짐없이 준수할 수 있는 방향이면서 그 방향에 맞게 설계된 방향이 되어야 해~!! 무조건!! 그리고 이런 선택상황에서 무조건 수행되어야 하는 절차이고~!!" — chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; team-meeting procedure UNCONDITIONALLY required in choice situations
3. "팀 회의 스킬을 활용하여 내가 제시한 이 규정을 설계하고 적용하여 현재의 구멍을 틀어 막아!! 그래서 앞으로는 이러한 절차적 결함이 발생하지 않도록 먼저 작업 한 후, 새롭게 도입한 절차를 통해 다음 작업으로 이어나가~!" — USE team-meeting NOW to design + install this rule; then USE the new procedure for downstream work (Phase 4-5)

## TARGET-OUTCOME
- Generalized rule installed at canonical owner (work-execution-core-law `## Autonomy And Escalation Law`) that:
  - Names "choice situation" trigger explicitly (5 variance criteria below)
  - Mandates `Skill(team-meeting)` BEFORE owner-side selection OR user escalation in choice situations
  - Mandates team-meeting outcome aligns with ALL §1-§8 upper philosophy per `Skill(review-verification)` `## Upstream Basis Review Law` consumption
- Synchronization patches at consumer surfaces (Skill(work-planning) + Skill(task-execution)) per upper-lower execution-drive
- Patches respect dimensional-independence + minimum-executable-information + removal-first per `.claude/reference/modification-core-law.md`
- Post-install: new rule applied to Phase 4-5 best-direction decision

## SOLUTION (initial drafter best-current per §3-5 audit applied)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` rule addition (canonical mapped-core-law)
TARGET: `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (after current line 90 user-escalation rule and before line 91 current team-meeting mandate)
EDIT-OPERATION: additive insertion of 2 bullets defining choice-situation trigger + mandatory team-meeting procedure

NEW-TEXT (proposed):
```
- A `choice situation` exists when the active owner faces multiple defensible options that vary materially in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per §1 Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates.
- In every choice situation, `Skill(team-meeting)` is mandatory before owner-side selection OR user escalation; the team-meeting solution must be designed for full §1-§8 upper-philosophy compliance per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section, and direct owner-side choice or user escalation without prior team-meeting in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
```

### Item 2 — Skill(work-planning) trigger consumption (operational layer)
TARGET: `.claude/skills/work-planning/SKILL.md` (likely at `## Step 2: Q1-Q5 Work Analysis` after current Q5 — point where choice situations naturally surface during planning)
EDIT-OPERATION: additive insertion of 1 bullet citing the canonical owner

NEW-TEXT (proposed):
```
- If Q1-Q5 reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before scope freeze; team-meeting outcome becomes frozen-route basis.
```

### Item 3 — Skill(task-execution) trigger consumption (operational layer)
TARGET: `.claude/skills/task-execution/SKILL.md` `## Step 1: Activate Frozen Route`
EDIT-OPERATION: additive insertion of 1 bullet citing the canonical owner

NEW-TEXT (proposed):
```
- If Step 1 reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible execution moves with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety — e.g., wave-by-wave vs all-wave, sequential vs parallel, multiple equally-defensible dispatch shapes), open `Skill(team-meeting)` before execution-move selection; team-meeting outcome becomes the executed move.
```

## WHY THIS SOLVES IT (drafter rationale)
- (S1) **Operator-identified gap closure**: Phase 4-5 mode decision (this very engagement) demonstrated team-lead bypassing team-meeting and escalating user. New rule names this exact pattern as a violation.
- (S2) **Generalization principle compliance** (§5 "Distributed common execution meaning consolidates to its single owner surface"): canonical owner = work-execution-core-law; downstream skills cite-only (1 trigger bullet each), no per-skill rule duplication.
- (S3) **Unconditional procedure** (operator directive #2 "무조건"): "is mandatory" + "violation" wording removes loophole; no convergence-tractable carve-out (existing rule at line 91-93 retains carve-out for hard design decisions specifically, new rule extends to ALL choice situations).
- (S4) **Upper-philosophy compliance binding** (operator directive #2 "상위 철학 규정을 모두 빠짐없이 준수"): "designed for full §1-§8 upper-philosophy compliance per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section" — explicit anchor to existing review-verification rule.
- (S5) **Minimum-executable-information** (`.claude/CLAUDE.md` §5): 2-bullet canonical rule + 1-bullet trigger restatement at each of 2 consumers = 4 bullets total; no example/explanation prose.
- (S6) **Dimensional-independence**: canonical at mapped-core-law layer; consumers at operational layer; no identity-layer change.

## MAIN RISKS OR TRADEOFFS

### R1 — Choice-situation trigger over-broadness
- Risk: every minor option could trigger team-meeting → over-saturate runtime
- Mitigation: "material variance" qualifier per `.claude/reference/work-execution-core-law.md` `## Material And Materiality Law` line 82-85 (material applicability test requires evidence-backed anchor; cannot be operator-judgment-only)
- Open question for critics: is "material variance" qualifier sufficient anchor, or does this rule need an explicit non-choice-situation enumeration (e.g., "options that are trivially equivalent or differ only in implementation detail without user-outcome difference")?

### R2 — Convergence-tractable form vs unconditional team-meeting tension
- Risk: existing rule at line 91-93 makes team-meeting required when "convergence-tractable form applies" with 3 conditions; new rule says "unconditional in choice situations" — apparent conflict
- Mitigation: new rule scopes to "choice situation" trigger; existing rule scopes to "hard design decisions" trigger. Choice situations are a SUPERSET. Existing rule's 3-condition test still applies WITHIN choice situations to determine whether the team-meeting form is valid; if 3 conditions fail (e.g., requires external evidence, or no ≥2 critics available), the team-meeting cannot run → routes to lawful user escalation
- Open question for critics: should new rule explicitly cite the 3-condition fallback path to user escalation when team-meeting form is infeasible?

### R3 — Cross-skill consumption may need governance-modification skill trigger too
- Risk: `Skill(governance-modification)` design steps (Step 3-4) involve patch-design choice situations; should governance-modification also carry the new trigger?
- Open question for critics: should governance-modification SKILL.md Step 4 add the same trigger bullet?

### R4 — Operator-policy-choice carve-out preservation
- Risk: line 95-99 carve-out preserves operator-policy-choice escalation when "doctrine and evidence leave no single best reversible path" — new rule's "team-meeting first" might conflict
- Mitigation: team-meeting is BEFORE user escalation; if team-meeting reaches HOLD per Section 3-6 (no convergence within round cap), then operator-policy-choice user escalation applies as normal
- Open question for critics: should this fallback chain be explicitly named in the new rule?

## NEXT ACTION
After unanimous critics' consent + operator gate accept, route to `Skill(governance-modification)` for 3-patch loop (work-execution-core-law canonical + work-planning trigger + task-execution trigger). Each patch follows Step 3 review-verification + Step 4 design + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract. After patches applied + post-verified, the new rule is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule.

## MEETING-AUDIT-CRITERIA Self-Check (drafter)
- agenda fit: ✓ (solution addresses operator-directive 3 parts: design + install + apply)
- simplicity: ✓ (4 bullets total across 3 surfaces; minimum-executable-information)
- correctness: ✓ (named: R1 over-broadness, R2 convergence-tractable tension, R3 cross-skill, R4 operator-policy-choice fallback)
- feasibility: ✓ (NEXT ACTION names executable owner = Skill(governance-modification) flow)
- bottleneck control: ✓ (3 patches independent per dimensional-independence; parallel-safe if needed)
- 8 operator-emphasized keywords (CLAUDE.md §5): `removal-first` ✓ (additive 4 bullets, no over-spec), `consumed-surface` ✓ (canonical mapped-core-law owner + 2 consumer triggers), `no-compression` ✓ (each bullet one rule), `upper-lower execution-drive` ✓ (top-doctrine §3 already covers via [NO-NEEDLESS-ASK]; mapped core law extends), `executable-imperative` ✓ ("is mandatory" + "violation"), `minimum-executable-information` ✓ (4 bullets total), `dimensional-independence` ✓ (mapped-core-law + operational; no identity), `comprehension-as-execution-force` ✓ (5 variance criteria enumerated for clear trigger application)

## OPINION-ROUND REQUEST TO CRITICS
Each critic deliver opinion targeting:
- the choice-situation trigger definition (5 variance criteria sufficient? over-broad? under-specified?)
- the unconditional-mandatory wording (does it conflict with line 91-93 convergence-tractable carve-out?)
- the canonical-owner placement (work-execution-core-law correct? should CLAUDE.md §3 also carry top-doctrine echo?)
- the consumer-trigger placement (work-planning Q1-Q5 + task-execution Step 1 correct? should other consumers be added?)
- R1 / R2 / R3 / R4 risk mitigation
- any other audit-criterion failure or hidden defect

Per `Skill(team-meeting)` `## 3-4. Opinion Round`: each opinion targets whole draft OR specific Item; cite lens basis when material; participants may name failed `MEETING-AUDIT-CRITERIA`; opinion delivery via SendMessage MESSAGE-CLASS: critique-response with carrier pointer.
