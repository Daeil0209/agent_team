CRITIC: reviewer-shard-b
MEETING-ID: choice-situation-rule-design
ROUND: r5
DRAFT-CARRIER: claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r5.md
SUPERSEDES-CHAIN: critique-r3-reviewer-shard-b.md → (no r4 critique authored) → critique-r5-reviewer-shard-b.md (r5 supersedes r4 supersedes r3)
ASSIGNED-LENSES: governance-continuity-lens, minimum-executable-information-lens, negative-risk-lens, removal-first-lens
COMPLEMENTARY-CRITICS: reviewer-shard-a (lens: design-intent + coherence-integrity + patch-worthiness), researcher + developer (lens scopes not assigned to this critique)

R3+R4 FINDING DELTA (fold rule against r5):
- r4 INTRODUCED Item 5 (Skill(team-meeting) Section 3-3 + 3-4 + 3-5 cumulative-input-integration patch) — POSITIVE structural addition; r4 demonstrated rule via OPERATOR-DIRECTIVE COMPLIANCE CHECK table; r5 carries this unchanged
- r4 patch count became 5 (was 4 in r3) but the 5th patch is cumulative-input, NOT the GC-02-specific Section 3-1 Activation patch I requested — so RF-03 numerically partially addressed, GC-02 substantively still unresolved
- r5 ADDED Item 1 bullet 6 (BACKGROUND-DECISION-SUPPORT) — citation chain has substantive issues per NR-12/NR-13/NR-14/NR-15 below
- 15 r3 material objections + 4 new r3-specific → r5 carries 14 unresolved + introduces 5 new findings (4 critical r5-specific + 1 minor)

OVERALL-STANCE: candidate-classified-with-revision (still not consent-ready; r5 BACKGROUND-DECISION-SUPPORT clause has CRITICAL semantic mismatches with canonical concurrent-patterns.md that must be resolved; r4 cumulative-input addition is positive; carry-forward findings largely unresolved)

================================================================================
GOVERNANCE-CONTINUITY-LENS FINDINGS (r5)
================================================================================

[GC-01 carry-forward] Implicit overlap with existing line 91-93 — STILL UNRESOLVED
  STATUS-vs-r3: unresolved across r4 and r5.
  STATE: candidate-classified

[GC-02 carry-forward] Skill(team-meeting) Section 3-1 Activation 4th trigger MISSING — STILL UNRESOLVED
  STATUS-vs-r3: unresolved. r4 added Item 5 patching Section 3-3 + 3-4 + 3-5 (cumulative-input) but NOT Section 3-1 (Activation). r5 carries the same gap.
  EVIDENCE: Canonical Item 1 bullet 2 mandates Skill(team-meeting) consumption on choice situations. Skill(team-meeting) `## 3-1. Activation` (lines 42-45) recognizes 3 triggers; no trigger for "choice situation per work-execution-core-law `## Autonomy And Escalation Law`". Per .claude/CLAUDE.md line 55 situation-scoped-skill-activation rule, the consuming surface must recognize the trigger via its own activation rule.
  PROPOSED-REVISION (carry-forward): Item 5 must include a 4th patch location at Section 3-1 Activation adding 4th trigger: "Activate when `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` choice-situation rule fires per its trigger condition." This makes Item 5 a 4-location patch (Section 3-1 + 3-3 + 3-4 + 3-5) on same file.
  STATE: candidate-classified (correlated with RF-03)

[GC-03 carry-forward] Fallback chain doesn't preserve line 98 evidence-default-first precedence — STILL UNRESOLVED
  STATE: candidate-classified

