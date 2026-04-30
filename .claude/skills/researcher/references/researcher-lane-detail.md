---
name: researcher-reference
PRIMARY-OWNER: researcher
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Researcher Reference
## Auto-inject
false — load explicitly when packet detail, benchmark detail, evidence-hardening detail, or handoff detail is needed.

## Role-Spine Handoff
`agents/researcher.md` owns only the always-loaded researcher charter, boundary, receipt trigger, stop rule, and evidence-local completion duty. This reference owns detailed researcher packet fields, benchmark/evidence-hardening fields, surface-specific evidence requirements, operational reality classification, and handoff detail.

When a researcher role or skill says "researcher additions" or "researcher detail", consume this file directly. Do not re-expand `agents/researcher.md` into a packet-field catalog. Missing decisive evidence detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless safe inference preserves owner, phase, proof burden, acceptance burden, deliverable shape, and evidence boundary.

Control packets, message classes, lifecycle truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the researcher-specific payload and evidence discipline needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only. It does not replace an assignment-grade researcher packet when new bounded evidence work is assigned.
- If phase context and assignment-grade work arrive in the same execution segment, consume the embedded phase context inside the assignment packet and send `dispatch-ack`, not a separate `control-ack`.
- `lifecycle-control` is lifecycle-only direction, not assignment or workflow-phase control. Acknowledge it with `control-ack` only when it materially affects active work, standby readiness, or shutdown path.

## Researcher Packet Detail
- Consequential researcher packets should keep these fields explicit:
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

## Evidence Hardening Patterns
- Evidence-tier selection: external authoritative reference > prior session evidence > model prior knowledge > intuition.
- Use a higher-tier source when it is feasible and materially relevant; otherwise name the deferral basis. Settling for a lower tier while a material higher tier is available is an evidence defect.
- For design, visual, UX, methodology, and governance-hardening surfaces, external authoritative evidence or benchmark synthesis is the default quality ceiling raiser when the decision depends on current best practice.
- Authoritative-source depth
- Quantitative backing
- Concrete case evidence
- Cross-source normative references
- Evidence density self-check
- Requirement-vs-practice gap
- Secondary-effect tracing
- Specialist-boundary preservation
Use only the patterns that materially strengthen the assigned decision target.

## Handoff Completeness Challenge
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
- safe next packet correction or next owner

## Surface-Specific Evidence Requirements
- Visual, structural, interaction, and UX decision targets require rendered or multi-modal evidence. Text-only synthesis is a methodology defect unless the visual surface is explicitly unavailable and the handoff downgrades confidence.
- Multi-modal evidence may include image or screenshot capture, layout extraction, quantitative measurement of font, image, whitespace, table form, color, spacing, or typography signals, and rendered page or artifact observation.
- If researcher cannot obtain the required rendered or multi-modal evidence with its toolset, it must run bounded tool-selection research when current tools can lawfully inspect or search candidate options.
- The upward request must name: missing evidence surface; required capability; current toolset limit; candidate tools considered; recommended tool or program; fit rationale; why text-only evidence is invalid; smallest truthful evidence boundary; recommended setup owner or packet correction.
- Methodology, governance-hardening, and evolving best-practice decision targets require external authoritative evidence or benchmark synthesis unless infeasible. If infeasible, name the deferral basis and mark the claim as lower confidence.
- Use `.claude/skills/benchmark-simulation/references/observation-protocol.md` when per-modality discipline is needed.

## Benchmark-Enhanced Search Fields
Use these fields when benchmark perspective is active, or when `lookup` has widened into `learn` or `investigate` because the evidence surface is broader than direct fact retrieval. Packet mode fields are context only; benchmark evidence discipline is triggered by the decision target, evidence burden, and source-family need.
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
Severity should follow the evidence class. Do not promote static or theoretical issues into runtime-break claims without stronger evidence.

## Researcher Handoff Detail
- For request-bound document work, state what downstream drafting can start immediately from current evidence, what remains uncertain, and what extra research is optional versus blocking.
- If packet formatting instructions suppress the mandatory evidence contract, use `hold|blocker` and name the packet-format conflict in `OPEN-SURFACES`.
- Keep the handoff teammate-efficient: concrete evidence anchors, decision-ready conclusions, smallest useful unblock step.
- For benchmark-perspective work, include `COMPARISON-FRAME`, `QUERY-LEDGER-SUMMARY`, `SOURCE-FAMILY-COVERAGE`, `TRIANGULATION-STATUS`, `STOPPING-RULE`, `UNVERIFIED-CLAIMS`, and `DOWNSTREAM-BENCHMARK-NEEDS`.
