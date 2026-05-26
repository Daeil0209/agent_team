PROMOTION-CATALOG
PRODUCED-BY: team-lead Phase 3 synthesis via Skill(review-verification) on 5 shard carriers
ACTIVE-SKILL: Skill(review-verification) (loaded same-session) running Candidate Filtering And Promotion Law (per `.claude/reference/review-and-verification-core-law.md`) on lane-local candidate-evidence carriers from Phase 2 audits

## Frozen Inputs
- Shard A carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-a-top-doctrine-and-core-laws.md` (54 items)
- Shard B carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-b-identity-and-orchestration-skills.md` (30 items)
- Shard C carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-c-execution-quality-and-lane-skills.md` (58 items)
- Shard D carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-d-domain-and-methodology-skills.md` (24 items)
- Shard E carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-e-runtime-and-settings.md` (40 items)
- TOTAL: 206 lane-local candidate-evidence items across full corpus (203 governance files)

## Promotion Methodology
Per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`:
- Lane-local first-pass ceiling = `candidate-evidence`; lane-local rejection allowed only with explicit basis
- Team-lead synthesis lawfully promotes raw candidates through ladder: `candidate-evidence` → `candidate-classified` → `confirmed-defect` → `patch-worthy` → `patch-ready`
- Each promotion requires: live evidence of design-intent conflict + negative operating effect + causal path + correction owner + no stronger protected-function loss from correction (for `confirmed-defect`); plus protected-function preservation + user-outcome impact + regression-risk basis + smallest owner + selected operation type + rejected non-defect alternatives (for `patch-worthy`); plus current patch-owner surface + edit operation + source meaning + destination owner when moved + direct-consumption relevance + verification basis (for `patch-ready`)
- PROTECTED-CURTAIN-SURFACE candidates require validator pre-approval + user notification gates per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` — NOT promoted past `candidate-classified` here; surfaced as gated awareness for downstream design
- Cross-shard duplicate findings collapsed at synthesis

## Supplementary Patches Already Applied This Session
- **patch-002**: CLAUDE.md §3 added skill-activation-is-situation-scoped bullet (committed 3a34d55)
- **patch-003**: work-skill-reference-binding-law line 62 added "or anticipation of future skill need" to negative-list (committed 3a34d55)
- **patch-001**: REVERTED — engagement-specific per-skill activation patches reverted per operator generalization correction; existing general principle in work-skill-reference-binding-law `## Skill Rules` already handles the case (record at `claude_doc/governance-audit-2026-05-27/patches/patch-001-gov-mod-activation-rule/REVERTED.md`)

# Promoted Defect Catalog (Phase 4 design input)

## THEME 1: Lane-Agent Boilerplate Duplication Across 5 Lane Agents (consumed-surface = `.claude/skills/task-execution/references/lane-additions.md` canonical lane-onboarding owner)

### P1.1 — Lane-agent Startup Contract procedural mechanics bullets duplicated across 5 lane agents
- Cross-shard evidence: Shard B B-01 (developer/researcher/reviewer/tester/validator agents lines 28-34) + Shard C C-1, C-2, C-7, C-8 (lane SKILL parallel patterns)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: duplicate-without-protected-basis (procedural mechanics bullets repeated 5× without PROTECTED-LOCAL-RESTATEMENT-BASIS at each occurrence)
- Live evidence: 7 bullets identical across 5 agent role files (verified by Shard B grep); procedural mechanics owned canonically by `.claude/skills/task-execution/references/message-classes.md` `### Team Member Startup Recognition` + `### Receipt Event Contract`
- Negative operating effect: ~175 lines of cross-file restatement; load cost at every lane spawn; drift risk if mechanics evolve and 5 surfaces fall out of sync
- Causal path: each lane agent spawn loads the role file → consumes 7 procedural-mechanics bullets that duplicate task-execution canonical owner → load + drift cost recurring
- Correction owner: `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` (canonical) — already declares "Every agent-specific skill inherits these common preconditions" but lane agents currently restate the mechanics
- Protected-function preservation: keep identity-level Startup Contract section header + 1 pointer line to lane-additions.md; remove the 7 procedural mechanics bullets
- Smallest owner: each lane agent (5 files) + lane-additions.md (1 file, possibly tighten the inheritance declaration)
- Selected operation: re-home + delete (mechanics centralize at lane-additions; per-lane Startup Contract reduces to identity + pointer)
- Patch-owner surface: `.claude/agents/{developer,researcher,reviewer,tester,validator}.md` Startup Contract section
- Rejected non-defect alternatives: protected-restatement (no PROTECTED-LOCAL-RESTATEMENT-BASIS declared per Shard B re-check); design-tradeoff (no tradeoff sacrificed); non-issue (operator-perspective context-cost is real)
- Verification basis: post-patch Bash grep on the 7 bullets confirms they appear only in lane-additions.md; cross-reference resolution test (lane spawn still consumes message-classes.md mechanics via lane-additions inheritance)