[GC-04 NEW r5] BACKGROUND-DECISION-SUPPORT bullet 6 transport-boundary representation contradicts cited canonical owner
  ANCHOR: draft-r5.md Item 1 NEW-TEXT bullet 6 ("Background results return via Communication Plane (team-meeting critique-response or codex output) and integrate per the INVARIANT + ANTI-PASSIVE-WAIT rules above") vs concurrent-patterns.md lines 27-32 + 37-43 (Pattern A team-lead variant Authority + Transport Boundary)
  EVIDENCE: Bullet 6 says background results "return via Communication Plane (team-meeting critique-response OR codex output)" and "integrate per the INVARIANT + ANTI-PASSIVE-WAIT rules above". This wording conflates two DIFFERENT transport semantics:
    - team-meeting critique-response IS transported via Communication Plane (correct per task-execution/references/message-classes.md `## Communication Plane Law` non-state-class envelope rules)
    - codex output via Pattern A team-lead variant IS NOT transported via any carrier surface per concurrent-patterns.md:27-32 ("Codex output produced via Pattern A is lead-internal aid (team-lead variant) only. Codex output MAY NOT appear in any transported surface — not in any completion carrier, not in SendMessage envelope or body, not in retained-output files cited by completion handoff, not in task state, not in any retained carrier consumed by downstream owners, not in any user-facing reporting surface, not in any synthesis carrier consumed by downstream owners")
  Per concurrent-patterns.md:37-43 Team-Lead Variant Additional Safeguards: "Pattern A output (team-lead variant) MAY NOT appear in any user-facing reporting surface, any retained synthesis carrier consumed by downstream owners (lane assignments, validator verdict carriers, final reports), any completion-grade transport, any reportable prose admitted by `.claude/reference/reporting-prohibition-law.md`, or any retained carrier or task-state field" + "Team-lead synthesis carriers MUST cite their own evidence basis (Read/Grep/Bash tool-call evidence, lane completion carriers, validator verdicts, review-verification packets) — NOT Pattern A codex output."
  Defeater test: bullet 6 implies codex output is integrable into decision basis like critique-response. But canonical owner explicitly forbids this. Either (a) the new rule authorizes transport-impermissible behavior (governance contradiction) or (b) bullet 6 wording misleads future readers (comprehension defect).
  Additional concern per concurrent-patterns.md:45-47: "Team-lead's path to PARALLEL-EXECUTION codex aid is team-lead Pattern A, NOT Pattern C ... There is NO 'team-lead Pattern C with parallel-execution' path — Pattern C is foreground-only per common-contract.md". So if team-lead wants TRANSPORTABLE codex evidence, they must use Pattern C (foreground-blocking, NOT background); if they want BACKGROUND codex usage, output is lead-internal only.
  PROPOSED-REVISION: Bullet 6 must distinguish transport semantics explicitly:
    "...team-meeting critique-response returns via Communication Plane as transportable decision evidence; Skill(codex-independent-review) Pattern A team-lead variant output is lead-internal aid only per `concurrent-patterns.md` `### Team-Lead Variant — Additional Safeguards` (informs the team-lead's own framing without itself being transported, cited as synthesis evidence, or substituting for Skill(review-verification) packet). For TRANSPORTABLE codex evidence consumed by validator / governance-modification / synthesis carriers, team-lead must use Pattern C foreground-blocking via `mcp__codex__codex` per `concurrent-patterns.md` `### Pattern C` — there is NO team-lead Pattern C parallel-execution path."
  STATE: candidate-classified (CRITICAL — governance contradiction risk)

================================================================================
MINIMUM-EXECUTABLE-INFORMATION-LENS FINDINGS (r5)
================================================================================

[MEI-01 carry-forward + AMPLIFIED] Consumer trigger bullets still ~110 words each — UNRESOLVED
  STATUS-vs-r3: unresolved. r4 unchanged; r5 unchanged. Consumer bullets propagate "per canonical INVARIANT" which (per Item 4 in r5) now also implicitly includes BACKGROUND-DECISION-SUPPORT.
  STATE: candidate-classified (correlated with RF-01)

[MEI-04 carry-forward] INVARIANT bullet 3 over-packs ~7-8 sub-rules — STILL UNRESOLVED
  STATE: candidate-classified

[MEI-06 carry-forward] ANTI-PASSIVE-WAIT bullet 4 over-packs ~5-7 sub-rules — STILL UNRESOLVED
  STATE: candidate-classified

