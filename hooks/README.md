## Hook Wiring Note

- `settings.json` is the canonical source of active hook wiring for this payload.
- Hook scripts referenced by `settings.json` are the active runtime hooks.
- Helper scripts that are not wired directly by `settings.json` may remain only when an active hook or owner document explicitly calls them.
- Do not keep orphan hook files, legacy reference-only copies, or middle-stage patch artifacts inside this payload. If a hook script is neither wired nor explicitly referenced by an active owner surface, remove it.

## Active Hook Contract Overview

- The main session operates in `team-lead` mode and should remain in orchestration, delegation, monitoring, and closeout rather than direct editing or mutating Bash.
- Main-session diagnostic Bash is a routing failure. Reproduction, broader evidence gathering, and root-cause work belong to the delegated evidence lane.
- During explicit team-runtime operation, non-exempt worker lanes should normally be dispatched in background, and lanes that need explicit write authority must receive the required runtime mode.
- `compliance-agent-dispatch.sh` also blocks developer dispatch for manifest-sync copy or overwrite work unless pre-execution review, duplicate-collapse, and final write-scope reporting are explicit in the dispatch packet.
- Runtime-owned values such as the recurring health-check cadence should remain centralized in `hook-config.sh`; reminder text and owner documents should reference that setting rather than duplicating literals.
- Developer-exclusive specialist skills are runtime-enforced through `compliance-skill-authorization.sh`: specialist skill loading is restricted to `developer`, and direct lead approvals are recorded only after successful `SendMessage` delivery.

- `teammate-quality-gate.sh` is currently advisory-only. It records `TeammateIdle` observations for monitoring and does not deny or block worker flow.

- `hook-health-self-check.sh` is an advisory-only startup hook that verifies critical enforcement hooks are wired and present. It logs warnings to `hook-health.log` and the violation log but never denies or blocks. Controlled by `HOOK_HEALTH_SELF_CHECK_MODE` in `hook-config.sh` (default: `warn`, set to `off` to disable).
