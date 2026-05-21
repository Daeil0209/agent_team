---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# work-planning: Governance Depth
## Consume When
Use this reference when `work-planning` must freeze governance depth because project tier is unset, the current request changes lane count, proof depth, acceptance owner, workflow phase, external-tool authority, security/safety risk, or the user reports over-governance or under-governance.

## Detection Heuristics Table
These signals indicate a likely tier. They inform `team-lead` judgment. Project-tier authority comes from the frozen project floor. Project-level governance parameters apply after the project floor is frozen and consumed explicitly. Per-request handling raises autonomously when direct risk signals require a stricter task tier.
| Signal | Likely Tier |
|---|---|
| `terraform/`, `k8s/`, `docker-compose.yml` present in repo | Precision |
| Security-sensitive changes, auth systems, secrets management | Precision |
| MCP server, external review tool, credential/session bridge, or external-tool capability promotion | Standard; Precision if credentials, security boundary, blocking authority, or final-acceptance authority changes |
| API integration, third-party service wiring, multi-file feature | Standard |
| Structured development project with spec or design doc | Standard |
| Single page, simple script, isolated config change, typo fix | Lightweight |
| Single-user local app/tool/dashboard with bounded features, local data, no auth, no multi-tenant deployment, and no infrastructure orchestration | Lightweight by default; Standard if multi-feature business logic or persistence risk is material |
| Multi-source market, technology, patent, standards, or evidence-bound report automation | Standard; Precision if legal status, safety, regulatory, high-stakes decision, or source freshness materially affects acceptance |
| Engineering calculation, design, simulation, standards, unit, tolerance, or safety-margin critical path | Standard; Precision if standards compliance, safety, irreversible design choice, or high-stakes numeric output materially affects acceptance |
Local-app fast-path boundary: delivery-surface proof remains acceptance-critical at every tier. A Lightweight local app uses fewer agents and fewer design options only inside that proof floor. If it promises double-click/low-touch/browser UI operation, the real launch path and first usable view remain acceptance-critical.
## Freeze And Consume Wiring
When governance depth is active, freeze and consume these fields explicitly:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

Rules:
- `PROJECT-TIER` is the project floor.
- `ACTIVE-REQUEST-TIER` is the current request tier and stays at the floor or raises above it.
- `TIER-RAISE-REASON` must name `stay` or `raise`; do not leave the request tier implicit.
- A request raise strengthens the active route, proof, and acceptance path while preserving the project floor.
- Tier reduces unnecessary governance burden only inside the preserved proof and acceptance floor.
- Decisive user-surface proof remains fixed by the promised delivery surface.
## Governance Parameters Per Tier Table
| Parameter | Lightweight | Standard | Precision |
|---|---|---|---|
| **Default review/proof evidence depth** | `reviewer` evidence gate | `reviewer` + `tester` | `reviewer` + `tester` + `validator` |
| **Review scope** | Code quality | + architecture consistency | + security (`security-review`) + infrastructure |
| **Testing requirements** | Basic verification | Structured testing | E2E + security + performance |
| **Documentation required** | Minimal (inline) | Feature-specific docs | Architecture + design + API docs |
| **Default team size** | 1-2 agents | 2-4 agents | Precision 5-lane deployment |
| **Design options** | Conditional | Default | Required (3 architecture options) |
| **User-input checkpoint candidates** | CP4 only when implementation approval is truly user-owned | CP1, CP3, CP4 only when evidence leaves a true user-owned decision | CP1-CP5 only when evidence leaves a true user-owned decision |
| **Gap analysis** | Conditional | Default | Required before acceptance |
| **Specialist skills** | None by default | `dev-workflow`; add `external-tool-bridge` when external capability is active | `dev-workflow`; add `security-review`, `enterprise-architecture`, or `external-tool-bridge` only when each skill's activation criteria is true |
### Checkpoint Semantics
Checkpoint semantics (CP1-CP5) are defined by dev-workflow when active. This skill sizes where user input becomes relevant. Checkpoints and phase gates remain governed by their owning workflow. dev-workflow mandatory checkpoints still execute at all tiers and auto-resolve when doctrine, frozen request basis, and evidence decide the best owner path.
Acceptance-depth semantics: the table sizes default review and proof evidence depth for project governance. The validator lane retains final `PASS/HOLD/FAIL` authority when a final validation verdict is required by role separation, task risk, or the active workflow.
## Direct-Evidence Discipline
- Governance-depth tier is a sizing aid for review/proof/acceptance defaults; it does not override direct evidence.
- Design-implementation match and coverage-of-promised-surfaces remain reviewer and validator concerns under `references/deliverable-defaults.md` and `.claude/CLAUDE.md` `## 6. Judgment Philosophy`; team-lead uses direct evidence (review findings, proof results, validator verdicts, frozen `SCOPE-BASELINE` coverage), not a numeric heuristic, to iterate, escalate, or proceed.
- Oversight reduction requires direct evidence that the proof and acceptance floors remain satisfied; it never derives from a composite quality score.

## Resolve Next Owner And Action
- Return governance tier signals, direct-evidence conflicts, and oversight recommendations to the active `work-planning` path.
- If scaling changes phase gates, checkpoint frequency, lane use, or review depth, reopen the owning planning path before execution continues.
