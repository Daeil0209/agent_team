---
name: researcher-reference
PRIMARY-OWNER: researcher
SOURCE-ANCHOR: .claude/skills/agent-researcher/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# Researcher Reference
## Contents
- Role-Spine Completion
- Researcher Packet Detail
- Evidence Tier Discipline
- Source-Family Method Floor
- Completion Completeness Challenge
- Surface-Specific Evidence Requirements
- Benchmark-Enhanced Search Fields
- Operational Reality Classification
- Researcher Completion Detail
- Resolve Next Owner And Action

## Role-Spine Completion
`agents/researcher.md` owns only the always-loaded researcher charter, boundary, receipt trigger, stop rule, and evidence-local completion duty. This reference owns detailed researcher packet fields, benchmark fields, evidence-tier discipline, surface-specific evidence requirements, operational reality classification, and completion detail.

When a researcher role or skill says "researcher additions" or "researcher detail", consume this file directly. Do not re-expand `agents/researcher.md` into a packet-field catalog. Missing decisive evidence detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless safe inference preserves owner, phase, proof burden, acceptance burden, deliverable shape, and evidence boundary.

## Researcher Packet Detail
- Consequential researcher packets keep these fields explicit:
  - `QUESTION-BOUNDARY`
  - `OUTPUT-SURFACE`
  - `RESEARCH-MODE`
  - `SOURCE-FAMILY`
  - `DECISION-TARGET`
  - `DOWNSTREAM-CONSUMER`
- When benchmark-light shaping is active, also carry:
  - `BENCHMARK-MODE`
  - `BENCHMARK-BASIS`
  - `BENCHMARK-SURFACE`
  - `BENCHMARK-AXIS`
  - `BENCHMARK-PROVENANCE`
  - `CROSS-CHECK-STATUS`
  - `HALLUCINATION-GUARD`
- When benchmark-perspective external evidence is active, carry or report these fields. If a field cannot be inferred safely from the packet or result, name it in `OPEN-SURFACES`; do not silently omit it:
  - `COMPARISON-FRAME`
  - `QUERY-LEDGER`
  - `REFORMULATION-OPERATORS`
  - `SOURCE-FAMILY-TARGETS`
  - `EVIDENCE-TABLE`
  - `TRIANGULATION-STATUS`
  - `STOPPING-RULE`
  - `UNVERIFIED-CLAIMS`
  - `DOWNSTREAM-BENCHMARK-NEEDS`

## Evidence Tier Discipline
- Evidence-tier selection in descending order: external authoritative reference > prior session evidence > model prior knowledge > intuition.
- A feasible, materially-relevant higher-tier source is the required default.
- Lower-tier use requires named deferral basis.
- Settling for a lower tier while a material higher tier is available is an evidence defect.
- For design, visual, UX, methodology, and governance-hardening surfaces, external authoritative evidence or benchmark synthesis is the default quality ceiling raiser when the decision depends on current best practice.

## Source-Family Method Floor
Use this floor when `SOURCE-FAMILY` includes market, technology, patent, academic, standards, regulatory, or mixed evidence for a report, analysis, generated artifact, or downstream program.
- Before evidence gathering, freeze the question axes, source-family targets, inclusion and exclusion basis, claim-evidence schema, confidence labels, and update-trace surface when they are material to the downstream artifact.
- Market or technology analysis names the market/practitioner, competitor or product, technical standard, academic or technical literature, and current practice source families that are included or explicitly excluded.
- Patent analysis names jurisdiction or database, CPC/IPC or equivalent classification, assignee or applicant filter, patent-family grouping, legal-status filter, filing or priority-date window, and claim or technology taxonomy.
- Academic or standards analysis names database or standards body, search axes, inclusion and exclusion basis, epistemic role, citation or snowballing status, and standard-version identity when material.
- Evidence-bound generation or automation work hands off reusable source schemas, query or search-log identity, claim-strength tiers, and downstream golden-fixture or oracle needs.
- Missing material method-floor basis is `hold|blocker` or `scope-pressure`, not low-confidence completion.

## Completion Completeness Challenge
Researcher must challenge decisive evidence basis before research discovery. This is not a demand for every possible source; it is a hard gate against starting from an implied, incomplete, contradictory, wrong-owner, or overbroad packet.

Evidence work is forbidden until the packet is classified as `execute` or `reconstruct-with-inference`. `scope-pressure` and `hold|blocker` are stop states, not notes.

| Classification | Condition | Required action |
| --- | --- | --- |
| `execute` | Decisive evidence basis is explicit, bounded, and owner-consistent | Proceed through workflow |
| `reconstruct-with-inference` | Missing detail is safely inferable without changing owner, phase, proof burden, acceptance burden, deliverable shape, or evidence boundary | Mark inference, proceed through workflow |
| `scope-pressure` | Packet is too wide, mixed-phase, wrong-owner, shardable, hides a prerequisite, or smuggles drafting/proof/validation into evidence work | Stop evidence work; send pressure to `team-lead` via `SendMessage` with smallest truthful evidence boundary |
| `hold|blocker` | Decision target, evidence boundary, downstream consumer, question surface, decisive evidence basis, or smallest truthful evidence boundary is materially ambiguous | Stop evidence work; send `MESSAGE-CLASS: hold|blocker` to `team-lead` via `SendMessage` with exact invalid or missing basis |