[MEI-05 carry-forward + AMPLIFIED] Consumer-bullet citation asymmetry now affects 3 clauses (INVARIANT + ANTI-PASSIVE-WAIT + implicit BACKGROUND-DECISION-SUPPORT) — UNRESOLVED + AMPLIFIED
  STATUS-vs-r3: amplified. r5 line 41 says "consumer triggers cite 'per canonical INVARIANT' which now includes background authorization" — this PUSHES the BACKGROUND-DECISION-SUPPORT semantics into consumer surfaces via inheritance, increasing the three-hop chain depth.
  STATE: candidate-classified (correlated with MEI-01)

[MEI-03 carry-forward] 5-axis variance test could use canonical sub-anchor — NON-BLOCKING
  STATE: candidate-classified (non-blocking)

[MEI-07 NEW r5] BACKGROUND-DECISION-SUPPORT bullet 6 over-packs ~6-7 sub-rules in one ~180-word bullet
  ANCHOR: draft-r5.md Item 1 NEW-TEXT bullet 6
  EVIDENCE: Bullet 6 packs:
    (a) trigger condition ("team-lead needs any consequential decision (choice situation per above OR other consequential decision requiring evidence/critique)")
    (b) authorization for Skill(team-meeting) parallel critique-request dispatch
    (c) authorization for Skill(codex-independent-review) Pattern A team-lead variant via Bash background invocation
    (d) background usage purpose ("preserves orchestration continuity, avoids serial blocking, reduces context pressure")
    (e) background results return mechanism via Communication Plane
    (f) integration per INVARIANT + ANTI-PASSIVE-WAIT
    (g) non-exemption clause: "background usage does NOT exempt team-lead from INVARIANT or ANTI-PASSIVE-WAIT requirements"
  6-7 distinct executable rules in one bullet. Per CLAUDE.md §5 no-compression rule, independent meanings should not bundle.
  PROPOSED-REVISION: Split bullet 6 into 3 atomic bullets:
    "- BACKGROUND-DECISION-SUPPORT: when team-lead needs a consequential decision (choice situation per above OR other consequential decision requiring evidence/critique), team-lead may invoke `Skill(team-meeting)` parallel critique-request dispatch (per Section 3-4 parallel-critic clause) AND/OR `Skill(codex-independent-review)` Pattern A team-lead variant (per `concurrent-patterns.md` `### Pattern A — Team-Lead Variant`) in the BACKGROUND while continuing other parallel orchestration work."
    "- Background channel transport semantics differ: team-meeting critique-response transports via Communication Plane as decision evidence; Pattern A codex output is lead-internal aid only per `concurrent-patterns.md` `### Team-Lead Variant — Additional Safeguards` (informs own framing, not transported, not synthesis-evidence, not substitute for Skill(review-verification) packet); for transportable codex evidence team-lead uses Pattern C foreground-blocking via `mcp__codex__codex`."
    "- Background usage does NOT exempt team-lead from INVARIANT (Item 1 bullet 3), ANTI-PASSIVE-WAIT (Item 1 bullet 4), Pattern A Authority Non-Substitution (concurrent-patterns.md:33-35), Pattern A Context Limit (concurrent-patterns.md:54-57), or Pattern A RESOURCE-CLEANUP (concurrent-patterns.md:69-73) requirements."
  Result: 6-7 sub-rules → 3 atomic rules; each per-rule disproof-testable; also resolves NR-12/NR-13/NR-14/NR-15 below.
  STATE: candidate-classified

================================================================================
NEGATIVE-RISK-LENS FINDINGS (r5)
================================================================================

[NR-01/NR-06 carry-forward] Categorization-class semantic mismatch — STILL UNRESOLVED
  STATE: candidate-classified

[NR-02 carry-forward] review-verification Step 13/14 + nested meeting carve-out — STILL UNRESOLVED
  STATE: candidate-classified

[NR-03 carry-forward + amplified by INVARIANT] work-planning iteration loop — STILL UNRESOLVED
  STATE: candidate-classified

[NR-05 carry-forward] Detection-timing per consumer bullet — STILL UNRESOLVED
  STATE: candidate-classified

[NR-07 carry-forward] Meta-recursive INVARIANT scope clarification — STILL UNRESOLVED
  STATE: candidate-classified