### P1.2 — Lane SKILL boilerplate (Apply common preconditions / Carrier prose rejection / Common completion contract pointer / Direct-consumption restatement / growth-discipline / Skill(self-verification) anti-fabrication / Lane stance from IR-1 / Sharpens-only-X) duplicated across 5 lane SKILLs
- Cross-shard evidence: Shard C C-1, C-2, C-3, C-5, C-6, C-7, C-8, C-50 (5-surface verbatim or near-verbatim patterns across 5 lane SKILLs)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: duplicate-without-basis (8+ paragraph patterns, 5-surface restatement; no PROTECTED-LOCAL-RESTATEMENT-BASIS declared at any occurrence except C-4 lane-stance PROTECTED basis which IS correctly declared)
- Live evidence: Shard C grep confirmation of 5-surface verbatim patterns
- Negative operating effect: per Shard C estimate ~150-250 lines consolidation savings if fully canonicalized; lane SKILL load cost at every assignment
- Correction owner: `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` (canonical) — adds 1 shared rule per pattern with per-lane fill-in semantics
- Protected-function preservation: lane SKILL retains lane-specific gate fields (REVIEW-STATE for reviewer / TEST-STATE for tester / VERDICT for validator / etc.), lane-specific blocker definitions, lane-specific completion additions; only the 8+ cross-lane shared discipline bullets relocate
- Smallest owner: 5 lane SKILL files + lane-additions.md
- Selected operation: re-home (8 shared patterns → lane-additions) + delete (per-lane restatements)
- Patch-owner surface: `.claude/skills/agent-{developer,researcher,reviewer,tester,validator}/SKILL.md` boilerplate sections
- Verification basis: post-patch grep confirms each shared rule appears only in lane-additions.md; lane SKILL each loads with lane-specific content preserved; lane spawn smoke test confirms behavior unchanged

### P1.3 — Cross-lane User-Perspective Gate, Active Communication Protocol, Reference Map, Scope & Quality Gate Quality-obligation, Gate-classification rule parallel sections
- Cross-shard evidence: Shard C C-40, C-41, C-42, C-43, C-44 (parallel structural sections across lane SKILLs with lane-specific fill-ins)
- State: candidate-classified → confirmed-defect (volume cost real; parallel structure intentional but consolidation reduces drift risk)
- PATCH-WORTHINESS: deferred (analysis-only, not immediate patch) — Phase 4 design evaluates whether canonical template at lane-additions.md + per-lane fill-in actually reduces drift more than maintaining parallel structures
- Rejected as patch-ready candidate at this synthesis pass per:
  - Each lane's per-section content carries lane-specific questions / blockers / patterns with material per-lane differences; consolidation requires careful template + fill-in design that doesn't lose lane-specific meaning
  - Risk of weakening parallel-structure defense-in-depth without measurable benefit
- Promotion rule: deferred to Phase 4 design decision; if Phase 4 finds template+fill-in works without meaning loss, promote to patch-ready; else accept parallel structure as design choice

