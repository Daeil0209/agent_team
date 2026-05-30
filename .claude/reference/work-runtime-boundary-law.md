---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Environment Configuration Philosophy; Work Execution Philosophy runtime-boundary and over-broad-blocking rules"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Common Doctrine Reference: Runtime Boundary

## Source Binding
This reference is trigger-bound detail for `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy` hook-last and runtime-boundary clauses.
This reference owns the prose-vs-technical-enforcement boundary.
Governance-text patch selection stays with `.claude/reference/modification-minimal-governance-change-law.md` `## Patch-Ready Gate`.
Project output-root placement stays with `.claude/reference/environment-output-root-filesystem-law.md`.

## Purpose
Use this reference when boundary confusion is possible:
- prose rules with runtime enforcement
- hooks with owner procedure
- settings with owner procedure
- tools with proof
- tools with acceptance
- non-owner tool output with owner judgment
- runtime state with project documents
It keeps runtime guardrails narrow and prevents runtime signals from replacing owner procedure.

## Consume When
- A hook or setting is proposed as enforcement.
- A runtime signal might be treated as:
  - planning
  - proof
  - validation
  - acceptance
- A tool signal might be treated as:
  - planning
  - proof
  - validation
  - acceptance
- A claim depends on hook, settings, sandbox, or runtime-footprint behavior.
- These influences affect a route:
  - external MCP influence
  - external review-tool influence
  - external-review output influence
- External-review output influence affects a verdict.
- A runtime state file or team-runtime artifact is involved.

## Required Output
The consuming owner records:
- runtime surface involved
- governing owner rule
- runtime boundary result
- measured evidence when a runtime-footprint claim is made
- owner procedure that remains responsible
- blocker or follow-up owner when material

## Routing Gate
Hook changes route to the smallest non-runtime correction owner when risk belongs to:
- doctrine
- skill
- packet
- owner report
- task state
Settings changes route to the owning update path when risk belongs to:
- doctrine
- skill
- packet
- owner report
- task state
Protected settings edits require the owning update path.
Runtime-footprint claims require measured evidence.
Tool availability routes to the owner procedure for:
- proof
- validation
- acceptance
- dispatch truth
- owner completion
Bounded local tool discovery/setup that materially blocks the active owner path routes through `Skill(tool-acquisition)` under that owner procedure.
External API, MCP, auth, quota, credential, paid, persistent-service, or external bridge work routes through `Skill(external-tool-bridge)` or the named setup/security owner.
Hook/runtime signals route proof, validation, acceptance, dispatch truth, and owner completion claims to the owning procedure.
Non-owner tool output routes these claims to the owning procedure:
- a blocker
- a mutator
- validator
- acceptance owner

## Resolve Next Owner And Action
- Hook-risk gaps open the smallest non-runtime correction owner.
- Settings-risk gaps open the owning update path.
- Runtime-footprint claim gaps open measurement or narrow the claim to `UNVERIFIED`.
- Tool-signal gaps open the owner procedure that actually owns the claim.
- Bounded local tool discovery/setup that materially blocks the active owner path opens `Skill(tool-acquisition)` under that owner procedure.
- Non-owner tool output gaps open the owner procedure that actually owns the claim.

