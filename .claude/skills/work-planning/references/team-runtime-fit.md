# Work-Planning Team Runtime Fit
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Team operating rule: additional-agent lane work uses the team-agent runtime route.
`task-execution` owns `TeamCreate`, team-scoped `Agent`, assignment send, and reuse execution through `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

Standalone `Agent` supplies fallback or non-authoritative evidence only.
Standalone `Agent` is not a third work route.
Standalone `Agent` is not configured lane work, assignment-grade work, multi-surface audit work, review/proof/validation separation, receipt transport, reuse, monitoring, or completion handoff.
Operational burden, context size, setup friction, and coordination overhead are handled inside team-agent runtime planning through `ACTIVE-CONCURRENT-AGENT-CAP`, shard merge, sub-batching, serial phasing, reuse, or truthful `HOLD`; they do not convert required lane-owned work or independent specialist surfaces into standalone evidence-only work.
If standalone `Agent` is considered for evidence-only use, freeze it as lead-local evidence gathering with a concrete evidence purpose and no lane-state promise.
If the requested deliverable needs a configured lane owner, independent specialist surface, multi-surface audit, receipt, reuse, monitoring, or completion handoff, freeze team-agent runtime route or reopen route planning.
If configured independent-review handling is material, freeze `CODEX-INDEPENDENT-REVIEW-BASIS` through `Skill(codex-independent-review)`; standalone `Agent` is not configured independent review.

Lead-local or single-lane routing fits sequential chains, same-file edits, dependency-coupled steps, quick targeted changes, and latency-sensitive single-surface work.

Team-routed multi-lane work fits a request-visible deliverable that implies a dependent chain across two or more configured lanes.

Classify route from the full request-visible deliverable.

Team-agent runtime preserves route freeze, owner separation, proof ownership, and acceptance ownership.

## Resolve Next Owner And Action
- Team-fit work opens team-routed `work-planning`.
- Non-team-fit work opens lead-local or single-lane routing.
- Evidence-only standalone consideration returns to lead-local evidence-gathering classification.
- Route ambiguity opens evidence gathering inside `work-planning`.
- Two-lane dependent deliverable freezes team-routed multi-lane work.