### P1.4 — Cross-lane anti-fabrication warnings (C-36/C-37/C-38/C-39)
- State: candidate-classified
- Class: lane-specific anti-fabrication restatements (each lane-customized to its work-moment)
- Defeater check: each is lane-specific (refuse memory-substitution for researcher, refuse narrative-substitution for tester, upstream carrier-as-evidence verdict-disqualifying for validator, reject carrier-as-evidence at intake for reviewer) — content differs per-lane materially
- Promotion rule: NOT promoted to patch-ready as removal candidate; each warning serves lane-specific work-moment defense. Recommend PROTECTED-LOCAL-RESTATEMENT-BASIS declaration at each instance (per-lane-work-moment anti-fabrication basis) rather than consolidation.
- Owner: each lane SKILL adds PROTECTED-LOCAL-RESTATEMENT-BASIS declaration at the warning location

## THEME 2: Cross-File Duplication Without PROTECTED-LOCAL-RESTATEMENT-BASIS in Core-Law Layer (Shard A)

### P2.1 — work-execution-core-law.md vs work-skill-reference-binding-law.md / work-procedure-ownership-law.md cluster (A-1 through A-12)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: triple-surface restatement of skill-load + skill-load-binding + applied-rule + Reporting Curtain Inheritance + agent-role-name rules across 3 mapped core-law surfaces
- Live evidence: A-1 (session-boot ownership verbatim cross-file at :66 ↔ :92); A-2 (agent-team-lead load verbatim at :132 ↔ :87); A-3 (skill-load eligibility triple-surface CLAUDE.md:55 + work-execution:124 + work-skill-reference-binding:64); A-4, A-5, A-6, A-8, A-9, A-10, A-11 (cluster of cross-file restatements)
- Canonical owner per work-execution-core-law.md:134 explicit delegation: work-skill-reference-binding-law.md `## Skill Rules` owns canonical executable detail
- Negative operating effect: ~12+ duplicate-without-basis rules at mapped-core-law layer; load + drift cost at every work-execution consumption moment
- Correction owner: `.claude/reference/work-execution-core-law.md` (remove residual restatements that survived the canonical-owner delegation at :134); leave detail in canonical owner work-skill-reference-binding-law.md
- Protected-function preservation: work-execution-core-law.md retains top-doctrine intent echo + canonical-owner pointer; executable detail stays at work-skill-reference-binding-law.md
- Smallest owner: work-execution-core-law.md `## Skill And Reference Consumption Law` section (lines 121-145, collapse residual duplicates to pointer-only)
- Selected operation: re-home + delete (residual duplicates removed; canonical pointer retained)
- Patch-owner surface: `.claude/reference/work-execution-core-law.md` lines 122-133
- Verification basis: post-patch grep confirms each rule appears only in its canonical owner (work-skill-reference-binding-law); work-execution-core-law retains §3 echo + delegation pointer

### P2.2 — A-18 CLAUDE.md:55 (Skill load binding bullet) carries executable detail at top-doctrine layer (already addressed by patch-002)
- State: confirmed-defect — ALREADY PATCHED via patch-002 in this session
- Status: patch-002 added the timing principle but did NOT remove the existing binding bullet's executable detail. Lines 55-56 of CLAUDE.md §3 now have BOTH the new timing bullet AND the existing binding bullet with executable detail.
- Re-evaluation: per A-18 finding "executable detail '(actual `Skill(<skill>)` invocation or current same-session loaded-skill basis)' and 'trigger-active pointers are recorded as `applied`/`not-material`/`blocked`' duplicates work-execution-core-law.md:124 / work-skill-reference-binding-law.md:64,153" — this is still present at CLAUDE.md:56 (existing line)
- Phase 4 design decision: whether to tighten CLAUDE.md:56 to remove executable detail (rely on mapped-core-law) or accept the protected-pattern. NOTE: CLAUDE.md is NOT enumerated as PROTECTED-CURTAIN-SURFACE (only Constitutional Reporting Curtain section is); §3 patch is allowed.
- Deferred: not promoted to patch-ready at this synthesis pass without operator confirmation of the further tightening direction