[NR-08 carry-forward] ANTI-PASSIVE-WAIT timing boundary 3-6 vs 3-7 — STILL UNRESOLVED
  STATE: candidate-classified

[NR-09 carry-forward] ANTI-PASSIVE-WAIT vs Section 3-7 operator-accept conflict — STILL UNRESOLVED
  STATE: candidate-classified

[NR-10 carry-forward] ANTI-PASSIVE-WAIT anchor citation weakness — STILL UNRESOLVED
  STATE: candidate-classified

[NR-11 carry-forward] R9 pre-meeting classification responsibility — STILL UNRESOLVED
  STATE: candidate-classified

[NR-04 carry-forward] Lane-fit failure surfaced in fallback wording — NON-BLOCKING
  STATE: candidate-classified (non-blocking)

[NR-12 NEW r5] BACKGROUND-DECISION-SUPPORT bullet 6 doesn't carry Pattern A Authority Non-Substitution rule
  ANCHOR: draft-r5.md Item 1 NEW-TEXT bullet 6 vs concurrent-patterns.md:33-35 `### Authority Non-Substitution (CRITICAL safeguard)`
  EVIDENCE: concurrent-patterns.md:33-35 says: "Pattern A codex result NEVER substitutes for `Skill(review-verification)` packet at `Skill(self-verification)` Step 3 `PASS-2`. Pattern A is information-gathering supplement only; PASS-2 still requires actual `Skill(review-verification)` load + Step 14 packet citation per existing rule. Substituting Pattern A codex result for `review_verification_packet` is fabrication per `Skill(self-verification)` Step 3 anti-fabrication rule + Carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`."
  Bullet 6 says "background usage does NOT exempt team-lead from INVARIANT or ANTI-PASSIVE-WAIT" but does NOT explicitly carry the Authority Non-Substitution rule forward. A future reader using BACKGROUND-DECISION-SUPPORT may interpret "decision-support" as PASS-2 evidence substitute, which is fabrication per the cited canonical owner.
  PROPOSED-REVISION: Bullet 6 explicit non-substitution clause (see MEI-07 PROPOSED-REVISION bullet 3 above which covers this).
  STATE: candidate-classified (CRITICAL — anti-fabrication safeguard)

[NR-13 NEW r5] BACKGROUND-DECISION-SUPPORT bullet 6 doesn't carry Pattern A Context Limit (security boundary)
  ANCHOR: draft-r5.md Item 1 NEW-TEXT bullet 6 vs concurrent-patterns.md:54-57 `### Context Limit (Security Boundary)`
  EVIDENCE: concurrent-patterns.md:54-57 says Pattern A invocation MUST limit codex context to frozen WORK-SURFACE; files containing secrets/credentials/auth tokens/private keys/security-sensitive material MAY NOT be passed; out-of-scope files MAY NOT be passed; context limit violation invalidates the invocation.
  Bullet 6 doesn't carry this security boundary. A team-lead using BACKGROUND-DECISION-SUPPORT for "any consequential decision" may pass broad context (e.g., entire .claude/ governance corpus) to background codex without honoring the WORK-SURFACE limit.
  Defeater test: is the security boundary self-enforcing via concurrent-patterns.md alone? Per situation-scoped skill activation (.claude/CLAUDE.md line 55), team-lead must consume concurrent-patterns.md when invoking Pattern A — so the security rule applies via the canonical owner. But bullet 6 surfaces the authorization without surfacing the constraint; the asymmetric wording risks comprehension-as-execution-force defect.
  PROPOSED-REVISION: Bullet 6 explicit context-limit pointer (see MEI-07 PROPOSED-REVISION bullet 3 above which covers this).
  STATE: candidate-classified

