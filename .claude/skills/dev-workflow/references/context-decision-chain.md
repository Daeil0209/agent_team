# dev-workflow: Context Anchor And Decision Chain
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

## Context Anchor
Every downstream phase artifact and packet must preserve:
- `WHY`
- `WHO`
- `RISK`
- `SUCCESS`
- `SCOPE`

These anchors prevent downstream re-derivation and phase drift. If a downstream artifact cannot be traced back to WHY and SCOPE, the context anchor is broken; team-lead records `HOLD` or reopens the owning phase before advancement.

## Decision Record Chain
Decisions propagate forward:
- discovery -> plan -> design -> implementation -> report

At minimum, downstream artifacts must preserve:
- architecture selection and any bounded supplementation
- CP2 scope decisions
- delivery experience commitments
- CP5 gap-resolution direction when relevant
- reference adoption/adaptation decisions when a reference informed planning

A downstream change to an upstream decision routes to the owning phase correction, or to `work-planning` when a boundary changes; the changed artifact is not advancement evidence until the chain is reconciled.