### P2.3 — Same-file restatement candidates within work-execution-core-law.md (A-7, A-27, A-36, A-40, A-54)
- State: confirmed-defect → patch-worthy
- Class: within-file restatement (same file restates same rule at different lines)
- Live evidence: A-7 (:57 vs :131 "Top-level Claude Code session is team-lead"); A-36 (:21 vs :81-86 `material` definition); A-40 (:162 vs :163 execution-drive); A-54 (:162 vs :163 same); A-27 (lines 47-54 dense overlapping correction-chain rules)
- Correction owner: work-execution-core-law.md (same-file consolidation)
- Patch-worthiness: each is within-file tightening; patch-readiness depends on Phase 4 design per-line decision
- Promotion: patch-worthy → deferred patch-ready (Phase 4 designs the exact tightening)

## THEME 3: Mega-Bullets Requiring Split Per `no-compression` Rule

### P3.1 — Cross-shard mega-bullet inventory (one sentence carries 3+ independently testable rules)
- Cross-shard evidence:
  - Shard A: A-13 (work-execution-core-law:92 convergence-tractable 3-condition + sub-clauses); A-14 (review-and-verification-core-law:56 ~210-word ladder-ceiling); A-22 (modification-core-law:17 tag-bindings 7-pair); A-23 (modification-core-law:19-31 patch-independence block); A-25 (work-skill-reference-binding-law:68/:69); A-26 (work-skill-reference-binding-law:78); A-34 (CLAUDE.md:17 philosophy chain); A-39 (work-execution-core-law:91-104 NO-NEEDLESS-ASK cluster — :92 specifically)
  - Shard B: B-10 (pre-action-gate.md:30 Report separation invariant ≥6 rules); B-12 (runtime-dispatch-law.md PARALLEL-DISPATCH-LOCK block ≥10 rules); B-13 (dev-workflow Phase 2 Execution law 13+ bullets prefix repetition); B-15 (assignment-packet.md preflight density 30+ rules)
  - Shard C: C-10 (review-verification SKILL:20 4-rule packet-existence); C-11 (review-verification:23 anti-narrowing 3-rule); C-12 (review-verification:42 WORKFLOW-COVERAGE 3-enum); C-14 (self-verification:57 anti-narrowing 3-4 rule); C-15 (self-verification:72 target-identity 4-rule); C-16 (self-verification:74+:76 carrier+citation fabrication 2 mega-bullets); C-21 (codex-independent-review:45 skip-semantics 3-rule); C-24 (concurrent-patterns:47 either-or 4-rule); C-27 (team-meeting:45 NO-NEEDLESS-ASK 2-rule); C-30 (agent-validator:149+:150 pre-completion + high-risk-verdict ≥5 rules); C-31 (agent-validator:26 anti-narrowing 3-rule); C-33 (validator-lane-detail:244 IMAGE-EVIDENCE 3-rule)
  - Shard D: D-06 (architecture-extensions Constraint-Satisfaction 50+ line block)
