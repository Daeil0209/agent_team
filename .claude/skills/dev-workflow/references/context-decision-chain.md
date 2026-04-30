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

These anchors prevent downstream re-derivation and phase drift. If a downstream artifact cannot be traced back to WHY and SCOPE, the context anchor is broken and phase advancement should HOLD.

## Decision Record Chain
Decisions propagate forward:
- discovery -> plan -> design -> implementation -> report

At minimum, downstream artifacts must preserve:
- architecture selection and any bounded supplementation
- CP2 scope decisions
- delivery experience commitments
- CP5 gap-resolution direction when relevant
- reference adoption/adaptation decisions when a reference informed planning

Downstream silent override of an upstream decision is prohibited.
