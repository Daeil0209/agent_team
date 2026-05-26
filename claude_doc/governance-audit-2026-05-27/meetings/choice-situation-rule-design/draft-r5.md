MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a, reviewer-shard-b, researcher, developer
ROUND: r5 (operator pre-critic feedback #5 incorporated — "그리고 기본적으로 팀리드가 어떤 결정이 필요할 경우, 팀 회의 스킬과 코덱스를 백그라운드로 활용할 수 있도록 규정을 보완해야할 것 같아. 이것도 포함시켜" — BACKGROUND-DECISION-SUPPORT authorization added as canonical Item 1 bullet 6; team-lead may invoke Skill(team-meeting) parallel critique + Skill(codex-independent-review) Pattern A in background while continuing other orchestration work)

## MEETING-AGENDA (cumulative — all operator directives 1-9)
Operator directive 2026-05-26 (now 9-part):
1. Choice situations must trigger critical-discussion-based direction-setting; regulated in + consumed by Skill(work-planning) + Skill(task-execution) [r0]
2. Chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; UNCONDITIONALLY required [r0]
3. USE team-meeting NOW to design + install rule; plug gap; then USE for downstream work [r0]
4. All R1-R4 open questions resolved in design (not deferred to critic round) [r1 pre-critic feedback #1]
5. INVARIANT: chosen direction MUST satisfy ALL §1-§8 upper-philosophy conditions; if presented options fail → mandatory REDESIGN within meeting until compliant; "best of incompliant options" forbidden; non-negotiable [r2 pre-critic feedback #2]
6. ANTI-PASSIVE-WAIT: the defect where active owner asks user "what direction?" then passively waits doing nothing must DISAPPEAR; unconditional defect-removal [r3 pre-critic feedback #3]
7. Anti-passive-wait is a new defect that must ALSO be included in the rule design [r3 pre-critic feedback #3]
8. Skill(team-meeting) skill body must ALSO be updated to prevent drafter ignoring/missing prior operator input across revisions [r4 pre-critic feedback #4]
9. **(r5 NEW)** Basically (fundamentally), when team-lead needs any decision, the rule must be supplemented so that Skill(team-meeting) + Codex can be used in the BACKGROUND; include this [r5 pre-critic feedback #5]

## TARGET-OUTCOME (cumulative + BACKGROUND-DECISION-SUPPORT)
- Canonical owner rule (work-execution-core-law `## Autonomy And Escalation Law`) — **6 bullets** now (was 5 in r3/r4): trigger + mandatory + INVARIANT + ANTI-PASSIVE-WAIT + fallback + **BACKGROUND-DECISION-SUPPORT (NEW r5)**
- 4 consumer-surface patches (Skill(work-planning) + Skill(task-execution) + Skill(governance-modification) + Skill(team-meeting) cumulative-input from r4)
- All R1-R10 risks named + mitigated + R11 (NEW r5 background usage coordination)
- Post-install: apply to Phase 4-5 best-direction decision via fresh team-meeting under new rule (INVARIANT + ANTI-PASSIVE-WAIT + CUMULATIVE-INPUT + BACKGROUND-DECISION-SUPPORT)

## SOLUTION (revised r5 — 5 items; canonical Item 1 now 6 bullets including BACKGROUND-DECISION-SUPPORT)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` (canonical mapped-core-law)
TARGET: `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` — insert 6 bullets after current line 90
EDIT-OPERATION: additive insertion of **6 bullets** (was 5 in r3/r4; BACKGROUND-DECISION-SUPPORT added as new bullet 6)

NEW-TEXT (proposed, r5):
```
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- INVARIANT: the team-meeting outcome direction MUST satisfy ALL §1-§8 upper-philosophy conditions per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes; when any presented option fails to satisfy ALL conditions, the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `## 3-4. Opinion Round`) until at least one option satisfies all upper-philosophy conditions. Selection of an upper-philosophy-incompliant option, picking the "best of incompliant options", or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation.
- ANTI-PASSIVE-WAIT: after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately in the same execution segment per `## Execution Progress Law` (line 158 "Process state report opens the next truthful action in the same turn") and `[NO-NEEDLESS-ASK]` (line 88 "Choose the evidence-backed best solution"); the active owner does NOT pause to ask the user "which direction?" or "shall I proceed?" or seek any direction-confirmation after the meeting has decided. Passive waiting for user direction-confirmation post-team-meeting is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation; the team-meeting outcome IS the direction, and execution is the next-truthful-action.
- Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test (line 92 below — bounded, reversible, ≥2 critics with material lens basis) OR when the meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap after exhausting redesign rounds: route to operator-policy-choice user escalation per the standard exception classes at lines 95-99 with explicit record of which upper-philosophy conditions remain incompliant in every option; direct user escalation that bypasses the team-meeting attempt, skips the redesign requirement, OR pauses for direction-confirmation after team-meeting convergence is invalid.
- BACKGROUND-DECISION-SUPPORT: when team-lead needs any consequential decision (choice situation per above OR other consequential decision requiring evidence/critique), team-lead may invoke `Skill(team-meeting)` (via parallel critique-request dispatch to team members per Section 3-4 parallel-critic clause) and/or `Skill(codex-independent-review)` Pattern A (team-lead variant via Bash background invocation per `.claude/skills/codex-independent-review/references/concurrent-patterns.md` `### Pattern A — Team-Lead Variant`) in the BACKGROUND while continuing other parallel orchestration work; background usage preserves orchestration continuity, avoids serial blocking, and reduces context pressure. Background results return via Communication Plane (team-meeting critique-response or codex output) and integrate per the INVARIANT + ANTI-PASSIVE-WAIT rules above; background usage does NOT exempt team-lead from INVARIANT or ANTI-PASSIVE-WAIT requirements.
```

### Items 2-4 — consumer triggers (unchanged from r3/r4)
Each consumer trigger remains as in r3/r4; the BACKGROUND-DECISION-SUPPORT rule (Item 1 bullet 6) propagates by inheritance — consumer triggers cite "per canonical INVARIANT" which now includes background authorization.

### Item 5 — Skill(team-meeting) CUMULATIVE-INPUT-INTEGRATION (unchanged from r4)
3-location patch at Section 3-3 + 3-4 + 3-5 per r4 text.

## WHY THIS SOLVES IT (r5 — S1-S13 from r4 + S14 BACKGROUND-DECISION-SUPPORT)
- (S1-S13) Carried from r4 unchanged.
- (S14 r5 NEW) **BACKGROUND-DECISION-SUPPORT authorization**: canonical Item 1 bullet 6 explicitly authorizes team-lead to use Skill(team-meeting) parallel critique-request dispatch + Skill(codex-independent-review) Pattern A team-lead variant in the BACKGROUND. Preserves orchestration continuity (team-lead continues other work while meeting + codex run). Reduces context pressure (parallel evidence gathering vs serial blocking). Standing authorization for fundamentally-any team-lead decision needing evidence/critique support. Cited canonical surfaces: `Skill(team-meeting)` Section 3-4 parallel-critic clause + `concurrent-patterns.md` Pattern A Team-Lead Variant. Background usage is bounded by INVARIANT + ANTI-PASSIVE-WAIT (does NOT exempt these requirements).

## MAIN RISKS OR TRADEOFFS (r5 — R5-R10 from r4 + R11 BACKGROUND-coordination)

### R11 (NEW r5) — Background concurrent execution coordination
- Risk: team-lead runs Skill(team-meeting) parallel critics + Skill(codex-independent-review) Pattern A background simultaneously → ACTIVE-CONCURRENT-AGENT-CAP overflow OR background output sequencing confusion
- Mitigation: existing `.claude/skills/work-planning/references/parallel-fit.md` cap rules apply; team-meeting critics count toward cap; codex Pattern A bash background does NOT count toward team-agent cap (codex is external CLI per concurrent-patterns.md). Sequencing handled by Communication Plane: critique-response + codex output arrive at different times; team-lead integrates each as it arrives per ANTI-PASSIVE-WAIT (no wait).
- Residual: when both background channels overlap and the team-lead needs to wait for BOTH to converge, the wait is ON CONCRETE EVIDENCE not on direction-confirmation; not anti-passive-wait violation. Team-lead continues other parallel orchestration work during overlap.

### R5-R10 (carried from r1/r2/r3/r4)
Unchanged.

## NEXT ACTION
After unanimous critics' consent on r5 + operator gate accept, route to `Skill(governance-modification)` for **5-patch loop** (work-execution-core-law canonical 6-bullet + 3 consumer triggers from r3 + Skill(team-meeting) 3-location patch from r4). Each patch follows Step 3 review-verification + Step 4 design + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract.

After all 5 patches applied + post-verified, the new rule (with INVARIANT + ANTI-PASSIVE-WAIT + CUMULATIVE-INPUT + BACKGROUND-DECISION-SUPPORT) is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule + updated team-meeting skill — team-lead leverages BACKGROUND-DECISION-SUPPORT to dispatch critics + codex in parallel while preparing Phase 4 design infrastructure.

## OPERATOR-DIRECTIVE COMPLIANCE CHECK (r5 — per Skill(team-meeting) cumulative-input rule)
| # | Operator Directive | Reflection in r5 |
|---|---|---|
| 1 | choice-situation team-meeting in work-planning + work-execution | Item 1 + Items 2+3 |
| 2 | ALL upper philosophy compliance + UNCONDITIONAL | Item 1 bullets 2-3 |
| 3 | use team-meeting to design + install + apply | NEXT ACTION + this meeting |
| 4 | all R1-R4 open questions resolved | r1-r5 risk catalog (R1-R11) named + mitigated |
| 5 | INVARIANT redesign mandate | Item 1 bullet 3 |
| 6 | anti-passive-wait defect must disappear | Item 1 bullet 4 |
| 7 | include anti-passive-wait as new defect | Item 1 bullet 4 + consumer triggers |
| 8 | Skill(team-meeting) skill body cumulative-input update | Item 5 |
| 9 | **(NEW r5)** team-lead background usage of Skill(team-meeting) + Codex authorized | Item 1 bullet 6 BACKGROUND-DECISION-SUPPORT |

ALL 9 operator directives reflected in r5. No omissions.

## MEETING-AUDIT-CRITERIA Self-Check (drafter, r5)
- agenda fit: ✓ (r5 addresses all 9 operator-directive parts)
- simplicity: ✓ (12 bullets total across 5 surfaces; minimum-executable-information)
- correctness: ✓ (R1-R11 named + mitigated)
- feasibility: ✓ (NEXT ACTION = Skill(governance-modification) 5-patch loop)
- bottleneck control: ✓ (5 patches independent per dimensional-independence; BACKGROUND-DECISION-SUPPORT explicitly addresses bottleneck reduction)
- cumulative input integration: ✓ (OPERATOR-DIRECTIVE COMPLIANCE CHECK above traces all 9 inputs to reflections)
- 8 operator-emphasized keywords (CLAUDE.md §5):
  - `removal-first` ✓ (additive 12 bullets; line 91-93 retained)
  - `consumed-surface` ✓ (canonical + 4 consumers)
  - `no-compression` ✓ (each bullet one rule)
  - `upper-lower execution-drive` ✓
  - `executable-imperative` ✓ ("unconditionally mandatory" + "MUST" + "EXECUTES" + "may invoke" + procedure-adherence violation wording)
  - `minimum-executable-information` ✓ (12 bullets; no examples beyond brief parenthetical)
  - `dimensional-independence` ✓ (mapped-core-law + operational; no identity-layer)
  - `comprehension-as-execution-force` ✓ (background-decision-support cites concrete canonical surfaces enabling immediate consumption)

## OPINION-ROUND REQUEST TO CRITICS (r5 supersedes r4)
Each critic deliver opinion targeting:
- the 5 SOLUTION items (Item 1 canonical 6 bullets including NEW BACKGROUND-DECISION-SUPPORT bullet 6 + Items 2-4 consumer triggers + Item 5 Skill(team-meeting) 3-location patch)
- the BACKGROUND-DECISION-SUPPORT clause specifically: does the citation chain (team-meeting Section 3-4 parallel + concurrent-patterns Pattern A Team-Lead Variant) make background usage immediately invocable? does R11 cover the realistic overlap edge cases? is "does NOT exempt INVARIANT/ANTI-PASSIVE-WAIT" enforceable when parallel background channels are in flight?
- the OPERATOR-DIRECTIVE COMPLIANCE CHECK table above (verify all 9 directives traced + reflected)
- the WHY THIS SOLVES IT rationale (S1-S14)
- the MEETING-AUDIT-CRITERIA self-check (any failed criterion?)
- any new defect or risk not covered

Critique-response delivery: SendMessage MESSAGE-CLASS: critique-response with carrier pointer to `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r5-<your-member-name>.md`.
