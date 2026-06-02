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
- Hooks guide execution by adding context, recording runtime state, or correcting exact tool input when the hook event supports it.
- Hooks block only actions that must never happen: destructive (data loss, irreversible state mutation, runtime corruption), security-critical (secret exposure, sandbox escape), session-stability-breaking (e.g., `tmux kill-*` against an active session), protected-filesystem bypass by a non-owner lane, or the observed Claude Code `SendMessage` schema failure where a string `message` lacks required `summary` and cannot be corrected by the exact-input rewrite path.
- The `SendMessage` schema-failure exception may block only the rejected string-`message` without-`summary` invocation shape and must name the observed schema basis.
- The worker-to-lead state-signal hook corrects only the exact no-detail state-token surface where `SendMessage.to` targets `team-lead` and the controllable renderable body would add a duplicated token, suffix, punctuation, detail, or other non-space text outside the single canonical state-signal slot.
- These `SendMessage` hooks remain hook-last: define or repair the loaded owner rule first, prove the current tool/schema or rendered-transport failure with live or official evidence, then keep the hook only as recurrence prevention for that exact malformed invocation shape.

### SendMessage State-Signal Runtime Coach
- The coach applies only to `SendMessage` calls targeting `team-lead` whose state signal is one of `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done`.
- A compliant state signal carries the token in `summary` or the single runtime-visible state slot and omits `message` when possible; if the schema requires `message`, its value is empty or one ASCII space.
- A non-empty `message` body paired with a state-token `summary`, or a string `message` state token without `summary`, is runtime-corrupting visible transport: it duplicates the only allowed state slot, makes receipt/completion classification ambiguous, and weakens the reporting curtain.
- The hook recovery path is corrected transport execution: use `updatedInput` when available to put the token only in `summary`, replace renderable body detail with one ASCII space, and add `additionalContext` naming `.claude/reference/reporting-curtain-spine.md` as the hot-path reporting-curtain consumer.
- The hook must not validate assignment packet completeness, carrier fields, role readiness, proof quality, ordinary lead-to-lane assignment content, `problem-report` detail routing, status requests, or any non-state-signal `SendMessage` content class.

### Reporting-Curtain Context Injection
- Reporting-curtain context hooks are execution reminders, not report filters.
- Use `additionalContext` only at narrow consumption moments: governed agent startup, high-risk user prompts involving reporting/governance/team transport, reporting-sensitive `Skill(agent-team-lead)`, `Skill(session-boot)`, `Skill(work-planning)`, `Skill(task-execution)`, or `Skill(review-verification)` load, successful reporting-relevant tool result, tool failure recovery, post-tool-batch next-model handoff, teammate idle/completion wakeup, and state-signal `SendMessage` correction.
- The injected context names `.claude/reference/reporting-curtain-spine.md`, the detailed-law escalation condition, and the valid next executable shape; it must not print user-facing warnings, create progress narration, or replace actual owner-surface consumption.
- Context injection is not proof that the model learned a document; downstream claims still require the owner to apply reporting-prohibition mapping to the exact renderable candidate.
- Reporting-curtain `PreToolUse(Bash)` correction is allowed only as `permissionDecision: "allow"` plus exact `updatedInput` redirection of internal stdout/stderr to governed files; it is not a blocking hook and must not erase executable command semantics or receiver-required evidence.

