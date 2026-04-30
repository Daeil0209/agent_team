---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Lane-Specific Additions
The common base packet is extended by lane-specific required fields:
- `developer`: change and acceptance boundary
- `researcher`: question and evidence boundary
- `reviewer`: review and acceptance boundary
- `tester`: proof and scenario boundary
- `validator`: verdict and expectation boundary

Each lane's lane-core skill and lane-detail reference own exact assignment additions and lane-specific completion extras beyond the common result spine. Lane role documents own always-loaded lane identity, boundary, and stop conditions; they are not packet catalogs.

For controlled packet value tables and lane-specific packet discipline, see `.claude/skills/team-session-sequences/references/dispatch-packet-compliance.md` for assignment-side values such as `RESEARCH-MODE`, `BENCHMARK-MODE`, `PLAN-STATE`, `ACCEPTANCE-RISK`, `PROOF-OWNER`, `PREREQ-STATE`, `REVIEW-STATE`, and `TEST-STATE`; see `.claude/skills/team-session-sequences/references/upward-handoff.md` for upward lane-owned state such as `VERDICT`. Those reference sections are the canonical lane-specific packet-discipline lookup. `.claude/skills/team-session-sequences/SKILL.md` owns the session-runtime trigger/spine; this file owns the cross-lane base schema. Hooks may warn or guard runtime integrity, but they are not the primary owner of normal agent behavior.
