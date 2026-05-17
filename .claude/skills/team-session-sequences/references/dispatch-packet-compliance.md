---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# team-session-sequences: Dispatch Packet Compliance
This section is a session-side controlled-value and presence-field lookup consumed by `Skill(team-session-sequences)` and `.claude/skills/task-execution/references/lane-additions.md` for lane-specific packet value and presence checks.

Cross-lane packet schema, common message classes, field format, and packet preflight remain owned by `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md`. Lane-specific packet additions and completion extras are owned by the target lane's agent-specific skill and lane-detail reference. Lane role documents remain always-loaded identity, boundary, and stop-condition spines, not packet catalogs. If wording diverges outside the table values below, consume the owning source named above.

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

## Lane-Specific Presence Hints
- researcher (always): `DECISION-TARGET`, `QUESTION-BOUNDARY`, `DOWNSTREAM-CONSUMER`
- researcher (sharded): `SHARD-ID`, `SHARD-BOUNDARY`, `MERGE-OWNER`
- researcher (benchmark): `BENCHMARK-BASIS`, `BENCHMARK-SURFACE`, `BENCHMARK-AXIS`
- developer: `PLAN-STEP`, `CHANGE-SPEC`
- developer (consequential): `AGENT-FIT`, `SCOPE-MATCH`, `PRIOR-ANALYSIS`
- reviewer: `REVIEW-TARGET-TYPE`, `REVIEW-TARGET`, `REVIEW-SCOPE`, `PREREQ-STATE`, `EVIDENCE-BASIS`, `ACCEPTANCE-RISK`, `ACCEPTANCE-SURFACE`, `PRIOR-ANALYSIS`
- reviewer (completion/contract-fit/current-scope): `EXPECTATION-SOURCES`, `SCOPE-BASELINE`, `ACTIVE-SLICE`
- tester: `PROOF-TARGET`, `PROOF-SURFACE`, `PROOF-EXPECTATION`
- tester (executable proof): `ENV-BASIS`, `SCENARIO-SCOPE`
- validator: `VALIDATION-TARGET-TYPE`, `VALIDATION-TARGET`, `EXPECTATION-SOURCES`, `REVIEW-STATE`, `TEST-STATE`, `VALIDATION-SURFACE`
- tester/validator (executable user-facing): `USER-RUN-PATH`, `BURDEN-CONTRACT`

Free-form descriptions in controlled-value fields are packet defects. Use the canonical value first, then put explanation in a separate detail or presence field.

Governance-sensitive `developer` packets keep the human-readable governance packet contract in `.claude/skills/governance-change/references/human-readable-packet-owners.md`. The shared cross-lane dispatch baseline, common packet fields, message classes, and packet preflight are owned by `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md`. Hooks remain last-resort runtime guards or warning surfaces only.

## Resolve Next Owner And Action
- Valid controlled values return to `task-execution` packet preflight.
- Free-form controlled-value content opens packet correction.
- Wording divergence opens the owning source reference named in this file.
- Governance-sensitive developer packet shaping opens `.claude/skills/governance-change/references/human-readable-packet-owners.md`.
