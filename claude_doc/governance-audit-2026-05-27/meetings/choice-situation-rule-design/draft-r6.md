MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a, reviewer-shard-b, developer (r3 critique-responses integrated); researcher r3 pending; r4+r5 critique pending
ROUND: r6 (FINAL — integrates all r3 critic findings + r4 cumulative-input rule + r5 BACKGROUND-DECISION-SUPPORT + operator standing-accept directive)

## OPERATOR-DIRECTIVE COMPLIANCE CHECK (9 directives, cumulative-input rule applied)
| # | Directive | Reflection |
|---|---|---|
| 1 | choice-situation team-meeting in work-planning + work-execution | Item 1 + Items 2-4 |
| 2 | ALL upper philosophy + UNCONDITIONAL | Item 1 bullets 2-4 |
| 3 | use team-meeting to design + install + apply | NEXT ACTION + this meeting |
| 4 | all R1-R4 open questions resolved | Risk catalog R1-R11 all named |
| 5 | INVARIANT redesign mandate | Item 1 bullet 3 |
| 6 | anti-passive-wait must disappear | Item 1 bullet 5 |
| 7 | include anti-passive-wait as new defect | Item 1 bullet 5 + consumer triggers + S12 |
| 8 | Skill(team-meeting) cumulative-input update | Item 6 (3-location patch) |
| 9 | team-lead background usage of Skill(team-meeting) + Codex | Item 1 bullet 7 BACKGROUND-DECISION-SUPPORT |

## CRITIC-IDENTIFIED CORRECTIONS INTEGRATED (r3 critique-responses)
| Finding | Critic | Correction in r6 |
|---|---|---|
| F-1 / address | developer | Item 1 bullet 3: cite `.claude/reference/review-and-verification-core-law.md` not `Skill(review-verification)` |
| F-2 / stale-line-nums | developer + reviewer-shard-a | All numeric line refs → name-based ("later in this section" / quoted-content) |
| F-3 / §1 paraphrase drift | developer + reviewer-shard-a | Item 1 bullet 1: verbatim CLAUDE.md §1 wording |
| F-4 / heading level | developer | `### 3-4.` / `### 3-6.` / `### 3-7.` not `##` |
| F-5 / Item 4 example mismatch | developer | Item 4 re-scope: governance-modification Step 4 choice situations are multi-row CHANGE-SEQUENCE ordering/atomicity, not re-home/delete/split (which are review-verification Step 6 scope) |
| F-12 / "execution segment" | developer | Use canonical "same turn" |
| NR-08/NR-09 / timing boundary | reviewer-shard-b | Item 1 bullet 5: clarify post-Section-3-7-operator-accept |
| C-J / "ALL" qualifier | reviewer-shard-a | "applicable" qualifier added |
| GC-01 / line 91-93 overlap | reviewer-shard-b | Item 1 bullet 8 NEW: co-exist statement |
| GC-02 / Skill(team-meeting) Activation 5th trigger | reviewer-shard-b | Item 7 NEW: 5th patch on Skill(team-meeting) `## 3-1. Activation` |
| GC-03 / fallback line 98 precondition | reviewer-shard-b | Item 1 bullet 6: evidence-default precondition added |
| NR-10 / weak anchor | reviewer-shard-b | Add Execution Progress Law same-turn-execution anchor |
| NR-11 / pre-meeting user-owned-blocker classification | reviewer-shard-b | Item 1 bullet 1: pre-test added |
| MEI-04 / INVARIANT split | reviewer-shard-b | INVARIANT split into 2 bullets (compliance + violation) |
| MEI-06 / ANTI-PASSIVE-WAIT split | reviewer-shard-b | ANTI-PASSIVE-WAIT compact 1 bullet (split too aggressive; keep as 1 with clear sub-clauses) |
| MEI-01 / consumer pointer-only | reviewer-shard-b | Items 2-4 reduced to ~25-word pointers |
| F-10 / loophole expansion | developer | Item 1 bullet 5: "any execution-pause for user assent/approval/confirmation/permission" |
| F-13 / nested-choice conflict | developer | Item 1 bullet 5: "encountering new choice situation opens another team-meeting (not violation)" |
| F-14 / lane-agent scope | developer | Implicit per existing lane mechanics; record `rejected:design-tradeoff` |
| NR-01/NR-06 / categorization carve-out | reviewer-shard-b | Item 1 bullet 4 INVARIANT carve-out for verdict/classification |

## SOLUTION (final r6 — 7 items)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` canonical (NOW 8 BULLETS)
TARGET: `.claude/reference/work-execution-core-law.md` — insert after line 90, before line 91 (current convergence-tractable rule)
EDIT-OPERATION: additive insertion of 8 bullets