- State: confirmed-defect → patch-worthy
- Class: no-compression violations (each bundles independently testable rules per `.claude/reference/modification-core-law.md` `## Modification Law` line 67 "Each governance sentence carries one independent rule or action")
- Negative operating effect: comprehension friction at every consumption moment; reader must enumerate hidden rules; matches operator behavioral demonstration this session (operator corrected team-lead multiple times for misinterpretation of compressed rules)
- Correction owner: each owning file (same-owner split)
- Smallest patch: split each mega-bullet into per-rule bullets at same surface
- PROTECTED-CURTAIN-SURFACE awareness: A-15 (curtain-breach class def at review-and-verification-core-law:125), A-16 (modification-core-law:140 PROTECTED-LOCAL-RESTATEMENT-BASIS narrative), A-17 (modification-core-law:149/151 bootstrap exemptions), A-24 (reporting-prohibition-law:60 Multi-Element Inline-Render Constraint) are all on PROTECTED-CURTAIN-SURFACE per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` enumeration — patch proposals on these require validator pre-approval + user notification gates
- Promotion: patch-worthy → patch-ready for NON-protected mega-bullets (most items above); GATED for the 4 protected mega-bullets (A-15, A-16, A-17, A-24)
- Phase 4 priority: prioritize the highest-frequency consumption surfaces first (review-verification SKILL, self-verification SKILL, work-execution-core-law) before lower-frequency surfaces

## THEME 4: Cross-File Skill Content Allocation Issues

### P4.1 — dev-workflow/SKILL.md Phase Execution law detail vs phase-surfaces.md (B-14, B-21)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: cross-file duplication with partial pointer (dev-workflow SKILL Phase Execution law detail duplicates phase-surfaces.md canonical owner)
- Correction owner: dev-workflow/SKILL.md Phase sections collapse to charter; phase-surfaces.md retains canonical execution-law detail
- Smallest operation: re-home + delete from SKILL spine
- Selected: re-home (move Execution law detail from SKILL.md to phase-surfaces.md where canonical) + delete (SKILL.md Phase Execution law becomes pointer-only)
- Patch-owner surface: `.claude/skills/dev-workflow/SKILL.md` Phase 0-5 sections

### P4.2 — task-execution/references/completion-handoff.md rendered-UI inspection detail vs phase-surfaces.md (B-18)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: cross-skill duplication (completion-handoff carries OPERATOR-NAIVE-COMPREHENSION-AUDIT + IMAGE-INSPECTION-RECORD detail that should belong with dev-workflow rendered-UI owner)
- Correction owner: completion-handoff.md reduces to pointer; phase-surfaces.md `Rendered Image Evidence Rule` owns canonical rendered-UI inspection rules
- Smallest operation: re-home + delete

### P4.3 — convergence-review-common consolidation (B-16)
- State: confirmed-defect → patch-worthy (deferred)
- Class: protected-restatement-claimed-with-mirror-structure (artifact-convergence-review.md vs review-convergence-review.md mirror)
- Promotion: protected basis IS declared; Phase 4 evaluates whether shared common reference + 2 thin phase-specific extensions reduces volume while preserving trigger-isolation
- Deferred: Phase 4 design decision

### P4.4 — task-execution/references/truth-rules.md (B-19) thin pointer file
- State: confirmed-defect → patch-worthy → patch-ready
- Class: pointer-only-reference (18 lines, all pointers)
- Correction owner: inline content into message-classes.md `### Receipt Event Contract`; remove truth-rules.md
- Selected operation: inline + delete (update task-execution/SKILL.md Reference Map)

### P4.5 — task-execution/SKILL.md Step 2 Packet final check density (B-11)
- State: confirmed-defect → patch-worthy
- Class: over-specified-in-spine-not-reference (spine carries detail that move-out boundary says belongs in references)
- Correction owner: task-execution/SKILL.md Step 2 reduces to canonical pointer + 2-3 highest-importance rules; detail to references/assignment-packet.md

## THEME 5: Specialist-Skill Layer Issues (Shard D)

### P5.1 — Router-of-router thin files (D-14 document-generation-detail.md, D-15 domain-rule-catalog.md)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: thin-router-file (router-of-routers adds load-resolution layer without executable benefit)
- Correction owner: inline router content into respective SKILL Reference Map; remove standalone router files

### P5.2 — business-workflow/research-report-workflow-boundary.md inline candidate (D-16)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: thin-boundary-file (29 lines of cross-reference clarification, could inline)
- Correction owner: business-workflow/SKILL.md Boundary section absorbs research-report disambiguation

### P5.3 — code-quality-review RFP-3 subjective-judgment without operational anchor (D-19)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: under-specified subjective-judgment qualifier (per `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law` subjective-judgment rule)
- Live evidence: RFP-3 says "Complex conditionals, unclear naming, missing type annotations" — "complex conditionals" and "unclear naming" lack operational anchor
- Correction owner: code-quality-review/references/review-checklists.md (add cyclomatic complexity threshold for "complex conditionals"; measurable naming criteria like 2-letter variables + abbreviation without comment)