Upward assertion must name:
- invalid or missing decisive basis
- why the current packet cannot be executed as researcher-owned evidence work
- smallest truthful evidence boundary
- safe next packet correction or next owner/action

## Surface-Specific Evidence Requirements
- Visual, structural, interaction, and UX decision targets require rendered or multi-modal evidence. Text-only synthesis is a methodology defect unless the visual surface is explicitly unavailable and the completion carrier downgrades confidence.
- Multi-modal evidence includes image or screenshot capture, layout extraction, quantitative measurement of font, image, whitespace, table form, color, spacing, or typography signals, and rendered page or artifact observation when material.
- If researcher cannot obtain the required rendered or multi-modal evidence with its toolset, it must run bounded tool-selection research when current tools can lawfully inspect or search candidate options.
- The upward request must name: missing evidence surface; required capability; current toolset limit; candidate tools considered; selected tool or program candidate; fit rationale; why text-only evidence is invalid; smallest truthful evidence boundary; setup owner candidate or packet correction.
- Methodology, governance-hardening, and evolving best-practice decision targets require external authoritative evidence or benchmark synthesis unless infeasible. If infeasible, name the deferral basis and mark the claim as lower confidence.
- Use `.claude/skills/benchmark-simulation/references/observation-protocol.md` when per-modality discipline is needed.

## Benchmark-Enhanced Search Fields
Use these fields when benchmark perspective is active, or when `lookup` has widened into `learn` or `investigate` because the evidence surface is broader than direct fact retrieval. Benchmark evidence discipline is triggered by the decision target, evidence burden, and source-family need.
- `QUERY-LEDGER`: record query, operator, source family, high-value result, miss or failure mode, and next reformulation.
- `REFORMULATION-OPERATORS`: allowed operators are `broaden`, `narrow`, `synonym/paraphrase`, `entity-shift`, `source-type-shift`, `time-shift`, `anti-pattern-search`, and `citation-snowball`.
- `SOURCE-FAMILY-TARGETS`: name the intended mix across official or standard sources, primary research, systematic reviews, benchmark or evaluation corpora, practitioner case studies, domain authorities, and lower-tier discovery sources.
- `EVIDENCE-TABLE`: keep claim, source URL or citation, evidence unit, support label, and confidence or downgrade reason together.
- `TRIANGULATION-STATUS`: classify as `convergent`, `divergent`, `single-source`, or `blocked`; downgrade single-source support on consequential claims.
- `STOPPING-RULE`: name the branch, snowballing, or review stop condition and residual miss-risk.
- `DOWNSTREAM-BENCHMARK-NEEDS`: state whether downstream benchmark, tester, reviewer, or validator work is still needed before any proof, acceptance, or capability-improvement claim.

## Operational Reality Classification
Required classes for governance, process, or runtime-policy critique:
- `observed-runtime-break`
- `observed-operational-friction`
- `static-contradiction`
- `theoretical-risk`
Severity follows the evidence class. Do not promote static or theoretical issues into runtime-break claims without stronger evidence.

## Researcher Completion Detail
- For request-bound document work, state what downstream drafting can start immediately from current evidence, what remains uncertain, and what extra research is non-blocking versus blocking.
- If packet formatting instructions suppress the mandatory evidence contract, use `hold|blocker` and name the packet-format conflict in `OPEN-SURFACES`.
- For artifact, governance, program, report, or document critique, include the target intent that made the evidence relevant.
- If the completion proposes removal, reduction, simplification, or optimization, satisfy the common finding basis in `.claude/skills/task-execution/references/completion-handoff.md`.
- Keep the completion teammate-efficient: concrete evidence anchors, decision-ready conclusions, smallest useful unblock step.
- For benchmark-perspective work, include `COMPARISON-FRAME`, `QUERY-LEDGER-SUMMARY`, `SOURCE-FAMILY-COVERAGE`, `TRIANGULATION-STATUS`, `STOPPING-RULE`, `UNVERIFIED-CLAIMS`, and `DOWNSTREAM-BENCHMARK-NEEDS`.

## Resolve Next Owner And Action
- `execute` opens researcher-owned evidence work.
- `reconstruct-with-inference` opens researcher-owned evidence work with marked inference.
- `scope-pressure` opens team-lead packet correction, tool-selection research routing, owner split, or replanning.
- `hold|blocker` opens team-lead blocker resolution.
- Completed evidence work opens researcher completion.
- Downstream benchmark need opens the named benchmark, review, proof, or validation owner.
- Unverified consequential claim narrows the completion or opens the needed evidence route.