[NR-14 NEW r5] BACKGROUND-DECISION-SUPPORT bullet 6 doesn't carry Pattern A RESOURCE-CLEANUP requirement
  ANCHOR: draft-r5.md Item 1 NEW-TEXT bullet 6 vs concurrent-patterns.md:69-73 `### Lifecycle + RESOURCE-CLEANUP`
  EVIDENCE: concurrent-patterns.md:69-73 says Pattern A `codex exec` with run_in_background:true creates long-running background process + may produce output files; the invoker MUST terminate the background process + clean up output files before completion per `.claude/skills/task-execution/references/completion-handoff.md` `## Common Completion Result Spine` RESOURCE-CLEANUP enumeration. Missing cleanup is a RESOURCE-CLEANUP defect blocking completion-grade transport.
  Bullet 6 doesn't carry this cleanup discipline. A team-lead using BACKGROUND-DECISION-SUPPORT may leave codex background processes orphaned at session end.
  PROPOSED-REVISION: Bullet 6 explicit RESOURCE-CLEANUP pointer (see MEI-07 PROPOSED-REVISION bullet 3 above which covers this).
  STATE: candidate-classified

[NR-15 NEW r5] R11 (background concurrent execution coordination) doesn't explicitly address Pattern A non-transport boundary
  ANCHOR: draft-r5.md R11 (lines 52-55) — "Mitigation: existing `.claude/skills/work-planning/references/parallel-fit.md` cap rules apply; team-meeting critics count toward cap; codex Pattern A bash background does NOT count toward team-agent cap"
  EVIDENCE: R11 correctly notes codex Pattern A bash background does NOT count toward team-agent cap (verified per concurrent-patterns.md line 102 "Bash(codex exec, run_in_background=true) (Pattern A, lane or team-lead variant) = background process invocation"). However R11 does NOT address that codex output is non-transportable per Authority + Transport Boundary, while team-meeting critique-response IS transportable. The coordination mitigation focuses on cap accounting but skips transport boundary which is the more substantive constraint.
  Defeater test: does R11 incorrectly imply codex output integrates as decision evidence the same way critique-response does? Yes — R11 says "Sequencing handled by Communication Plane: critique-response + codex output arrive at different times; team-lead integrates each as it arrives per ANTI-PASSIVE-WAIT (no wait)." But codex Pattern A output does NOT arrive via Communication Plane; it's polled via BashOutput and stays lead-internal.
  PROPOSED-REVISION: R11 mitigation should add: "codex Pattern A team-lead variant output does NOT arrive via Communication Plane; it is polled via BashOutput and remains lead-internal aid per concurrent-patterns.md Team-Lead Variant Additional Safeguards. team-meeting critique-response IS Communication Plane transport. Team-lead integrates critique-response as transportable decision evidence; codex Pattern A output informs own framing only."
  STATE: candidate-classified

================================================================================
REMOVAL-FIRST-LENS FINDINGS (r5)
================================================================================

[RF-01 carry-forward] Consumer bullets append-only restatement — UNRESOLVED + AMPLIFIED
  STATE: candidate-classified (correlated with MEI-01)

[RF-02 carry-forward] line 91-93 retain-with-precedence-statement — UNRESOLVED (correlated with GC-01)
  STATE: candidate-classified

[RF-03 carry-forward + PARTIALLY ADDRESSED] Patch loop count became 5 in r4 BUT not via GC-02 Section 3-1 Activation patch
  STATUS-vs-r3: numerically partially addressed (4-patch → 5-patch) but the 5th patch is cumulative-input (Item 5 in r4/r5), NOT the GC-02-specific Section 3-1 Activation update.
  EVIDENCE: r5 NEXT ACTION line 61 names "5-patch loop (work-execution-core-law canonical 6-bullet + 3 consumer triggers from r3 + Skill(team-meeting) 3-location patch from r4)". The Skill(team-meeting) 3-location patch addresses Section 3-3 + 3-4 + 3-5 (cumulative-input). Section 3-1 (Activation) is NOT included.
  Per GC-02, the canonical Item 1 bullet 2 mandates Skill(team-meeting) consumption on choice situations; Skill(team-meeting) Section 3-1 must recognize the trigger. The current 5-patch loop misses Section 3-1 → effectively the patch loop should be 6 patches (canonical + 3 consumer triggers + Skill(team-meeting) 3-3+3-4+3-5 + Skill(team-meeting) 3-1) OR Item 5 expanded to 4-location patch (Section 3-1 + 3-3 + 3-4 + 3-5) on same file.
  PROPOSED-REVISION (updated): Item 5 becomes 4-location patch including Section 3-1 Activation; NEXT ACTION patch loop count clarifies (5 patches with Item 5 covering 4 locations on one file, OR 6 patches if Section 3-1 is separated).
  STATE: candidate-classified

