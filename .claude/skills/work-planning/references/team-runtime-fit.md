# Work-Planning Team Runtime Fit
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Team operating rule: additional-agent lane work uses `TeamCreate` plus team-scoped `Agent`.

Standalone `Agent` supplies fallback or non-authoritative evidence only.

Lead-local or single-lane routing fits sequential chains, same-file edits, dependency-coupled steps, quick targeted changes, and latency-sensitive single-surface work.

Team-routed multi-lane work fits a request-visible deliverable that implies a dependent chain across two or more configured lanes.

Classify route from the full request-visible deliverable.

Team-agent runtime preserves route freeze, owner separation, proof ownership, and acceptance ownership.

## Resolve Next Owner And Action
- Team-fit work opens team-routed `work-planning`.
- Non-team-fit work opens lead-local or single-lane routing.
- Route ambiguity opens evidence gathering inside `work-planning`.
- Two-lane dependent deliverable freezes team-routed multi-lane work.
