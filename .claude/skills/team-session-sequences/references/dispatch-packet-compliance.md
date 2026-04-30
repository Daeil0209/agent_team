---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Dispatch Packet Compliance
This section is the canonical session-side controlled-value and presence-field reference consumed by `.claude/skills/team-session-sequences/SKILL.md` and `.claude/skills/task-execution/references/lane-additions.md` for lane-specific packet discipline.

Cross-lane packet schema, common message classes, field format, and packet preflight remain owned by `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md`. Lane-specific packet additions and completion extras are owned by the target lane's lane-core skill and lane-detail reference. Lane role documents remain always-loaded identity, boundary, and stop-condition spines, not packet catalogs. If wording diverges outside the table values below, consume the more precise canonical owner.

## Controlled-Value Fields
| Lane | Field | Rule |
|------|-------|------|
| researcher | RESEARCH-MODE | `bounded` \| `deep` \| `sharded` as dispatch-shape context only; never a reasoning or coverage limit |
| researcher | SOURCE-FAMILY | `repo` \| `runtime` \| `web` \| `mixed` |
| researcher (benchmark) | BENCHMARK-MODE | `light` \| `full` |
| researcher (benchmark) | BENCHMARK-PROVENANCE | `repo-observed` \| `authoritative-external` \| `mixed` \| `simulator-only` |
| researcher (benchmark) | CROSS-CHECK-STATUS | `repo-confirmed` \| `authority-confirmed` \| `mixed-confirmed` \| `simulator-unconfirmed` |
| researcher (benchmark) | HALLUCINATION-GUARD | `cite-or-hold` |
| developer | PLAN-STATE | `ready` \| `approved` \| `updated` \| `revalidated` |
| developer | ACCEPTANCE-RISK | `low` \| `meaningful` \| `high` \| `critical` |
| developer | REVIEW-OWNER | `reviewer` |
| developer | PROOF-OWNER | `tester` \| `not-needed` |
| developer | ACCEPTANCE-OWNER | `reviewer` \| `validator` |
| reviewer | PREREQ-STATE | `complete` \| `partial` \| `missing` |
| validator | REVIEW-STATE | `ready` \| `hold` \| `blocked` |
| validator | TEST-STATE | `ready` \| `hold` \| `blocked` \| `not-needed` |

## Presence-Required Fields
- researcher (always): `DECISION-TARGET`, `QUESTION-BOUNDARY`, `DOWNSTREAM-CONSUMER`
- researcher (sharded): `SHARD-ID`, `SHARD-BOUNDARY`, `MERGE-OWNER`
- researcher (benchmark): `BENCHMARK-BASIS`, `BENCHMARK-SURFACE`, `BENCHMARK-AXIS`
- developer: `PLAN-STEP`, `CHANGE-SPEC`
- developer (consequential): `AGENT-FIT`, `SCOPE-MATCH`, `PRIOR-ANALYSIS`
- reviewer: `REVIEW-TARGET-TYPE`, `REVIEW-TARGET`, `REVIEW-SCOPE`, `EVIDENCE-BASIS`, `ACCEPTANCE-RISK`, `ACCEPTANCE-SURFACE`, `PRIOR-ANALYSIS`
- tester: `PROOF-TARGET`, `PROOF-SURFACE`, `ENV-BASIS`, `SCENARIO-SCOPE`, `PROOF-EXPECTATION`
- validator: `VALIDATION-TARGET-TYPE`, `VALIDATION-TARGET`, `EXPECTATION-SOURCES`, `REVIEW-STATE`, `TEST-STATE`, `VALIDATION-SURFACE`

Free-form descriptions in controlled-value fields are packet defects. Use the canonical value first, then put explanation in a separate detail or presence field.

Governance-sensitive `developer` packets keep the human-readable governance packet contract in `.claude/skills/self-growth-sequence/references/human-readable-packet-owners.md`. The shared cross-lane dispatch baseline, common packet fields, message classes, and packet preflight are owned by `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md`. Hooks remain last-resort runtime guards or warning surfaces only.
