PRIMARY-OWNER: team-lead
WORK-NAME: governance-audit-2026-05-27
PURPOSE: Frozen binding surface for full-corpus governance audit + design + patch + verification

## Frozen Request Basis (verbatim user instruction)
현재 셋업된 클로드 코드 거버넌스 문서의 설계 구조를 전수조사하여 에이전트 팀 운영의 규정 절차 준수력과 효율을 향상 시킬 수 있도록 비효율적인 문서 구조 설계 오류 및 컨텍스트 소모 비용 측면의 개선이 필요한 모든 개선이 필요한 문제들을 도출해. 그리고 이 도출된 문제들을 해결하기 위해, 상위 철학 규정을 모두 준수할 수 있는 최적 설계 안을 도출하고, 보완패치를 실시해. 이때, 기존에 긍정적으로 동작하는 모든 기능들에 대해서 부정적인 영향 및 정보의 손실이 없도록 각 패치의 독립성 확보와 위치 이관 패치를 수행 해. 그리고 철저한 검증으로 기존 기능이 패치 이후에 유지되는가에 대해서 문서 설계 구조의 신뢰성을 증명해.

## SEMANTIC-INTENT-BASIS
- Improve agent-team governance corpus reliability, procedure-compliance, and context-efficiency
- Identify ALL structural design defects + ALL context-consumption inefficiency defects (no silent narrowing per `.claude/reference/review-and-verification-core-law.md` `## Anti-Narrowing Law`)
- Produce optimal design under §1-§8 upper philosophy + 8 mapped core laws
- Execute patches under modification-core-law: removal-first, consumed-surface, no-compression, executable-imperative, minimum-executable-information, dimensional-independence, upper-lower execution-drive, comprehension-as-execution-force
- Per-patch independence (modification-core-law criteria a/b/c + 5-axis post-patch matrix)
- 위치 이관 패치 = relocation patches: re-home rule content from non-consumed-surface to consumed-surface owner per dimensional-independence
- Rigorous post-patch verification proving no regression of pre-patch positive functions
- Anti-goals: information loss, negative impact on existing functions, lost patch independence, missing relocation

## TARGET-INTENT-BASIS
- Existing artifacts: all `.claude/` governance assets
- Cited design intent: `.claude/CLAUDE.md` §1-§8 + 8 mapped core laws in `.claude/reference/*.md` + 35 skill bodies in `.claude/skills/*/SKILL.md` + skill references + 6 role identities in `.claude/agents/*.md` + 28 hooks in `.claude/hooks/*.sh` + `.claude/hooks/MANIFEST.md` + `.claude/settings.json` + `.claude/settings.local.json`
- Applicable core-law axes: all 8 (Design Definition / Detailed Design / Work Execution / Review And Verification / Modification / Judgment / Reporting / Environment Configuration)
- Solution-structure basis: per modification-core-law dimensional-independence (top-doctrine / mapped-core-law / identity / operational / runtime)
- Affected owner surfaces: all owner surfaces consumed for governance actions
- Drift stop: patches affecting more than declared dimension reopen `Skill(governance-modification)`

## CORPUS MEASUREMENT (Phase 1 result)
Total: 203 files across `.claude/`

| Layer | Path | Files | Lines |
|---|---|---|---|
| TOP-DOCTRINE | `.claude/CLAUDE.md` | 1 | 118 |
| CORE-LAWS | `.claude/reference/*.md` | 20 | 2,101 |
| IDENTITY | `.claude/agents/*.md` | 6 | 584 |
| SKILLS | `.claude/skills/*/` | 35 dirs, ~140 files | ~12,200 |
| HOOKS | `.claude/hooks/*.sh` + MANIFEST.md | 28 + 1 | 5,444 |
| SETTINGS | `.claude/settings.json` + `.local.json` | 2 | 210 |

