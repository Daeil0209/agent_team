MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a, reviewer-shard-b, researcher, developer
ROUND: r4 (operator pre-critic feedback #4 incorporated — "팀 미팅 스킬 규정도 이번 결함을 고려하여 업데이트해라... 내가 하는 이야기를 다 무시해버리는 병신짓거리가 반복되지 않게~!" — Skill(team-meeting) cumulative-input-integration rule added as Item 5; drafter MUST maintain enumeration of all prior operator input + accepted critic opinions + verify reflection in each revision)

## MEETING-AGENDA (cumulative — all operator directives 1-8)
Operator directive 2026-05-26 (now 8-part):
1. Choice situations must trigger critical-discussion-based direction-setting; regulated in + consumed by Skill(work-planning) + Skill(task-execution) [r0]
2. Chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; UNCONDITIONALLY required [r0]
3. USE team-meeting NOW to design + install rule; plug gap; then USE for downstream work [r0]
4. All R1-R4 open questions resolved in design (not deferred to critic round) [r1 pre-critic feedback #1]
5. INVARIANT: chosen direction MUST satisfy ALL §1-§8 upper-philosophy conditions; if presented options fail → mandatory REDESIGN within meeting until compliant; "best of incompliant options" forbidden; non-negotiable [r2 pre-critic feedback #2]
6. ANTI-PASSIVE-WAIT: the defect where active owner asks user "what direction?" then passively waits doing nothing must DISAPPEAR; unconditional defect-removal [r3 pre-critic feedback #3]
7. Anti-passive-wait is a new defect that must ALSO be included in the rule design [r3 pre-critic feedback #3]
8. **(r4 NEW)** Skill(team-meeting) skill body must ALSO be updated to prevent drafter ignoring/missing prior operator input across revisions; this drafter defect must not repeat [r4 pre-critic feedback #4]

## TARGET-OUTCOME (cumulative + Item 5)
- Canonical owner rule (work-execution-core-law `## Autonomy And Escalation Law`) — 5 bullets unchanged from r3
- **5 consumer-surface synchronization triggers** (was 3): Skill(work-planning) + Skill(task-execution) + Skill(governance-modification) + **Skill(team-meeting) cumulative-input rule (Item 5 NEW)**
- All R1-R9 risks named + mitigated
- Post-install: apply to Phase 4-5 best-direction decision via fresh team-meeting under new rule (now with INVARIANT + ANTI-PASSIVE-WAIT + CUMULATIVE-INPUT enforced)

## SOLUTION (revised r4 — **5 items**; Item 5 NEW patches Skill(team-meeting) skill body)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` (canonical mapped-core-law)
UNCHANGED from r3 (5 bullets: trigger + mandatory + INVARIANT + ANTI-PASSIVE-WAIT + fallback)
Full text per draft-r3.md Item 1.

### Item 2 — Skill(work-planning) trigger consumption
UNCHANGED from r3.
Full text per draft-r3.md Item 2.

### Item 3 — Skill(task-execution) trigger consumption
UNCHANGED from r3.
Full text per draft-r3.md Item 3.

### Item 4 — Skill(governance-modification) trigger consumption
UNCHANGED from r3.
Full text per draft-r3.md Item 4.

### Item 5 — Skill(team-meeting) CUMULATIVE-INPUT-INTEGRATION rule (NEW r4)
TARGET: `.claude/skills/team-meeting/SKILL.md` — add to `## 3-5. MEETING-AUDIT-CRITERIA` (Solution essentials list) as new criterion, AND add executable enforcement clause to `## 3-3. Solution Draft` and `## 3-4. Opinion Round`
EDIT-OPERATION: 3 additive insertions (1 in 3-3, 1 in 3-4, 1 in 3-5) — all on same file, dimensional-independence preserved (operational dimension only)

NEW-TEXT 5A (in `## 3-3. Solution Draft`, add after current "Use the default template below."):
```
- Drafter maintains a cumulative enumeration of every operator directive issued during the meeting (initial agenda + every operator pre-critic intervention + every operator post-critic-response intervention) and every accepted critic opinion; this enumeration appears in each revised draft as an `OPERATOR-DIRECTIVE COMPLIANCE CHECK` (or equivalent name) section that traces each prior input to its reflection in the current draft.
```

NEW-TEXT 5B (in `## 3-4. Opinion Round`, add after current "Drafter revises the draft once per round when possible."):
```
- Each revision MUST verify cumulative input integration: every prior operator directive (initial agenda + every pre/post-critic operator intervention) and every accepted critic opinion remains reflected in the revised draft. Silently dropping, omitting, or failing-to-restate prior input across revisions is a procedure-adherence violation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` and disqualifies the revision from advancing to Section 3-5 MEETING-AUDIT-CRITERIA convergence-readiness.
```

NEW-TEXT 5C (in `## 3-5. MEETING-AUDIT-CRITERIA` Solution essentials list, add as new bullet):
```
- cumulative input integration: every prior operator directive and accepted critic opinion is traced + reflected in the current draft via `OPERATOR-DIRECTIVE COMPLIANCE CHECK` enumeration; missing prior input is a failed criterion that returns the solution to revision before Section 3-6 convergence.
```

## WHY THIS SOLVES IT (r4 — S1-S12 from r3 + S13 CUMULATIVE-INPUT)
- (S1-S12) Carried from r3 unchanged.
- (S13 r4 NEW) **CUMULATIVE-INPUT-INTEGRATION enforcement**: Item 5 patches Skill(team-meeting) at 3 locations (Section 3-3 drafter discipline + Section 3-4 revision discipline + Section 3-5 audit criterion) to prevent the exact behavioral defect operator demonstrated this meeting (drafter r0→r1 dropped operator content, then r1→r2 dropped, then r2→r3 had to be corrected for anti-passive-wait). Each revision MUST carry forward all prior operator + critic input as enumerated trace; silently dropping is procedure-adherence violation. The OPERATOR-DIRECTIVE COMPLIANCE CHECK enumeration (demonstrated in r3 + r4 itself) is now skill-body-required, not optional.

## MAIN RISKS OR TRADEOFFS (r4 — R5-R9 from r3 + R10 CUMULATIVE-INPUT enumeration burden)

### R10 (NEW r4) — Cumulative-input enumeration overhead
- Risk: long-running meetings with many operator interventions + many critic opinions accumulate large enumeration → drafter overhead grows linearly per round
- Mitigation: enumeration is reference-only (each entry is one line: directive number + brief content); 8 operator directives in this meeting fit in ~10 lines of enumeration. Each revision verification step is grep-like (does each prior input appear in current draft? Y/N). Overhead is minimal vs information-loss cost of silently dropping input.
- Residual: very large meetings (>20 inputs) may benefit from indexed enumeration; tolerable for typical 5-15 input meetings

### R5-R9 (carried from r1/r2/r3)
- R5 material-variance qualifier judgment
- R6 line 91-93 overlap (co-exist as special case)
- R7 cap-overflow (fallback chain)
- R8 redesign exhaustion (fallback chain after documented)
- R9 user-owned blocker edge (not anti-passive-wait scope)

## NEXT ACTION
After unanimous critics' consent on r4 + operator gate accept, route to `Skill(governance-modification)` for **5-patch loop** (work-execution-core-law canonical 5-bullet + 3 consumer triggers + Skill(team-meeting) 3-location patch). Each patch follows Step 3 review-verification + Step 4 design + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract.

After all 5 patches applied + post-verified, the new rule (with INVARIANT + ANTI-PASSIVE-WAIT + CUMULATIVE-INPUT-INTEGRATION) is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule + updated team-meeting skill.

## OPERATOR-DIRECTIVE COMPLIANCE CHECK (r4 — explicit enumeration per Item 5 new rule, demonstrated)
| # | Operator Directive | Reflection in r4 |
|---|---|---|
| 1 | choice-situation team-meeting in work-planning + work-execution | Item 1 + Items 2+3 |
| 2 | ALL upper philosophy compliance + UNCONDITIONAL | Item 1 bullets 2-3 |
| 3 | use team-meeting to design + install + apply | NEXT ACTION + this meeting itself |
| 4 | all R1-R4 open questions resolved | r1 + r2 + r3 risk catalog (R1-R9) named + mitigated |
| 5 | INVARIANT redesign mandate | Item 1 bullet 3 INVARIANT |
| 6 | anti-passive-wait defect must disappear | Item 1 bullet 4 ANTI-PASSIVE-WAIT |
| 7 | include anti-passive-wait as new defect | Item 1 bullet 4 + S12 + each consumer trigger |
| 8 | Skill(team-meeting) skill body update for cumulative-input | Item 5 (3 patches across Section 3-3/3-4/3-5) + S13 |

ALL 8 operator directives reflected in r4. No omissions.

## MEETING-AUDIT-CRITERIA Self-Check (drafter, r4)
- agenda fit: ✓ (r4 addresses all 8 operator-directive parts)
- simplicity: ✓ (11 bullets total across 5 surfaces; minimum-executable-information)
- correctness: ✓ (R1-R10 named + mitigated)
- feasibility: ✓ (NEXT ACTION = Skill(governance-modification) 5-patch loop)
- bottleneck control: ✓ (5 patches independent per dimensional-independence; Item 5 has 3 location patches but all on one file, still single-patch boundary)
- cumulative input integration (NEW per Item 5C): ✓ (OPERATOR-DIRECTIVE COMPLIANCE CHECK section above traces all 8 inputs)
- 8 operator-emphasized keywords (CLAUDE.md §5):
  - `removal-first` ✓ (additive 11 bullets total across 5 surfaces; line 91-93 retained)
  - `consumed-surface` ✓ (canonical + 4 consumers including team-meeting itself)
  - `no-compression` ✓ (each bullet one rule)
  - `upper-lower execution-drive` ✓
  - `executable-imperative` ✓ ("unconditionally mandatory" + "MUST" + "EXECUTES" + "violation" + "INVARIANT" + procedure-adherence violation wording in Item 5)
  - `minimum-executable-information` ✓ (11 bullets; no examples beyond illustrative parenthetical)
  - `dimensional-independence` ✓ (mapped-core-law + operational layer for skills; no identity-layer)
  - `comprehension-as-execution-force` ✓ (explicit OPERATOR-DIRECTIVE COMPLIANCE CHECK table format demonstrates the cumulative-input rule)

## OPINION-ROUND REQUEST TO CRITICS (r4 supersedes r3; r3 superseded r2; r2 superseded r1)
Each critic deliver opinion targeting:
- the 5 SOLUTION items (Items 1-4 from r3 unchanged + Item 5 NEW Skill(team-meeting) 3-location patch)
- the CUMULATIVE-INPUT-INTEGRATION clause specifically: does the 3-location patch (3-3 drafter + 3-4 revision + 3-5 audit) cover all loophole shapes? is "silently dropping prior input is procedure-adherence violation" enforceable? does the OPERATOR-DIRECTIVE COMPLIANCE CHECK enumeration shape work for typical meetings?
- the R10 enumeration burden risk: scale to large meetings sufficiently mitigated?
- the OPERATOR-DIRECTIVE COMPLIANCE CHECK table above (verify drafter actually demonstrated the new rule by enumerating all 8 directives + their reflection)
- the WHY THIS SOLVES IT rationale (S1-S13)
- the MEETING-AUDIT-CRITERIA self-check (any failed criterion?)
- any new defect or risk not covered

Critique-response delivery: SendMessage MESSAGE-CLASS: critique-response with carrier pointer to `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r4-<your-member-name>.md`.