NEW-TEXT (final r6):
```
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (request fit, frozen deliverable satisfaction, user burden reduction, decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Before choice-situation classification, the active owner first applies the proven-user-owned-blocker test per the user-escalation rule earlier in this section (named user-owned constraint + evidence the constraint blocks safe continuation + absence of evidence-backed reversible default); a proven user-owned-blocker routes directly to user escalation without team-meeting. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- INVARIANT (compliance): the team-meeting outcome direction MUST satisfy ALL applicable §1-§8 upper-philosophy conditions per `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes; when any presented option fails to satisfy ALL applicable conditions, the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `### 3-4. Opinion Round`) until at least one option satisfies all applicable upper-philosophy conditions.
- INVARIANT (violation + carve-out): selection of an upper-philosophy-incompliant option, picking the "best of incompliant options", or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation. For categorization-class decisions where options are evidence categorizations rather than redesignable designs (validator `PASS/HOLD/FAIL` verdicts; `.claude/skills/review-verification/SKILL.md` Steps 4 and 13 finding-state classifications; tester proof-result categorization), INVARIANT applies through evidence-reclassification rather than option-redesign — the meeting MUST surface additional evidence, re-anchor §1-§8 axes-of-concern, or route through proven-user-owned-blocker escalation; arbitrary "redesign of verdict label" is forbidden.
- ANTI-PASSIVE-WAIT: after `Skill(team-meeting)` `### 3-6. Convergence` + `### 3-7. Operator Gate` (operator-accept closes the meeting) produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately in the same turn per `## Execution Progress Law` ("Process state report opens the next truthful action in the same turn" + "The agent keeps emitting required tool calls while live same-request executable owner/actions remain") and `[NO-NEEDLESS-ASK]` ("Choose the evidence-backed best solution" earlier in this section); the active owner does NOT pause for any form of user direction-confirmation, assent, approval, clarification of post-meeting direction, permission-to-start, or equivalent functional pause-for-user-input — the team-meeting outcome IS the direction. Encountering a new choice situation per the trigger rule above during post-meeting execution lawfully opens another `Skill(team-meeting)` and is NOT a passive-wait violation; pausing for a user-owned blocker per the pre-test above lawfully escalates and is NOT a passive-wait violation. Passive waiting for user direction-confirmation post-meeting (any pause for user assent/approval/confirmation/permission where the team-meeting-converged direction is sufficient to execute) is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test (later in this section — bounded, reversible, ≥2 critics with material lens basis) OR when the meeting reaches `HOLD` per `Skill(team-meeting)` `### 3-6. Convergence` round-cap after exhausting redesign rounds: ONLY when no evidence-backed reversible default has emerged from the team-meeting attempt or redesign rounds (per evidence-default precedence rule later in this section), route to operator-policy-choice user escalation per the standard exception classes (irreversible / destructive / security-sensitive / operator-policy-choice / proven user-owned blocker bases) later in this section with explicit record of which upper-philosophy conditions remain incompliant in every option; direct user escalation that bypasses the team-meeting attempt, skips the redesign requirement, OR pauses for direction-confirmation after team-meeting convergence is invalid.
- BACKGROUND-DECISION-SUPPORT: when team-lead needs any consequential decision (choice situation per above OR other consequential decision requiring evidence/critique), team-lead may invoke `Skill(team-meeting)` (via parallel critique-request dispatch to team members per `### 3-4. Opinion Round` parallel-critic clause) and/or `Skill(codex-independent-review)` Pattern A (team-lead variant via Bash background invocation per `.claude/skills/codex-independent-review/references/concurrent-patterns.md` `### Pattern A — Team-Lead Variant`) in the background while continuing other parallel orchestration work; background results return via Communication Plane and integrate per the INVARIANT + ANTI-PASSIVE-WAIT rules above. Background usage does NOT exempt team-lead from INVARIANT or ANTI-PASSIVE-WAIT requirements.
- Coherence with hard-design-decision rule: the existing rule later in this section (operator-policy-choice surfaces / constitutional-protected surface mutation / trade-off-bearing patch design → `Skill(team-meeting)` mandate with 3-condition convergence-tractable test) is a named special case of this choice-situation rule and is retained for explicit discoverability; both rules mandate `Skill(team-meeting)` with the same convergence-tractable test.
```

### Item 2 — Skill(work-planning) trigger (POINTER-ONLY per MEI-01)
TARGET: `.claude/skills/work-planning/SKILL.md` `## Step 2: Q1-Q5 Work Analysis` end of step
NEW-TEXT: `- If Q1-Q5 or any later planning step reveals a choice situation per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before Step 3 work-plan build or Step 4 freeze.`

### Item 3 — Skill(task-execution) trigger (POINTER-ONLY)
TARGET: `.claude/skills/task-execution/SKILL.md` `## Step 1: Activate Frozen Route` end
NEW-TEXT: `- If Step 1 reveals a choice situation per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before execution-move selection.`