================================================================================
MEETING-AUDIT-CRITERIA RE-EVALUATION (r5)
================================================================================

Drafter's r5 self-check marks all criteria ✓. Reviewer-shard-b re-evaluation:
- agenda fit: ✓ (r5 addresses all 9 operator-directive parts; OPERATOR-DIRECTIVE COMPLIANCE CHECK demonstrated)
- simplicity: ⚠ — consumer bullets MEI-01 + INVARIANT bullet MEI-04 + ANTI-PASSIVE-WAIT bullet MEI-06 + BACKGROUND-DECISION-SUPPORT bullet MEI-07 all reducible
- correctness: ⚠ — CRITICAL: NR-12/NR-13/NR-14/NR-15 + GC-04 surface BACKGROUND-DECISION-SUPPORT semantic mismatch with cited canonical owner; this is governance-contradiction-risk per current wording
- feasibility: ⚠ — NEXT ACTION 5-patch loop misses Section 3-1 Activation per GC-02/RF-03
- bottleneck control: ✓ (BACKGROUND-DECISION-SUPPORT does explicitly address bottleneck reduction, modulo the transport-boundary issues)
- cumulative input integration: ✓ (OPERATOR-DIRECTIVE COMPLIANCE CHECK table traces all 9 inputs; positive structural pattern)
- 8 operator-emphasized keywords:
  - `removal-first` ⚠ — consumer bullets still append-only (RF-01/MEI-01)
  - `consumed-surface` ⚠ — BACKGROUND-DECISION-SUPPORT cites canonical owner (concurrent-patterns.md) but misrepresents the consumed surface's transport rules per GC-04
  - `no-compression` ⚠ — bullets 3, 4, 6 over-pack (MEI-04, MEI-06, MEI-07)
  - `upper-lower execution-drive` ⚠ — ANTI-PASSIVE-WAIT anchor weak (NR-10)
  - `executable-imperative` ✓
  - `minimum-executable-information` ⚠ — per MEI-01/MEI-04/MEI-06/MEI-07 reducible
  - `dimensional-independence` ✓
  - `comprehension-as-execution-force` ⚠ — GC-04 transport-boundary mis-representation directly causes future-reader execution-action defect; multiple carry-forward findings also reduce comprehension force

================================================================================
CONSENT STATE (r5)
================================================================================

reviewer-shard-b CONSENT-STATE: not-consent-ready

R5-BACKGROUND-DECISION-SUPPORT-CLAUSE SPECIFIC ASSESSMENT (per OPINION-ROUND REQUEST line 100 of draft-r5):
- "citation chain (team-meeting Section 3-4 parallel + concurrent-patterns Pattern A Team-Lead Variant) make background usage immediately invocable?" — PARTIALLY. Section 3-4 parallel-critic clause confirmed (verified prior turn — Skill(team-meeting) Section 3-4 lines 81-84 mentions parallel critic execution with cap rules). concurrent-patterns.md Pattern A Team-Lead Variant confirmed (lines 37-47). HOWEVER: bullet 6 wording misrepresents Pattern A transport rules per GC-04 + NR-12/NR-13/NR-14.
- "does R11 cover the realistic overlap edge cases?" — PARTIALLY. R11 addresses cap accounting correctly but skips transport-boundary semantic difference per NR-15.
- "is 'does NOT exempt INVARIANT/ANTI-PASSIVE-WAIT' enforceable when parallel background channels are in flight?" — YES that specific clause is enforceable; but the SET of non-exemptions should also include Pattern A Authority Non-Substitution + Context Limit + RESOURCE-CLEANUP per NR-12/NR-13/NR-14.

