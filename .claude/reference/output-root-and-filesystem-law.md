---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 5 [PROJECT-OUTPUT-ROOT]; Conditional Rules filesystem clauses"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---
# Common Doctrine Reference: Output Root And Filesystem Boundary

## Source Binding
This reference is trigger-bound detail for `CLAUDE.md` `[PROJECT-OUTPUT-ROOT]` and Conditional Rules filesystem clauses.
This reference owns:
- file-output placement
- source edit boundaries
- governance edit boundaries
- non-destructive filesystem discipline
These enforcement surfaces stay with `.claude/reference/runtime-boundary-law.md`:
- hook enforcement
- settings enforcement
Governance-text patch selection stays with `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.

## Purpose
Use this reference when work:
- creates files
- edits source files
- edits governance files
- names an output root
- targets a path outside the frozen output root
It keeps user deliverables in the task project folder.
It keeps governance edits on owner files.

## Consume When
- A task will create:
  - deliverables
  - logs
  - evidence
  - exports
  - generated products
- A source file will be edited.
- A governance file will be edited.
- The project output folder is unknown.
- A command targets a path outside the task project folder.
- Work targets:
  - runtime state
  - protected settings
  - secrets
  - incidental roots

## Required Output
The consuming owner records:
- output root
- source owner files
- governance owner files
- file-output admission basis, planned downstream consumer, and generated-output placement
- protected filesystem surfaces
- escalation basis when required
- non-destructive confirmation

## Stop
Stop before file output unless the file supports cross-agent shared work, explicit user-requested output, retained evidence, or planned durable continuation basis that a later owner will consume.
Stop before admitted file output when no safe canonical output root is frozen.
Stop before editing protected settings without the owning update path.
Stop before destructive mutation unless both are true:
- the user explicitly requested it
- the destructive-approval path is lawful
Stop before hiding protected filesystem mutation behind interpreter snippets.

## Resolve Next Owner And Action
- A stopped output route opens canonical output-root derivation.
- A stopped settings route opens the owning update path.
- A stopped destructive route opens:
  - explicit user approval
  - non-destructive redesign when redesign is lawful
- A stopped interpreter-mutation route opens direct owner-file mutation through the structured edit path.

## Output-Root Rules
- Admitted task-created outputs stay under the task project folder:
  - deliverables
  - evidence
  - logs
  - exports
- Tool output stays under the task project folder unless another canonical root is frozen.
- Place generated products outside:
  - repo root unless repo root is the frozen output root
  - `.claude/*`
  - runtime state
  - home
  - temp
  - incidental cwd
- If the project output folder is unknown, derive and freeze the safest canonical root.
- User escalation is invalid when a safe canonical root exists.
- Team-lead work-distribution planning documents live under `<project-root>/claude_doc/<work-name>/` inside the task project folder.
- Shared binding surfaces used by parallel dispatch live in the same `claude_doc/<work-name>/` folder as the planning document.
- Per-work-item retained outputs and intra-work synthesis co-locate in `claude_doc/<work-name>/` or its declared sub-batch directory.
- `parallel-fit` on-disk verification resolves materialized binding surfaces against this canonical location.
- `<work-name>` is named by the owning `work-planning` freeze; sub-batch directories such as `claude_doc/<work-name>/<date-or-batch>/` are allowed when multiple runs of the same work shape are needed.

## Filesystem Boundary Rules
- Record these before file work:
  - active workspace
  - repository boundary
  - frozen output root
- Use non-destructive mutation path for filesystem changes.
- Keep secret-bearing surfaces outside output artifacts.
- Send protected settings changes to the owning update path.
- Source edits stay on source owner files.
- Governance edits stay on governance owner files.
- These surfaces are runtime-owned:
  - team config
  - task state
  - mailbox state
  - cleanup state
- Keep these on runtime-owned surfaces:
  - task state
  - mailbox state
  - cleanup state
  - generated runtime state
- `claude_doc/<work-name>/` contents are protected work-artifact carriers, distinct from runtime-owned surfaces and from `.claude/` governance text.
- Hooks, settings rules, and runtime cleanup must not delete, move, or block `claude_doc/<work-name>/` lifecycle without explicit user-approved teardown.
- Any hook that adds `claude_doc/` deletion, write-rejection, or move logic enters the over-broad-blocking review per `.claude/hooks/MANIFEST.md` and CLAUDE.md `[HOOK-LAST]`.