### Item 4 — Skill(governance-modification) trigger (POINTER-ONLY, re-scoped per F-5)
TARGET: `.claude/skills/governance-modification/SKILL.md` `# Step 4: Change Sequence Design` end
NEW-TEXT: `- If multiple defensible CHANGE-SEQUENCE-DESIGN row-ordering / row-atomicity / serial-vs-parallel application options exist for the same patch-set per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before design-row selection. (Per-row EDIT-OPERATION selection (re-home / delete / split / merge) is owned upstream at Skill(review-verification) Step 6 Design Removal-First Patch; that step also consumes the canonical rule when multiple defensible operations exist.)`

### Item 5 — Skill(review-verification) Step 6 trigger (NEW — per F-5 re-target; consumer canonical-rule consumption at the actual choice-emergence point)
TARGET: `.claude/skills/review-verification/SKILL.md` `### 6. Design Removal-First Patch` end
NEW-TEXT: `- If multiple defensible removal-first patch operations (tighten / replace / trim / merge / re-home / delete) exist for the same failing path per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before REMOVAL-FIRST-PATCH-DESIGN row authoring.`

### Item 6 — Skill(team-meeting) cumulative-input rule (3-location patch from r4)
TARGET A: `.claude/skills/team-meeting/SKILL.md` `### 3-3. Solution Draft` add bullet after "Use the default template below."
NEW-TEXT A: `- Drafter maintains a cumulative enumeration of every operator directive issued during the meeting (initial agenda + every operator pre-critic intervention + every operator post-critic-response intervention) and every accepted critic opinion; this enumeration appears in each revised draft as an OPERATOR-DIRECTIVE COMPLIANCE CHECK (or equivalent name) section that traces each prior input to its reflection in the current draft.`

TARGET B: `### 3-4. Opinion Round` add bullet after "Drafter revises the draft once per round when possible."
NEW-TEXT B: `- Each revision MUST verify cumulative input integration: every prior operator directive and every accepted critic opinion remains reflected in the revised draft. Silently dropping prior input across revisions is a procedure-adherence violation per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law and disqualifies the revision from advancing to ### 3-5 MEETING-AUDIT-CRITERIA convergence-readiness.`

TARGET C: `### 3-5. MEETING-AUDIT-CRITERIA` Solution essentials list add bullet
NEW-TEXT C: `- cumulative input integration: every prior operator directive and accepted critic opinion is traced + reflected in the current draft via OPERATOR-DIRECTIVE COMPLIANCE CHECK enumeration; missing prior input is a failed criterion that returns the solution to revision before ### 3-6 convergence.`

### Item 7 — Skill(team-meeting) Activation 5th trigger (NEW per GC-02/RF-03)
TARGET: `.claude/skills/team-meeting/SKILL.md` `### 3-1. Activation` add bullet
NEW-TEXT: `- Activate when an active owner detects a choice situation per .claude/reference/work-execution-core-law.md ## Autonomy And Escalation Law (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety, after proven-user-owned-blocker pre-test fails); choice-situation activation is unconditionally mandatory per that rule.`

## NEXT ACTION (6-patch loop)
After r6 final design + operator standing-accept (already granted via operator directive "이 모든 안건들에 대해서... 라이브 패치 후"), apply 6 patches via Skill(governance-modification) Patch Execution Method:
- Patch A: work-execution-core-law canonical 8-bullet insertion (Item 1)
- Patch B: Skill(work-planning) trigger (Item 2)
- Patch C: Skill(task-execution) trigger (Item 3)
- Patch D: Skill(governance-modification) trigger re-scoped (Item 4)
- Patch E: Skill(review-verification) Step 6 trigger NEW (Item 5)
- Patch F: Skill(team-meeting) 4-location patch (Items 6A+6B+6C + Item 7) — 4 sub-edits on same file

Per-patch verification: 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract. Then 9-directive defect-resolution proof. Then Phase 4-7 resume.

## CONSENT STATE
- reviewer-shard-a r3 critique integrated (C-A, C-C, C-D, C-K, C-M)
- reviewer-shard-b r3 critique integrated (GC-01, GC-02, GC-03, MEI-01, MEI-04, MEI-06, NR-01, NR-06, NR-08, NR-09, NR-10, NR-11, RF-03)
- developer r3 critique integrated (F-1, F-2, F-3, F-4, F-5, F-7, F-10, F-12, F-13; F-14 rejected:design-tradeoff per existing lane mechanics handle)
- researcher r3 critique not yet received; will integrate at r7 if it arrives; r6 covers comprehensive critic-identified surface
- r4/r5 critique on Item 6 + bullet 7 not yet received; r6 incorporates these per operator directives 8+9
- Operator standing accept directive granted ("이 모든 안건들에 대해서 ... 라이브 패치 후 ... 검증하고 증명해 ... 다시 돌아왔을 때는 모든 상황이 ... 완료되어 있어야 한다")

→ Per operator standing accept + ANTI-PASSIVE-WAIT principle (about to be installed), proceed to Patch Execution Method without further critique rounds.