### Bash Internal Evidence Capture Contract
- Host-rendered `Bash` wrapper rows and tool-error wrapper rows are runtime evidence, not report reasons; they never create adjacent assistant-authored prose permission.
- Assistant-authored command-generated stdout/stderr that carries internal planning, measurement, sharding, dispatch, carrier, verification, monitoring, synthesis, path, count, or rationale detail is a controlled projection under `.claude/reference/reporting-prohibition-law.md`.
- Choose `Read`, `Grep`, `Glob`, `Bash`, task, runtime, or tool-native APIs by evidence fitness, owner-action necessity, and execution reliability. Do not avoid `Bash` merely to hide host-rendered rows, do not use `Bash` merely to create a user-visible progress display, and do not use lead-owned `Bash` to pre-poll retained outputs, inspect roots, count files, prove progress, or stage synthesis for an active quiet-window target before a receipt, completion, failure, permission, scope-pressure, blocker, explicit user status request, or elapsed-window recovery trigger exists.
- Keep command text executable. Do not add non-executable progress narration, route rationale, report labels, section banners, or user-facing explanations to a command for the purpose of communicating with the user.
- Read-only inspection/search pipelines and short inline shell logic are valid when they truthfully supply the needed evidence. Prefer structured/non-shell tools only when they are equal or stronger for the evidence surface.
- When a command would otherwise print non-reportable internal detail, use a silent predicate, exit status, or file-backed capture in the governed retained artifact, task state, runtime ledger, or evidence artifact named by the active procedure.
- Before executing `Bash`, classify the candidate command's terminal stdout/stderr projection. If it can print internal paths, file lists, line counts, byte counts, match lists, partition facts, carrier facts, verification facts, or route-sizing facts and the current user did not explicitly request that exact material, the command shape is invalid until rewritten to silent predicate, exit-status-only, or governed file-backed capture.
- High-volume inspection pipelines such as `find ... | sort`, `find ... | xargs wc -l`, `wc -l ... | sort`, `ls`, `grep`, `cat`, `head`, or `tail` over internal work surfaces are presumed stdout-unsafe unless their output is redirected to a governed capture path before execution.
- Appending `true`, printing a scalar success marker, or relying on folded tool rows does not make a stdout-producing internal-evidence command report-safe; suppress or capture the internal stdout/stderr at the command shape before execution.
- When a downstream owner needs only current-turn evidence and the command output does not carry non-reportable internal material, the tool result itself may support the next owner/action; host-rendered output still does not admit prose.
- Internal-only helper source is also a renderable projection. Do not create measurement, partition, probe, carrier-check, verification, or audit helper scripts through `Write`, `Edit`, `MultiEdit`, heredoc, or inline interpreter source when the source body would render and the user did not request that source. Prefer existing tools, simple shell primitives with governed file-backed capture, or an existing retained script whose source does not need to be authored in the current visible turn.
- If a helper script source is itself the requested deliverable or exact user-requested internal material, report admission governs the visible file-content projection; otherwise the active owner must redesign the evidence path before authoring the helper.
- Parallel tool-call dependency ordering follows `.claude/reference/work-execution-core-law.md` `## Execution Progress Law`; dependent consumer tools run only after the producer succeeds.
- File-backed capture uses a project-owned governed path such as the frozen output root, `.runtime`, task state, runtime ledger, or evidence artifact; `/tmp`, shell scrollback, and transient pane output are scratch context only and do not satisfy retained-evidence placement.
- Expected false workflow states such as missing not-yet-produced carriers, no grep match, empty pending files, or count zero route to the next owner/action as evidence; do not convert them into assistant-authored explanation while a correction, waiting, reuse, synthesis, or blocker-routing path exists.
- Output-root creation, carrier-directory creation, and retained-path preflight commands are internal filesystem evidence commands. Their success or failure opens the next filesystem owner/action, not assistant-authored diagnostic narration.
- If an output-root or retained-path creation/preflight returns a contradictory state such as create-says-existing while existence checks say absent, parent-present with child-create `ENOENT`, or repeated create failure for the same canonical name, classify it internally as `output-root-name-collision` or `filesystem-anomaly` and route to `.claude/reference/environment-output-root-filesystem-law.md` `## Output-Root Failure Recovery`; do not continue same-root probing as progress display.
- After one failed create/preflight for an intended output root, further same-name checks must be required by the output-root owner decision or stop in favor of a collision-free project-owned sibling/sub-batch root when the user did not require the exact path.
- `/tmp`, shell scrollback, transient pane files, and scratch probe files must not become retained carriers, output-root diagnostics, or substitute evidence for output-root recovery. If the project-owned output root is unavailable, choose a lawful project-owned alternate or route a user-action blocker only after internal alternates are exhausted.
- Do not use hook-side display suppression for evidence-bearing `Bash` output unless live runtime proof shows the acting agent still receives the completed command result. Observed `suppressOutput` behavior can make worker-visible `Bash` results appear as `No output`, so it is not a valid evidence-preserving control for connectivity probes, inventories, excerpts, counts, or progress sentinels.
- Do not make normal internal evidence output a hard-deny category. A display-output guard must not block underlying work, suppress internal blocker truth, delete evidence, erase packet content, cancel parallel tool calls, erase agent-visible command results, or require user intervention while an internal correction path remains.
- If a command accidentally exposes non-reportable internal detail through host-rendered stdout/stderr, treat the exposure as a projection violation, continue without adjacent narration, and preserve any downstream-required detail through the governed evidence path before the next claim or report.
- A non-developer worker `Write`/`Edit`/`MultiEdit` outside its frozen `RETAINED-OUTPUT-PATH` or declared `WRITE-SCOPE` is protected-filesystem bypass only when it would mutate source, governance, producer artifact, or another lane's output; the recovery path is narrowed target, packet/scope correction, or developer-owned mutation routing.
- A blocked `tmux kill-*` selection routes to cooperative shutdown, session-closeout, or non-tmux owner recovery.
- Non-tmux forceful runtime termination such as `kill <pid>` requires explicit operator approval plus the narrow runtime cleanup owner.
- Cooperative `shutdown_request` stays in routine runtime cleanup when a runtime cleanup owner selects a live process-backed teammate for cleanup.
- A settings-wired hook records cooperative cleanup evidence and runtime roster state after a worker sends `shutdown_response`.
- General cleanup uses cooperative `shutdown_request`, explicit operator-approved non-tmux force cleanup, or `session-closeout`.
- Positive-pattern or doctrine-shape enforcement (e.g., forcing a specific `TaskUpdate` field set, requiring a specific packet field, restricting valid `SendMessage` content classes, or validating non-rendered packet completeness) is owned by the exact failing owner path: `Skill(governance-modification)` for governance asset correction, `Skill(self-verification)` for produced-result convergence, and `Skill(review-verification)` named lenses for bounded pre-mutation or quality review; hooks do not own that enforcement unless the checked runtime edge is an exact reserved hard-deny danger, the observed uncorrectable `SendMessage` string-`message` without-`summary` schema failure, or the exact worker-to-lead state-signal input-correction case above.
- A hook that blocks legitimate doctrine-compliant variations (generic Claude Code tool patterns, valid worker-to-lead transport, allowed packet shapes, normal in-progress task signals) is over-broad blocking per `.claude/CLAUDE.md` `## 3. Work Execution Philosophy` and returns to narrowing or removal at the narrowest hook surface.
- Blocking hook/settings runtime-enforcement expansion requires `Skill(governance-modification)`, Hook-Last Footprint Review, `.claude/hooks/MANIFEST.md` Hook-Last Review Ledger entry, and explicit operator approval before activation.
- `[HOOK-LAYER-CACHE]` Mid-session removal of a positive-pattern hook first removes `.claude/settings.json` wiring and active manifest ownership; keep or add a file-level `exit 0` stub only when live evidence shows already-started teammates or local hook harness state still calls that exact path.
- Without current cache-retention evidence, remove the obsolete hook file and any legacy manifest list entry after verifying no active settings command, active hook dependency, or runtime owner reference still targets it.
- `[HOOK-AUTHOR-DUTY]` A new or modified hook script body consumes the execution-coach test before commit: does it first use context injection, runtime-state recording, or exact `updatedInput` correction, and reserve blocking only for destructive, security-critical, session-stability-breaking, protected-filesystem-bypass actions or an observed uncorrectable `SendMessage` schema failure?
- Positive-pattern, doctrine-shape, content-class, or compliance-field enforcement is invalid hook body content per `[HOOK-LAST]` unless the hook only injects context, records state, exactly corrects the state-signal input shape above, or blocks an exact reserved hard-deny danger/uncorrectable schema failure; invalid enforcement routes to the exact failing owner path: hook narrowing/removal at the hook surface, governance asset correction through `Skill(governance-modification)`, produced-result convergence through `Skill(self-verification)`, or bounded review through `Skill(review-verification)` named lenses.
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
- Current host tool availability, not role-file tool lists, memory, or prior sessions, controls tool invocation; verify uncertain or deferred tools before first use and route unavailable material capability through an available equivalent, deferred-tool discovery, or `Skill(tool-acquisition)`.
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