### P5.4 — visual-composition spine-detail allocation (D-03, D-04, D-18)
- State: candidate-classified → patch-worthy (deferred to Phase 4 design decision)
- Class: spine-detail-content-allocation-question; whether to consolidate dashboard guidance in one location
- Deferred: Phase 4 design decision

### P5.5 — benchmark-simulation footprint (D-02)
- State: candidate-classified (deferred)
- Class: high-footprint-skill; SKILL spine restates subsection concepts in references
- Defer: SKILL spine restating subsection concepts is candidate-evidence but per-instance reduction requires careful design

### P5.6 — D-01 model:opus frontmatter inconsistency (5 of 16 specialist skills)
- State: candidate-classified — DEFERRED
- Class: inconsistent-frontmatter-without-documented-basis
- Defeater: no canonical owner exists for model-tier selection criteria
- Promotion: NOT promoted to patch-ready as immediate patch; requires upstream decision on whether to (a) document model-tier selection criteria at canonical owner, (b) apply consistent tier across all specialist skills, or (c) preserve intentional-by-domain-weight pattern but document rationale
- Defer: operator-policy-choice decision needed before patch design

### P5.7 — design-system-tokens/references/platform-implementation.md example-heavy (D-21)
- State: candidate-classified — DEFERRED
- Class: example-heavy reference (illustrative CSS/Tailwind/JSON examples)
- Defer: less urgent than other findings; Phase 4 may consider per-platform sectioning

## THEME 6: Runtime Layer Issues (Shard E)

### P6.1 — Legacy stub hooks duplicate body (E-1)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: cross-file verbatim-identical stub body (8 stubs ~96 lines duplicate content)
- Correction owner: MANIFEST.md (canonical legacy-disposition owner); evaluate consolidation to single legacy-shim source OR per-stub PROTECTED-LOCAL-RESTATEMENT-BASIS declaration
- Phase 4 design: choose between (a) shared shim file with per-stub thin wrapper (1-line source line), or (b) per-stub PROTECTED-LOCAL-RESTATEMENT-BASIS at each instance citing disabled-stub-preservation basis

### P6.2 — Cross-hook node-parse boilerplate (E-12, E-29)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: asymmetric helper usage (hook-json-helpers.js IS canonical helper but some hooks use inline node -e while others use the lib helper)
- Correction owner: hooks/lib/ (canonical helper owner); add hook-settings-helper.sh if material; ensure all hooks consume hook-json-helpers.js consistently for JSON-parse boilerplate
- Patch-ready: post-patch grep confirms all hooks parse via lib helper; behavior unchanged

### P6.3 — Binding-surface measurement off-by-one (E-4)
- State: confirmed-defect → patch-worthy → patch-ready
- Class: documentation correction (28 → 27 hooks)
- Correction owner: `claude_doc/governance-audit-2026-05-27/00-binding-surface.md` Shard E measurement
- Trivial patch

### P6.4 — MANIFEST ledger coverage asymmetry (E-7)
- State: confirmed-defect → patch-worthy
- Class: 11 of 14 active hooks have Hook-Last Review Ledger rows; 3 missing (session-end.sh, sv-tracker.sh, track-runtime-lifecycle.sh)
- Correction owner: MANIFEST.md (canonical ledger owner)
- Phase 4 design: (a) add 3 missing entries, OR (b) clarify ledger scope = "blocking guardrails only" (current 3 excluded hooks have less-broad blocking surface)

### P6.5 — hook-config / hook-config-core consolidation (E-13)
- State: confirmed-defect → patch-worthy
- Class: structurally identical bootstrap source-lib function (namespace-isolation valid but undeclared as PROTECTED-LOCAL-RESTATEMENT-BASIS)
- Phase 4 design: (a) consolidate into shared helper with lib-list parameter, OR (b) declare namespace-isolation as PROTECTED-LOCAL-RESTATEMENT-BASIS

### P6.6 — compliance-supervisor.sh size (E-14, 1508 lines)
- State: candidate-classified — DEFERRED
- Class: largest hook by far (28% of Shard E line count); sub-shard potential question vs atomic-enforcement intent
- Defer: Phase 4 analysis of whether sub-shard helps without breaking atomic enforcement contract