R4-CUMULATIVE-INPUT-INTEGRATION ASSESSMENT (carrying forward r4 unaddressed in prior critique since r4 was superseded immediately by r5):
- Item 5 3-location patch (Section 3-3 + 3-4 + 3-5) is GOOD structural addition. The OPERATOR-DIRECTIVE COMPLIANCE CHECK table format demonstrated in r3/r4/r5 is positive.
- R10 enumeration-burden mitigation reasonable.
- HOWEVER: Item 5 misses Section 3-1 Activation per GC-02 (carrying forward from r1/r2/r3); Item 5 should be 4-location patch.

Material objections (require resolution in draft-r6 before consent):
CARRY-FORWARD FROM R1/R2/R3 (UNRESOLVED in r4/r5):
- GC-01, GC-02, GC-03 (canonical-text precedence + Section 3-1 Activation + line 98 evidence-default)
- MEI-01/RF-01 (consumer bullets pointer-only, AMPLIFIED), MEI-04 (INVARIANT split), MEI-05 (consumer-bullet asymmetry, AMPLIFIED), MEI-06 (ANTI-PASSIVE-WAIT split)
- NR-01/NR-06, NR-02, NR-03, NR-05, NR-07, NR-08, NR-09, NR-10, NR-11
- RF-03 (5-patch should be 5-with-Item-5-expanded OR 6-patch including Section 3-1)

