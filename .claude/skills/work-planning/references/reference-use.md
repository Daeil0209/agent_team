# Work-Planning Reference Use
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

This rule fires when the planning target involves any of:
1. data model design or modification
2. domain regulation or business rule encoding
3. operator workflow design
4. deliverable structure derived from external source such as Excel, PDF, spec sheet, or prior analysis
5. terminology or categorization scheme
6. quantitative threshold or invariant

If the trigger fires, reference handling is hard-mandatory planning evidence. Record the result in `REQUEST-FIT-BASIS`; when downstream work depends on it, carry cited identities or deviation basis through `REQUEST-BOUND-PACKET-FIELDS`. If it does not fire, record `REFERENCE-USE: not-applicable (no trigger condition active)` in the planning basis.

## Reference Discovery
`team-lead` must first inventory available authoritative references for the active scope through `work-planning`, including project discovery notes, canonical plan/design artifacts, external source documents, source data, specifications, and project-named reference files when present.

Record the inventory in the reference-use result as a list, even when the result is no reference found in standard locations. Explicit empty inventory is not an implicit skip.

## Citation Specificity
When reference exists in inventory, the reference-use result must cite specific path plus section number, line number, page number, table identifier, or equivalent location consulted.

Format:
`<path>:<location-id>:<topic-summary>`

Bare "reference exists" or "consulted source material" without specific location citation is a citation-specificity defect and blocks any dispatch that depends on the reference-driven basis.

## Deviation From Reference
If the plan/spec written from the team-lead planning basis deviates from the reference, such as simpler categorization, omitted fields, or renamed terminology, the reference-use result must include:

`DEVIATION-FROM-REFERENCE: <reference-citation> | <deviation-description> | <rationale>`

Silent deviation, where the spec contradicts reference without explicit acknowledgement, is a silent-PASS class defect.

## Packet And Verification Gate
- `task-execution` must not require a standalone `REFERENCE-USE` packet field. It must reject assignment-grade dispatch when the packet needs a reference-driven basis and the material citation or deviation identity is absent from request-bound packet fields or cited artifact basis.
- Citation specificity must match trigger scope before dispatch that consumes the reference-driven plan; use `SV-PLAN` only if the plan's citation basis is disputed.
- Reviewer and validator lanes verify spec-vs-reference compliance when the cited reference or deviation basis is material to their assigned surface, claim, or acceptance basis. Missing material reference basis is packet or planning debt, not lane rediscovery by habit.

## Reference Precedence
External authoritative references are high-weight evidence and may be binding when they are law, standard, safety, policy, contract, or frozen project source of truth. Explicit user direction may authorize a safe and lawful deviation only with recorded rationale. If a material conflict cannot be resolved from doctrine, active plan, reference authority, or explicit safe user direction, surface the conflict as the smallest truthful blocker instead of forcing routine user escalation.