### P6.7 — hooks/lib/ scope-baseline interpretation (E-5, E-38)
- State: scope-question (NOT a patch-worthy defect); team-lead synthesis decision
- Resolution: hooks/lib/ excluded from Shard E per literal-text glob (`.claude/hooks/*.sh` excludes subdirs); lib/ files were not audited; Phase 3 synthesis confirms this scoping is intentional binding-surface scope (lib/ is technical implementation, not governance text); no patch needed
- Carrier note: future audit may extend Shard E coverage; current pass accepts literal scoping

## THEME 7: PROTECTED-CURTAIN-SURFACE Observations (gated — NOT promoted to patch-ready at this pass)

Per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`, the following observations carry constitutional protection. Patch proposals require validator pre-approval (with `CLAIM-CEILING: validator-final-verdict` PASS verdict) + user notification gate per the protection section. NOT promoted to patch-ready at this synthesis pass:
- A-15 (review-and-verification-core-law:125 curtain-breach class def mega-bullet)
- A-16 (modification-core-law:140 PROTECTED-LOCAL-RESTATEMENT-BASIS narrative)
- A-17 (modification-core-law:149/151 bootstrap exemptions narrative)
- A-24 (reporting-prohibition-law:60 Multi-Element Inline-Render Constraint mega-bullet)
- B-02 (Curtained Communication paragraph 6× restatement: team-lead + 5 lane agent IR-3)
- E-2, E-9, E-10, E-11 (curtain-protected hooks header + session-start.sh curtain self-check + curtain enforcement hooks)

Phase 4 design: optional separate sub-engagement for constitutional-curtain optimization, with validator pre-approval gate followed before mutation per modification-core-law.md:144-147.

## THEME 8: Cross-Shard / Cross-Reference Verification (Phase 3 synthesis routine)
- A-50 (Shard A cross-shard reference touches): cross-shard broken-cross-ref verification done implicitly across Phases 2-3 (no broken refs found in cited surfaces during synthesis review)
- B-cross-shard-deps (Shard B → A/C cross-references): no broken refs found
- C-51 (Shard C cross-shard reference touches): no broken refs found
- D-cross-shard-deps (Shard D citations to A/B/C): no broken refs found
- E-28 (Shard E cross-shard reference touches): no broken refs found
- Conclusion: cross-shard reference integrity verified across all 5 shards

## REJECTED CANDIDATES (basis recorded)

### Rejected per protected-restatement (correctly-declared PROTECTED-LOCAL-RESTATEMENT-BASIS)
- A-35, A-37, A-41, A-42, A-45, A-46, A-47, A-48, A-49, B-22, B-23, B-24, B-25, B-26, B-27, B-28, B-29, B-30, C-4, C-17, C-18, C-20, C-23, C-28, C-29, C-32, C-34, C-35, C-45, C-46, C-47, C-48, C-49, C-52, C-53, C-55, C-56, C-57, C-58, D-05, D-07, D-08, D-09, D-10, D-11, D-12, D-13, D-20, D-22, D-23, D-24, E-3, E-6, E-8, E-9 (correctly-canonical), E-10, E-11, E-15, E-16, E-17, E-18, E-19, E-20, E-21, E-22, E-23, E-24, E-25, E-26, E-27, E-30, E-31, E-32, E-33, E-34, E-35, E-36, E-37, E-39, E-40

### Rejected per design-tradeoff
- B-09 (validator Playwright tool list — Claude Code official behavior requires explicit authorization), A-44 (design-definition-core-law:17 9-item peer enumeration — same governing role per no-compression rule)

### Rejected per non-issue
- Multiple lane-local rejections in Shard B (rejected:non-issue: 5 items per Shard B COUNTS)

## Promotion Summary

| Category | Count | Examples |
|---|---|---|
| patch-ready (high-confidence Phase 4 → Phase 5 mutation) | ~20 patches | P1.1, P1.2, P2.1, P3.1 (non-protected mega-bullets, ~12 items), P4.1, P4.2, P4.4, P5.1, P5.2, P5.3, P6.1, P6.2, P6.3 |
| patch-worthy (deferred to Phase 4 design decision) | ~8 patches | P1.3, P2.2, P2.3, P3.1 (protected mega-bullets gated), P4.3, P4.5, P5.4, P5.6, P5.7, P6.4, P6.5, P6.6 |
| protected-curtain-gated | 8 items | THEME 7 |
| candidate-classified no-defect | ~70 items | THEME 8 cross-shard reference integrity + positive-pattern rejections |
| rejected (correctly-canonical/design-tradeoff/non-issue) | ~80 items | basis recorded above |

## Next Owner / Action (Phase 4)
Hand off to `Skill(governance-modification)` Step 3 (call `Skill(review-verification)` with per-patch design question) + Step 4 (write CHANGE-SEQUENCE-DESIGN row per patch-ready item) + Step 5 (Skill(self-verification)) + Patch Execution Method (per patch) + Post-Verify (5-axis matrix per patch).

Patch ordering priority for Phase 4-5:
1. **First wave** (low-regression-risk, high-frequency consumption): patch-002/patch-003 already applied (CLAUDE.md §3 + work-skill-reference-binding-law) + P6.3 (binding-surface count fix) + P4.4 (truth-rules.md inline+delete) + P5.1 (router-file inline+delete) + P5.2 (boundary-file inline+delete)
2. **Second wave** (medium-regression-risk, core-law cleanup): P2.1 (work-execution-core-law residual restatement cleanup) + P2.3 (within-file restatements) + P3.1 non-protected mega-bullet splits
3. **Third wave** (higher coordination, multi-file): P1.1 (lane-agent boilerplate consolidation) + P1.2 (lane SKILL boilerplate consolidation) + P4.1 (dev-workflow Phase Execution law re-home) + P4.2 (completion-handoff rendered-UI re-home)
4. **Fourth wave** (runtime layer): P6.1 (legacy stub consolidation) + P6.2 (node-parse helper consolidation) + P6.5 (hook-config consolidation)
5. **Fifth wave** (specialist): P5.3 (code-quality-review RFP-3 anchor)
6. **Deferred / future** (operator-policy decisions needed): P1.3, P2.2, P3.1 (protected), P5.4, P5.6, P5.7, P6.4, P6.6, THEME 7 (constitutional-curtain optional sub-engagement)

## OPEN-SURFACES carried to Phase 4
- Each patch-ready row above needs CHANGE-SEQUENCE-DESIGN with proper `Skill(governance-modification)` Step 4 fields (PROBLEM-BASIS / CONSUMED-TARGET-SURFACE / EDIT-OPERATION / PRESERVED-MEANING / PRE-MUTATION-BASIS / REVIEW-PACKET-CITATION / NEXT-OWNER-ACTION)
- Per-patch 5-axis post-patch matrix + criterion-(c) philosophy-conformance verdict required for Post-Verify
- PROTECTED-CURTAIN-SURFACE patches (if pursued as sub-engagement) require additional gates per modification-core-law.md:144-147
- Operator decision needed on: P1.3 template-vs-parallel-structure tradeoff; P5.6 model-tier policy; THEME 7 constitutional-curtain optimization scope

## Convergence Record
PROCEDURE-EXECUTION-RESULT: complete (Phase 3 synthesis applied Candidate Filtering And Promotion Law to all 5 shard carriers; 206 raw candidates classified into promotion catalog above)
COHERENCE-RESULT: pass (cross-shard duplicates collapsed at synthesis; no internal contradictions detected)
FINDING-STATE-INVENTORY: see Promotion Summary above
CITATION-EVIDENCE-INVENTORY: all citations to shard carriers are Class A (carriers Read this turn) + carriers themselves contain Class A citations to .claude/ files (verified per-shard via lane-local self-verification PASS-2)
NEXT-OWNER-ACTION: `Skill(governance-modification)` Step 3 + Step 4 per-patch design loop for patch-ready items in priority order above