## Runtime Boundary Rules
- Hook-last rules from `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy` govern this section.
- Hook stdout JSON must validate against the Claude Code hook output schema for the matched event; emit empty stdout when the event's accepted `hookSpecificOutput` shape is not verified against `.claude/reference/environment-official-claude-code-source-cache.md` or live harness behavior, and rely on file/state side effects only.
- Adding an unverified JSON shape to hook stdout is a recurrence-class defect that returns to this rule for narrowing or silent fallback.
- Hooks block only actions that must never happen: destructive (data loss, irreversible state mutation, runtime corruption), security-critical (secret exposure, sandbox escape), session-stability-breaking (e.g., `tmux kill-*` against an active session), protected-filesystem bypass by a non-owner lane, or the observed Claude Code `SendMessage` schema failure where a string `message` lacks required `summary`.
- The `SendMessage` schema-failure exception is narrow: it may block only the rejected string-`message` without-`summary` invocation shape, must name the observed schema basis, must not enforce doctrine-shape variants that the tool would accept, and must route accepted-but-malformed doctrine behavior to the owning procedure, post-use transport tracker, or governance correction surface.
- The `SendMessage` schema-failure exception remains hook-last: define or repair the loaded owner rule first, prove the current tool rejection with live or official schema evidence, then keep the hook only as recurrence prevention for the rejected invocation shape.
- A non-developer worker `Write`/`Edit`/`MultiEdit` outside its frozen `RETAINED-OUTPUT-PATH` or declared `WRITE-SCOPE` is protected-filesystem bypass only when it would mutate source, governance, producer artifact, or another lane's output; the recovery path is narrowed target, packet/scope correction, or developer-owned mutation routing.
- A blocked `tmux kill-*` selection routes to cooperative shutdown, session-closeout, or non-tmux owner recovery.
- Non-tmux forceful runtime termination such as `kill <pid>` requires explicit operator approval plus the narrow runtime cleanup owner.
- Cooperative `shutdown_request` stays in routine runtime cleanup when a runtime cleanup owner selects a live process-backed teammate for cleanup.
- A settings-wired hook records cooperative cleanup evidence and runtime roster state after a worker sends `shutdown_response`.
- General cleanup uses cooperative `shutdown_request`, explicit operator-approved non-tmux force cleanup, or `session-closeout`.
- Positive-pattern or doctrine-shape enforcement (e.g., forcing a specific `TaskUpdate` field set, requiring a specific packet field, restricting valid `SendMessage` content classes) is owned by the exact failing owner path: `Skill(governance-modification)` for governance asset correction, `Skill(self-verification)` for produced-result convergence, and `Skill(review-verification)` named lenses for bounded pre-mutation or quality review; hooks do not own that enforcement unless the checked runtime edge is an exact reserved hard-deny danger or the observed `SendMessage` string-`message` without-`summary` schema failure above.
- A hook that blocks legitimate doctrine-compliant variations (generic Claude Code tool patterns, valid worker-to-lead transport, allowed packet shapes, normal in-progress task signals) is over-broad blocking per `.claude/CLAUDE.md` `## 3. Work Execution Philosophy` and returns to narrowing or removal at the narrowest hook surface.
- Blocking hook/settings runtime-enforcement expansion requires `Skill(governance-modification)`, Hook-Last Footprint Review, `.claude/hooks/MANIFEST.md` Hook-Last Review Ledger entry, and explicit operator approval before activation.
- `[HOOK-LAYER-CACHE]` Mid-session removal of a positive-pattern hook first removes `.claude/settings.json` wiring and active manifest ownership; keep or add a file-level `exit 0` stub only when live evidence shows already-started teammates or local hook harness state still calls that exact path.
- Without current cache-retention evidence, remove the obsolete hook file and any legacy manifest list entry after verifying no active settings command, active hook dependency, or runtime owner reference still targets it.
- `[HOOK-AUTHOR-DUTY]` A new or modified hook script body consumes the negative-only-filter test (does the body block only destructive, security-critical, session-stability-breaking, protected-filesystem-bypass actions, or the observed `SendMessage` string-`message` without-`summary` schema failure?) before commit and records the test result in the governance modification record.
- Positive-pattern, doctrine-shape, or compliance-field enforcement is invalid hook body content per `[HOOK-LAST]` unless the checked runtime edge is an exact reserved hard-deny danger or the observed `SendMessage` string-`message` without-`summary` schema failure above; invalid enforcement routes to the exact failing owner path: hook narrowing/removal at the hook surface, governance asset correction through `Skill(governance-modification)`, produced-result convergence through `Skill(self-verification)`, or bounded review through `Skill(review-verification)` named lenses.
- These ownership surfaces stay with owner procedures:
  - planning ownership
  - routing ownership
  - judgment ownership
- Proof ownership stays with tester or proof owner.
- Acceptance ownership stays with validator or acceptance owner.
- These provide technical enforcement:
  - settings
  - permissions
  - sandbox
  - hooks
- `CLAUDE.md`, role files, rules, skills, and references shape behavior through context.
- Label prose rules as context-bound operating rules in runtime-boundary claims.
- Governance-flow hooks stay separate from settings-deny secret protection.
- Hooks guard observable runtime edges that would otherwise produce reserved hard-deny danger.
- `settings.json` deny rules protect credential and secret paths.
- `settings.json` `permissions.defaultMode: bypassPermissions` is the project operator-policy posture for allowed tools; it removes permission-UI prompts but does not waive destructive, security-sensitive, hook/settings enforcement-expansion, or operator-policy approval rules.
- `EnterWorktree` opens only in the main `team-lead` session when an isolated git worktree is needed for the active repository and the owner records purpose, repository boundary, intended write surface, and exit condition before the tool call.
- `ExitWorktree` closes a main-session worktree path only after the owner records whether changes are preserved, moved, or discarded under the active filesystem, mutation, and destructive-approval boundaries.
- Worktree tools are not lane-agent procedure tools; lane isolation uses assignment/runtime routing rather than direct `EnterWorktree` or `ExitWorktree` authority.
- Treat external MCP as capability.
- Treat external review tools as capability.
- Fetch deferred-tool schemas via `ToolSearch` before first call when a deferred tool is material to the route.
- Runtime-boundary claims keep ownership with the governing role, skill, lane, or sequence.
- Route blocker decisions to the owning procedure.
- Route dispatch decisions to the owning procedure.
- Route validation decisions to `validator`.
- Route acceptance decisions to `validator`.
- Route mutation to the owning production or patch owner.
- Route credential repair to the security or setup owner.
- Route owner-gate changes to the owning governance sequence.
- Agent-team runtime state stays on the runtime-owned filesystem surfaces: team config, task state, mailbox state, cleanup state, and generated runtime state.
- Protected settings changes route to the owning update path.

## Footprint Claims
- Runtime-footprint claims require measured evidence.
- Hook-footprint claims require measured evidence.
- Unmeasured improvements are design-level or `UNVERIFIED`.
- Footprint detail lives in `.claude/reference/environment-runtime-footprint-continuity.md`.