NEW R5-SPECIFIC (CRITICAL):
- GC-04 (BACKGROUND-DECISION-SUPPORT transport-boundary representation contradicts cited canonical concurrent-patterns.md)
- MEI-07 (BACKGROUND-DECISION-SUPPORT bullet 6 over-packs 6-7 sub-rules)
- NR-12 (Pattern A Authority Non-Substitution rule missing from bullet 6)
- NR-13 (Pattern A Context Limit security boundary missing from bullet 6)
- NR-14 (Pattern A RESOURCE-CLEANUP requirement missing from bullet 6)
- NR-15 (R11 doesn't address Pattern A non-transport boundary)

Non-blocking suggestions:
- MEI-03 (5-axis variance canonical sub-anchor — optional)
- NR-04 (lane-fit failure surfaced in fallback wording — optional)

Resolved by r4 (carried into r5):
- None of the r1/r2/r3 carry-forward findings were resolved by r4 or r5.
- r4 POSITIVE addition: Item 5 cumulative-input (operator-driven directive 8). r5 POSITIVE addition: OPERATOR-DIRECTIVE COMPLIANCE CHECK table (per Item 5 cumulative-input rule, demonstrated).
- r5 NEEDS: address GC-04 + NR-12/13/14/15 BEFORE Item 1 bullet 6 can be patched, since the bullet currently misrepresents the cited canonical owner's transport rules.

================================================================================
EVIDENCE-BASIS (file:line anchors inspected this turn)
================================================================================
- claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r4.md:1-125 (full Read this turn — to confirm r4 additions Item 5 + OPERATOR-DIRECTIVE COMPLIANCE CHECK; r4 is intermediate context per fold rule)
- claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r5.md:1-107 (full Read this turn — primary target)
- claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r3-reviewer-shard-b.md (carry-forward findings basis; r3 carrier authored prior turn this session, no r4 critique was authored due to back-to-back r4→r5 redirect)
- .claude/skills/codex-independent-review/references/concurrent-patterns.md:1-119 (full Read this turn) — NEW canonical surface read for GC-04/NR-12/NR-13/NR-14/NR-15 evidence; confirmed: lines 27-32 + 37-43 Pattern A Team-Lead Variant Authority + Transport Boundary (non-transportable lead-internal aid only); lines 33-35 Authority Non-Substitution; lines 45-47 NO team-lead Pattern C parallel-execution path; lines 54-57 Context Limit security boundary; lines 69-73 RESOURCE-CLEANUP; line 102 codex Pattern A does NOT count toward team-agent cap
- .claude/reference/work-execution-core-law.md (Read prior turn this session; same-session reuse) — re-cited line 88, 92, 94, 98, 158, 163
- .claude/skills/team-meeting/SKILL.md (Read prior turn this session; same-session reuse) — re-cited Section 3-1, 3-3, 3-4, 3-5, 3-6, 3-7
- Cross-shard pointer for NR-02: .claude/skills/review-verification/SKILL.md Steps 4, 13, 14 — not directly inspected
- Cross-shard pointer for NR-06: .claude/skills/agent-validator/* + agent-tester/* — not directly inspected
- Cross-shard pointer for NR-12 fabrication-rule citation: .claude/skills/self-verification/SKILL.md Step 3 (per concurrent-patterns.md:35 citation) + .claude/reference/work-skill-reference-binding-law.md `## Skill Rules` (per concurrent-patterns.md:35 citation)

================================================================================
LENS-COVERAGE CONFIRMATION (r5)
================================================================================
- governance-continuity-lens: applied (GC-01, GC-02, GC-03, GC-04) — 4 candidates (3 carry-forward unresolved + 1 NEW r5-specific CRITICAL)
- minimum-executable-information-lens: applied (MEI-01, MEI-03, MEI-04, MEI-05, MEI-06, MEI-07) — 6 candidates (4 carry-forward unresolved + 1 non-blocking carry-forward + 1 NEW r5-specific)
- negative-risk-lens: applied (NR-01, NR-02, NR-03, NR-04, NR-05, NR-06, NR-07, NR-08, NR-09, NR-10, NR-11, NR-12, NR-13, NR-14, NR-15) — 15 candidates (10 carry-forward material + 1 non-blocking carry-forward + 4 NEW r5-specific CRITICAL)
- removal-first-lens: applied (RF-01, RF-02, RF-03) — 3 candidates (correlated; RF-03 numerically partially addressed by r4 cumulative-input patch but substantively still requires Section 3-1 Activation)
Total: 28 candidates (19 material objections + 3 non-blocking + 6 correlated)

OVERALL-COUNTS (r5):
- carry-forward-unresolved-material: 14
- new-material-r5-specific: 5 (GC-04, MEI-07, NR-12, NR-13, NR-14, NR-15 — counted as 5 if NR-15 considered amplification of R11 rather than independent)
- non-blocking-suggestion: 3
- correlated-with-other-finding: 6
- resolved-by-r4: 0 (Item 5 cumulative-input is positive addition addressing operator directive 8 but doesn't resolve any prior critique objection)
- resolved-by-r5: 0
- consent-state: not-consent-ready
- consent-ready-condition: draft-r6 incorporates GC-01/02/03/04 + MEI-01/04/06/07 + NR-01/02/03/05/06/07/08/09/10/11/12/13/14/15 + RF-03 OR provides evidence-backed persuasive rationale rejecting each material objection per Skill(team-meeting) `## 3-4. Opinion Round` "drafter accepts a useful opinion regardless of its shape ... drafter keeps a brief basis when rejecting a material objection or improvement"

CRITICAL ESCALATION: GC-04 + NR-12/13/14/15 collectively represent a governance-contradiction-risk for Item 1 bullet 6 — the current wording misrepresents the cited canonical owner (concurrent-patterns.md) transport rules. Patching this bullet as-is would install a rule that contradicts its own cited basis. This is the highest-priority finding for draft-r6 attention.

POSITIVE OBSERVATIONS (r4/r5):
- r4 Item 5 cumulative-input patch is a sound structural response to operator directive 8 (drafter ignoring prior input across revisions). The 3-location patch (Section 3-3 + 3-4 + 3-5) covers the right consumption points (drafter discipline + revision discipline + audit criterion).
- OPERATOR-DIRECTIVE COMPLIANCE CHECK table format demonstrated in r3/r4/r5 is positive structural addition demonstrating cumulative-input rule.
- BACKGROUND-DECISION-SUPPORT clause is well-motivated by operator directive 9; the citation to existing canonical surfaces (concurrent-patterns.md Pattern A Team-Lead Variant) is appropriate routing. The remaining issue is faithful representation of those cited canonical surfaces' rules, not the authorization itself.
- Fallback chain explicit invalidation of post-meeting direction-confirmation pause (Item 1 bullet 5) closes a real loophole.
- INVARIANT clause is non-negotiable language that strongly enforces upper-philosophy compliance.