## COMPLETION-STOP-CONDITION
Validator PASS on:
(a) full-corpus defect inventory complete — every opened candidate promoted (per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` ladder), rejected by current review basis, covered by lawful owner deferral, excluded by explicit user-narrowed out-of-scope basis, or HOLDed with truthful blocker
(b) optimal design under upper-philosophy conformance verified per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of §1-§8 + mapped core-law axes for every patch
(c) every patch-ready defect applied, lawfully deferred, rejected by current review basis, or blocked by truthful HOLD
(d) per-patch 5-axis post-patch matrix evidence (defect closure / intent preservation / no new defect / cross-reference integrity / dimensional independence) PLUS philosophy-conformance verdict (per `.claude/reference/modification-core-law.md` criterion-c)
(e) post-patch positive-function preservation evidence proving no regression on adjacent surfaces

Per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`, lead-authored wave/batch/sample/priority pressure cannot terminate; full-corpus completion requires frozen-corpus coverage.

## SHARD ASSIGNMENT (Phase 2 — 5 shards across 2 waves + 1 follow-on)

### Shard A — TOP-DOCTRINE + CORE-LAWS (Wave 1)
Owner: reviewer (shard-a)
CLAIM-CEILING: evidence-only candidates
Files:
- `.claude/CLAUDE.md` (118)
- `.claude/reference/design-definition-core-law.md` (31)
- `.claude/reference/design-delivery-evidence-acceptance-law.md` (131)
- `.claude/reference/detailed-design-core-law.md` (35)
- `.claude/reference/detailed-scope-continuity-change-law.md` (100)
- `.claude/reference/environment-configuration-core-law.md` (35)
- `.claude/reference/environment-official-claude-code-source-cache.md` (134)
- `.claude/reference/environment-output-curtain-runtime.md` (52)
- `.claude/reference/environment-output-root-filesystem-law.md` (111)
- `.claude/reference/environment-runtime-footprint-continuity.md` (86)
- `.claude/reference/judgment-core-law.md` (39)
- `.claude/reference/modification-context-reduction-preservation-map.md` (89)
- `.claude/reference/modification-core-law.md` (159)
- `.claude/reference/modification-minimal-governance-change-law.md` (190)
- `.claude/reference/reporting-core-law.md` (39)
- `.claude/reference/reporting-prohibition-law.md` (77)
- `.claude/reference/review-and-verification-core-law.md` (145)
- `.claude/reference/work-execution-core-law.md` (181)
- `.claude/reference/work-procedure-ownership-law.md` (142)
- `.claude/reference/work-runtime-boundary-law.md` (146)
- `.claude/reference/work-skill-reference-binding-law.md` (179)
Burden: 2,219 lines, 21 files, highest rule-density layer
Output carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-a-top-doctrine-and-core-laws.md`

### Shard B — IDENTITY + ORCHESTRATION-SKILLS (Wave 1)
Owner: reviewer (shard-b)
CLAIM-CEILING: evidence-only candidates
Files:
- `.claude/agents/team-lead.md` (84)
- `.claude/agents/developer.md` (92)
- `.claude/agents/researcher.md` (87)
- `.claude/agents/reviewer.md` (98)
- `.claude/agents/tester.md` (103)
- `.claude/agents/validator.md` (120)
- `.claude/skills/agent-team-lead/` (673 lines)
- `.claude/skills/work-planning/` (1,085 lines)
- `.claude/skills/task-execution/` (1,679 lines)
- `.claude/skills/dev-workflow/` (1,564 lines)
- `.claude/skills/session-boot/` (520 lines)
- `.claude/skills/session-closeout/` (146 lines)
- `.claude/skills/team-session-sequences/` (511 lines)
Burden: ~6,762 lines, identity + lead orchestration
Output carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-b-identity-and-orchestration-skills.md`

### Shard C — EXECUTION-QUALITY + LANE-SKILLS (Wave 2)
Owner: reviewer (shard-c — reuse shard-a member)
CLAIM-CEILING: evidence-only candidates
Files:
- `.claude/skills/review-verification/` (269 lines)
- `.claude/skills/self-verification/` (120 lines)
- `.claude/skills/governance-modification/` (113 lines)
- `.claude/skills/codex-independent-review/` (400 lines)
- `.claude/skills/team-meeting/` (189 lines)
- `.claude/skills/agent-developer/` (350 lines)
- `.claude/skills/agent-researcher/` (268 lines)
- `.claude/skills/agent-reviewer/` (287 lines)
- `.claude/skills/agent-tester/` (352 lines)
- `.claude/skills/agent-validator/` (466 lines)
- `.claude/skills/tool-acquisition/` (89 lines)
- `.claude/skills/external-tool-bridge/` (176 lines)
Burden: ~3,079 lines, execution-quality + agent lanes
Output carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-c-execution-quality-and-lane-skills.md`

### Shard D — DOMAIN + METHODOLOGY-SKILLS (Wave 2)
Owner: reviewer (shard-d — reuse shard-b member)
CLAIM-CEILING: evidence-only candidates
Files:
- `.claude/skills/benchmark-simulation/` (691 lines)
- `.claude/skills/business-workflow/` (546 lines)
- `.claude/skills/code-quality-review/` (116 lines)
- `.claude/skills/design-system-tokens/` (213 lines)
- `.claude/skills/document-automation/` (403 lines)
- `.claude/skills/engineering-grounding/` (125 lines)
- `.claude/skills/enterprise-architecture/` (196 lines)
- `.claude/skills/feynman-clarity/` (191 lines)
- `.claude/skills/instructional-design/` (103 lines)
- `.claude/skills/log-based-qa/` (189 lines)
- `.claude/skills/mathematical-correctness/` (117 lines)
- `.claude/skills/mockup-to-component/` (135 lines)
- `.claude/skills/security-review/` (214 lines)
- `.claude/skills/software-architecture/` (221 lines)
- `.claude/skills/visual-composition/` (285 lines)
- `.claude/skills/work-tool-patterns/` (270 lines)
Burden: ~4,015 lines, domain/methodology skills
Output carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-d-domain-and-methodology-skills.md`

### Shard E — RUNTIME + SETTINGS (Wave 3, single reviewer)
Owner: reviewer (shard-e — reuse one member)
CLAIM-CEILING: evidence-only candidates
Files:
- `.claude/hooks/*.sh` (27 hooks, 5,290 lines)
- `.claude/hooks/MANIFEST.md` (154)
- `.claude/settings.json` (202)
- `.claude/settings.local.json` (8)
Burden: ~5,654 lines, runtime enforcement layer (mostly bash; semantic audit = settings↔hook wiring consistency, hook semantic alignment with governance rules, MANIFEST currency)
Output carrier: `claude_doc/governance-audit-2026-05-27/shards/shard-e-runtime-and-settings.md`

## AUDIT METHOD (shared across all shards)

Each reviewer applies the following review lenses to assigned corpus surface, recording each finding as `candidate-evidence` (lane-local first-pass ceiling per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`).

### Lens 1 — Upstream Basis Review
Per `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law`:
- Does each rule cite upstream basis (§1-§8 / mapped core law) where material?
- Missing / stale / contradicted / unconsumed governing basis = candidate-evidence finding

### Lens 2 — Owner Boundary And Skill Consumption
Per `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law`:
- Owner-boundary conflicts (work moved across owner/lane/workflow/proof/validation/reporting/runtime/mutation boundaries without current authority)
- Skill-consumption defects (missing/wrong-owner/unrecorded/narrated-without-applied-effect/burden-only)

### Lens 3 — Governance Coherence Gap
Per `.claude/reference/review-and-verification-core-law.md` `## Governance Coherence Gap Law`:
- Upper-to-core gap (top-doctrine execution change without mapped core-law executable detail)
- Core-to-trigger-bound gap (core-law executable detail needs situation-specific consuming-owner guidance and no triggered owner reference carries it)

### Lens 4 — Minimum Executable Information
Per `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law`:
- Under-specified governance (omits material information required for active owner to act/stop/verify/route/claim completion)
- Over-specified governance (non-executed procedure, examples, explanation, context that increases consumption burden without changing execution)
- Lower-surface repetition masking weak top/core consumption
- Evasion-enabling wording (lets owner avoid required action/evidence/verification/route/blocker/completion)
- Ambiguous or conflicting wording (multiple plausible next actions or incompatible duties)
- Bottleneck-forming wording (top-doctrine `bottleneck defect` definition applied to governance text)
- Over-broad-blocking wording (blocks/stalls/downgrades valid owner action beyond evidence/safety/verification/acceptance-truth/procedure-force need)
- Subjective-judgment qualifiers without operational anchor or canonical-definition citation
- Comprehension-friction (textual-feature class + traced executable-action impedance — both required per the law's two-conjunctive-element rule; promotion without both is rejected)

### Lens 5 — Modification-Core-Law Compliance
Per `.claude/reference/modification-core-law.md`:
- `removal-first` violations: append/duplicate-add where tighten/replace/trim/merge/re-home/delete would suffice
- `consumed-surface` violations: rule placed away from the owner that consumes it
- `no-compression` violations: independent meanings merged into one sentence; OR same-pattern peer terms split without basis
- `upper-lower execution-drive` violations: chain breaks from top-doctrine to mapped core-law to trigger-bound to tool action
- `executable-imperative` violations: hazardous-action prohibition without replacement action or next owner
- `minimum-executable-information` violations: see Lens 4
- `dimensional-independence` violations: rule that changes text or behavior across declared-dimension boundary
- `comprehension-as-execution-force` violations: see Lens 4 comprehension-friction
- Direct-consumption relevance violation: reference path added for existence/discoverability/citation convenience/broad traceability/reverse-linking/possible future use only
- Source-to-destination traceability violation: orphan, missing trace
- Protected-local-restatement basis missing: duplicate doctrine without `PROTECTED-LOCAL-RESTATEMENT-BASIS: <basis>` declared in patch record or local surface

### Lens 6 — Context-Consumption Efficiency (user-specific concern)
- Duplicated rule text across multiple files without protected-local-restatement basis (information cost: same content loaded twice)
- Over-large skill bodies that exceed minimum-executable-information for the routine path
- Reference chains requiring loading many files for one decision (depth-of-load defect)
- Cross-reference bloat (long Reference Maps without trigger discipline)
- Repeated structural-contract boilerplate across skills (skill-template duplication)
- Quote-only / restatement-only content that adds line count without changing execution

### Lens 7 — Reporting-Curtain Consistency (constitutional)
Per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain` + `.claude/reference/reporting-prohibition-law.md`:
- Any rule that contradicts the Pre-Report Gate or canonical envelope shape
- Any process-narrative wording that would invite curtain breach
- Any restatement of curtain-protected surfaces that violates the PROTECTED-CURTAIN-SURFACE rule
- NOTE: protected-curtain surfaces enumerated in `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` — do NOT propose patches that simplify/tighten/reduce/sweep/dedup those surfaces without validator pre-approval + user notification gates documented

### Lens 8 — Single-Source-Of-Truth (SSOT)
Per `.claude/reference/reporting-core-law.md` `## Reporting Plane Law`:
- "Restating reporting or transport semantics outside named owners is a single-source-of-truth defect."
- Apply analogous SSOT check to all governance: any rule restated outside its named single owner without protected-local-restatement basis is candidate-evidence

## FINDING-STATE LADDER (lane-local ceiling)
Per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`:
- Lane-local first-pass: `candidate-evidence` (raw observation with anchor) or `candidate-classified` (mapped to lens + proposed class) — both stay candidate-state until team-lead synthesis promotes
- Lane-local rejection: `rejected:<basis>` with basis from {`protected-restatement`, `design-tradeoff`, `non-issue`, `risk-hypothesis`, `unverified`, `not-material:<basis>`} — stays candidate-evidence until team-lead promotion synthesis consumes
- Bare `CONFIRMED` or `defect` labels are invalid; use exact ladder state
- Per-item raw candidate + candidate-classified + rejected counts kept separate
- DO NOT promote to `confirmed-defect`, `patch-worthy`, or `patch-ready` — those promotions are team-lead Phase 3 synthesis work via `Skill(review-verification)`

## CARRIER FORMAT (each reviewer's output)
```
SHARD-ID: <shard-letter>
WORK-SURFACE: <list of audited files>
CLAIM-CEILING: evidence-only candidates
AUDIT-METHOD-APPLIED: lenses 1-8 from binding surface

CANDIDATE-INVENTORY:
[item-1]
  ANCHOR: <file:line>
  LENS: <1|2|3|4|5|6|7|8>
  CLASS: <e.g., over-specified | under-specified | duplicate-without-basis | broken-cross-ref | ...>
  EVIDENCE: <observed text or behavior>
  PROPOSED-OWNER-FOR-CORRECTION: <consumed-surface owner>
  STATE: candidate-evidence | candidate-classified | rejected:<basis>

[item-2]
  ...

COUNTS:
  raw-candidate: <n>
  candidate-classified: <n>
  rejected:<basis-1>: <n>
  rejected:<basis-2>: <n>

DEFEATER-RECORD:
  - For each lens applied, name the defeater test attempted (what would defeat the finding) and the disproof attempt outcome
  - Carrier-as-evidence rejection: no fabricated PASS/PASS-1/PASS-2 labels without actual tool-call evidence
  - Empty-finding shard requires defeater record showing positive disproof attempts on the lens

REVIEW-STATE: ready | hold | blocked
EVIDENCE-BASIS: list of file:line anchors actually inspected
OPEN-SURFACES: <unfinished audit slices, if any, with reason>
LANE-NEXT-CANDIDATE: <e.g., handoff to team-lead promotion synthesis | escalate scope-pressure>
```

## MERGE / ACCEPTANCE CHAIN
- Merge owner: team-lead (Phase 3 — `Skill(review-verification)` defect-promotion synthesis from all shard carriers)
- Acceptance chain: Phase 3 promotion → Phase 4 design (via `Skill(governance-modification)` Step 3-4) → Phase 5 patch execution → Phase 6 preservation verification → Phase 7 validator final acceptance
- Cross-shard duplicate findings: surface separately per shard; team-lead promotion synthesis collapses duplicates with `PROTECTED-LOCAL-RESTATEMENT-BASIS` check

## DEPENDENCY / NON-OVERLAP BOUNDARY
- Each shard owns DISTINCT file sets — no overlap on file paths
- Each shard produces its OWN carrier — no cross-shard write
- Cross-shard rule relationships are recorded per-shard as `CROSS-SHARD-DEPENDENCY` notes, not collapsed
- Independent acceptance contracts per shard (each shard PASS = its assigned file set audited with lens application and defeater record)

## CONTEXT NOTES FOR REVIEWERS
- Apply `Skill(agent-reviewer)` IR-1 adversarial-critic stance, defeater-first posture, carrier-as-evidence rejection, quality-obligation
- Do NOT mutate any audited file — read-only audit
- DO NOT promote past candidate-evidence — team-lead synthesis is the promotion owner
- For very-large files (1000+ lines), the reviewer may use targeted Grep + Read of high-density sections, but must explicitly record `EVIDENCE-BASIS` lines inspected to defeat the silent-narrowing risk per `## Anti-Narrowing Law`
- Cross-reference resolution: when a finding cites a cross-reference, inspect the target file to verify resolution (broken-cross-reference defects require both sides inspected)
