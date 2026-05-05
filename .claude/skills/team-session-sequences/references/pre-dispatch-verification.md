---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Pre-Dispatch Readiness Index
This file is an index, not a second enforcement gate.

Canonical owners:
- Planning readiness: `.claude/skills/work-planning/references/execution-readiness.md`
- Assignment packet preflight: `.claude/skills/task-execution/references/assignment-packet.md`
- Runtime target truth: `.claude/skills/task-execution/references/runtime-dispatch-law.md`
- Dispatch recovery: `.claude/skills/task-execution/references/dispatch-recovery.md`
- Message classes and handoff fields: `.claude/skills/task-execution/references/message-classes.md`

Dispatch readiness coverage that must be preserved by those owners:
1. **Goal Alignment** - dispatch directly serves the user's actual request, not an assumed substitute.
2. **Alternative Routing** - at least one alternate lane, target, or decomposition was considered when material, with basis for the chosen route.
3. **Agent-Charter Fit** - the selected lane or agent is the best charter match for the work surface.
4. **Scope Appropriateness** - scope is neither unfocused nor missing needed context, and the boundary is explicit.
5. **Prior-Analysis Handoff** - settled upstream facts, findings, and reasoning needed by the receiver travel in packet fields, task/workflow state, or cited artifacts.
6. **Prerequisite Completeness** - material dependencies, setup, proof tool, run path, and acceptance prerequisites are resolved, deferred with owner, or blocked.
7. **Failure Path** - recovery path is known enough to avoid duplicate dispatch, silent serial collapse, or ownerless `HOLD`.

Risk-tier record rule:
- Low-risk bounded inspection may satisfy the index through goal alignment plus prior-analysis handoff when no other item is material.
- Medium-risk dispatch requires all material items to be present in the frozen readiness or packet basis.
- High-risk dispatch, including governance changes, architecture, deletion, or high-acceptance-risk work, records the readiness basis explicitly in `EXECUTION-READINESS-BASIS`; the dispatch packet may only carry or cite that basis.
- Runtime-protection emergencies may abbreviate only under the owning runtime policy, and the abbreviated basis must still be recorded.

Do not require a separate seven-question pre-dispatch checklist from `team-session-sequences`.
If readiness or packet basis is missing, use the canonical owner result: `packet-correction`, `route-replan`, `parallel-continue`, blocker-clear, or `HOLD`.
