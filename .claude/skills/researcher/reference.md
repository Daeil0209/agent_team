---
name: researcher-reference
PRIMARY-OWNER: researcher
auto-inject: false
---
# Researcher Reference
## Auto-inject
false — load explicitly when packet detail, benchmark detail, evidence-hardening detail, or handoff detail is needed.

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

## Evidence Hardening Patterns
- Authoritative-source depth
- Quantitative backing
- Concrete case evidence
- Cross-source normative references
- Evidence density self-check
- Requirement-vs-practice gap
- Secondary-effect tracing
- Specialist-boundary preservation
Use only the patterns that materially strengthen the assigned decision target.

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
