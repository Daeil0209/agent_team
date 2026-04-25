#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

# ─── SHARED PARSE: prompt + session_id ──────────────────────────────────────
PARSED_SHARED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const prompt = String(input.prompt || "").replace(/\s+/g, " ").trim();
  const sessionId = String(input.session_id || "");
  process.stdout.write(prompt + "\n" + sessionId + "\n");
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
mapfile -t SHARED_FIELDS <<<"$PARSED_SHARED"
USER_PROMPT="${SHARED_FIELDS[0]:-}"
PROMPT_SESSION_ID="${SHARED_FIELDS[1]:-}"
PROMPT_SESSION_ID="$(recover_session_id "$PROMPT_SESSION_ID")"

# Strip ALL known harness-injected wrapper blocks before correction-pattern
# detection. Harness wrappers (system-reminder, command-name, command-message,
# command-args, command-output, local-command-stdout/stderr/caveat,
# task-notification) carry skill listings, slash-command metadata, doctrine
# excerpts, and command output that legitimately contain trigger words
# ("self-growth", "behavioral defect", "재발 방지", etc.) and must never be
# attributed to the user as correction language. The wrapper list inside the
# node block is authoritative; extend it there when a new harness wrapper is
# observed. Block-form, self-closing, and orphan opening/closing tags are all
# stripped. Other prompt consumers (delete-approval, closeout intent, recovery
# context) keep using raw USER_PROMPT — that is the author-intended scope.
sanitize_prompt_for_correction_detection() {
  local raw="${1-}"
  RAW_PROMPT="$raw" node <<'NODE'
const raw = String(process.env.RAW_PROMPT || "");
const HARNESS_WRAPPERS = [
  "system-reminder",
  "command-name",
  "command-message",
  "command-args",
  "command-output",
  "local-command-stdout",
  "local-command-stderr",
  "local-command-caveat",
  "task-notification",
];
let stripped = raw;
for (const tag of HARNESS_WRAPPERS) {
  const block = new RegExp(`<${tag}\\b[^>]*>[\\s\\S]*?<\\/${tag}>`, "giu");
  const selfClose = new RegExp(`<${tag}\\b[^>]*\\/>`, "giu");
  const orphanOpen = new RegExp(`<${tag}\\b[^>]*>`, "giu");
  const orphanClose = new RegExp(`<\\/${tag}\\s*>`, "giu");
  stripped = stripped
    .replace(block, " ")
    .replace(selfClose, " ")
    .replace(orphanOpen, " ")
    .replace(orphanClose, " ");
}
stripped = stripped.replace(/\s+/g, " ").trim();
process.stdout.write(stripped);
NODE
}
USER_PROMPT_FOR_PATTERNS="$(sanitize_prompt_for_correction_detection "$USER_PROMPT")"

is_system_generated_followup_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  # Skill/content bridge messages are system-generated follow-ups, not real user
  # turns. If they re-arm planning enforcement, the lead can never reach
  # TeamCreate/Agent after loading work-planning/self-verification.
  if printf '%s' "$prompt" | grep -qE '^(Base directory for this skill:|Tool loaded\.)'; then
    return 0
  fi

  # Task-notification turns carry planning state forward only when they are
  # notification-only. Mixed turns that retain user text outside the block are
  # fresh user turns and must re-arm planning.
  if task_notification_only_prompt "$prompt"; then
    return 0
  fi

  # Teammate handoff turns (worker reports routed back to lead via SendMessage)
  # are not fresh user instructions; if they re-arm planning, every worker
  # report forces a redundant WP+SV cycle on the lead even though the routing
  # decision was already frozen. Treat prompts that contain only
  # <teammate-message> blocks (no user-authored text outside) as
  # notification-only carry-forward, mirroring task-notification handling.
  if teammate_message_only_prompt "$prompt"; then
    return 0
  fi

  return 1
}

task_notification_only_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  TASK_NOTIFICATION_PROMPT="$prompt" node <<'NODE' >/dev/null
const prompt = String(process.env.TASK_NOTIFICATION_PROMPT || "").trim();
if (!/<task-notification\b/i.test(prompt)) process.exit(1);
const stripped = prompt
  .replace(/<task-notification\b[^>]*\/>/giu, " ")
  .replace(/<task-notification\b[^>]*>[\s\S]*?<\/task-notification>/giu, " ")
  .replace(/<task-notification\b[^>]*>[\s\S]*$/giu, " ")
  .replace(/\s+/g, " ")
  .trim();
process.exit(stripped ? 1 : 0);
NODE
}

teammate_message_only_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  TEAMMATE_MESSAGE_PROMPT="$prompt" node <<'NODE' >/dev/null
const prompt = String(process.env.TEAMMATE_MESSAGE_PROMPT || "").trim();
if (!/<teammate-message\b/i.test(prompt)) process.exit(1);
const stripped = prompt
  .replace(/<teammate-message\b[^>]*\/>/giu, " ")
  .replace(/<teammate-message\b[^>]*>[\s\S]*?<\/teammate-message>/giu, " ")
  .replace(/<teammate-message\b[^>]*>[\s\S]*$/giu, " ")
  .replace(/\s+/g, " ")
  .trim();
process.exit(stripped ? 1 : 0);
NODE
}

status_runtime_recovery_context() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  USER_PROMPT="$prompt" \
  PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" \
  WORKER_IDLE_NOTICE_FILE="$WORKER_IDLE_NOTICE_FILE" \
  WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" \
  WORKER_DISPATCH_ACK_PENDING_FILE="$WORKER_DISPATCH_ACK_PENDING_FILE" \
  HOME_DIR="$HOME" \
  STALE_WARN_SECONDS="${STALE_WARN_SECONDS:-120}" \
  DISPATCH_ACK_LATE_SECONDS="${DISPATCH_ACK_LATE_SECONDS:-30}" \
  PENDING_DISPATCH_STALE_SECONDS="${PENDING_DISPATCH_STALE_SECONDS:-120}" \
  node <<'NODE' 2>/dev/null || true
const fs = require("fs");
const path = require("path");

const prompt = String(process.env.USER_PROMPT || "").trim();
if (!prompt) process.exit(0);

const statusPromptRe =
  /(?:\bstatus\b|\bprogress\b|\bcurrent state\b|\bwhat remains\b|\bwhat(?:'s| is) left\b|\bwhat are you doing\b|\bwhy (?:did|are) you stop(?:ped)?\b|\bwhat is happening\b|\bwhere are we\b|지금[^.\n]{0,20}(?:뭐|무엇|어디|상태|진행|남|멈)|현재[^.\n]{0,20}(?:상태|진행|남)|뭐하고 있|무엇을 하고 있|어디까지|왜 멈|왜 안|남은 게|뭐가 남았|진행 상황|현재 상태)/iu;
if (!statusPromptRe.test(prompt)) process.exit(0);

const staleWarnMs = Math.max(1, Number(process.env.STALE_WARN_SECONDS || "120")) * 1000;
const ackLateMs = Math.max(1, Number(process.env.DISPATCH_ACK_LATE_SECONDS || "30")) * 1000;
const pendingStaleMs = Math.max(1, Number(process.env.PENDING_DISPATCH_STALE_SECONDS || "120")) * 1000;
const nowMs = Date.now();

const readJson = (filePath, fallback = {}) => {
  try {
    const raw = fs.readFileSync(filePath, "utf8").trim();
    return raw ? JSON.parse(raw) : fallback;
  } catch {
    return fallback;
  }
};

const readLines = (filePath) => {
  try {
    return fs.readFileSync(filePath, "utf8").split(/\r?\n/).map((line) => line.trim()).filter(Boolean);
  } catch {
    return [];
  }
};

const normalize = (value) => String(value || "").trim().toLowerCase();

const parseIso = (value) => {
  const ts = Date.parse(String(value || "").trim());
  return Number.isFinite(ts) ? ts : null;
};

const procedureState = readJson(process.env.PROCEDURE_STATE_FILE || "", {});
const focusWorkers = [
  procedureState.lastPendingWorker,
  procedureState.lastClaimedWorker,
  procedureState.lastDispatchWorker,
]
  .map(normalize)
  .filter(Boolean);

const idleRows = readLines(process.env.WORKER_IDLE_NOTICE_FILE || "").map((line) => {
  const [worker = "", reason = "", completedStatus = "", completedTask = ""] = line.split("|");
  return {
    worker: normalize(worker),
    reason: normalize(reason),
    completedStatus: String(completedStatus || "").trim(),
    completedTask: String(completedTask || "").trim(),
  };
});

const latestReports = new Map();
for (const line of readLines(process.env.WORKER_REPORT_LEDGER || "")) {
  let row;
  try {
    row = JSON.parse(line);
  } catch {
    continue;
  }
  const worker = normalize(row.senderName);
  const timestamp = String(row.timestamp || "");
  if (!worker || !timestamp) continue;
  const current = latestReports.get(worker);
  if (!current || timestamp >= current.timestamp) {
    latestReports.set(worker, {
      worker,
      timestamp,
      messageClass: normalize(row.messageClass),
    });
  }
}

const pendingAckRows = readLines(process.env.WORKER_DISPATCH_ACK_PENDING_FILE || "").map((line) => {
  const parts = line.split("|").map((value) => value.trim());
  if (parts.length >= 2) {
    return {
      timestamp: parts[0],
      worker: normalize(parts[1]),
    };
  }
  return { timestamp: "", worker: normalize(parts[0]) };
}).filter((row) => row.worker);

const latestPermissionRequest = (() => {
  const runtimeHomeRoot = String(process.env.RUNTIME_HOME_ROOT || path.dirname(process.env.LOG_DIR || "")).trim();
  const teamsRoot = path.join(runtimeHomeRoot, "teams");
  if (!teamsRoot || !fs.existsSync(teamsRoot)) return null;
  let latest = null;
  for (const entry of fs.readdirSync(teamsRoot, { withFileTypes: true })) {
    if (!entry.isDirectory()) continue;
    const inboxPath = path.join(teamsRoot, entry.name, "inboxes", "team-lead.json");
    if (!fs.existsSync(inboxPath)) continue;
    let rows;
    try {
      rows = JSON.parse(fs.readFileSync(inboxPath, "utf8"));
    } catch {
      continue;
    }
    if (!Array.isArray(rows)) continue;
    for (const row of rows) {
      if (!row || typeof row !== "object") continue;
      let payload;
      try {
        payload = JSON.parse(String(row.text || ""));
      } catch {
        continue;
      }
      if (!payload || payload.type !== "permission_request") continue;
      const worker = normalize(payload.agent_id || payload.agentId || payload.from || row.from);
      const timestamp = String(row.timestamp || payload.timestamp || "");
      if (!worker || !timestamp) continue;
      if (!latest || timestamp >= latest.timestamp) {
        latest = { worker, timestamp };
      }
    }
  }
  return latest;
})();

const focusWorker = (() => {
  for (const worker of focusWorkers) {
    if (worker) return worker;
  }
  const pendingWorker = pendingAckRows[0]?.worker;
  if (pendingWorker) return pendingWorker;
  const idleWorker = idleRows[0]?.worker;
  if (idleWorker) return idleWorker;
  return "";
})();

const idleByWorker = new Map(idleRows.map((row) => [row.worker, row]));
const priorityReason = (reason) => {
  switch (reason) {
    case "working-permission-pending":
      return 1;
    case "standby":
      return 2;
    case "working-blocked":
      return 3;
    case "working-report-missing":
      return 4;
    case "dispatch-pending-no-ack":
      return 5;
    default:
      return 99;
  }
};

const selectedIdle = (() => {
  if (focusWorker && idleByWorker.has(focusWorker)) return idleByWorker.get(focusWorker);
  return [...idleRows].sort((a, b) => priorityReason(a.reason) - priorityReason(b.reason))[0] || null;
})();

const emit = (ctx) => {
  if (ctx) process.stdout.write(ctx);
};

if (selectedIdle) {
  const worker = selectedIdle.worker || "worker";
  switch (selectedIdle.reason) {
    case "working-permission-pending":
      emit(`CTX: runtime-recovery. Status-like turn matches working-permission-pending for ${worker}. Briefly answer current state, then treat the turn as correction: resolve the permission surface first, do not status-probe the worker, do not infer completion from files, and do not ask the user to choose.`);
      process.exit(0);
    case "standby":
      emit(`CTX: runtime-recovery. Status-like turn sees completion-grade output for ${worker}. Briefly answer current state, then treat the worker as standby from that report and read REQUESTED-LIFECYCLE before deciding reuse, shutdown, or hold-for-validation. Keep teardown separate from unrelated dispatch.`);
      process.exit(0);
    case "working-blocked":
      emit(`CTX: runtime-recovery. Status-like turn matches working-blocked for ${worker}. Briefly answer current state, then treat the turn as correction: resolve the blocker or request the smallest needed partial result; do not ask the user to choose and do not infer completion from files.`);
      process.exit(0);
    case "working-report-missing":
      emit(`CTX: runtime-recovery. Status-like turn matches working-report-missing for ${worker}. Briefly answer current state, then treat the turn as correction: bounded status/partial-result SendMessage is valid before replacement. If the next move escalates into redispatch, reroute, or replacement, do same-turn work-planning -> self-verification first. File existence may support artifact-change claims only; it is not handoff/completion evidence.`);
      process.exit(0);
    case "dispatch-pending-no-ack":
      // Prefer the pending-state path below because it can distinguish ack-late vs stale.
      break;
  }
}

const pendingWorker = normalize(procedureState.lastPendingWorker || procedureState.lastDispatchWorker || "");
const pendingAck = pendingAckRows.find((row) => row.worker === pendingWorker) || pendingAckRows[0] || null;
if (normalize(procedureState.teamDispatchState) === "pending" && pendingAck) {
  const sinceMs = parseIso(procedureState.lastPendingSince || procedureState.lastDispatchAt || pendingAck.timestamp);
  const ageMs = sinceMs == null ? null : Math.max(0, nowMs - sinceMs);
  if (ageMs != null && ageMs >= pendingStaleMs) {
    emit(`CTX: runtime-recovery. Status-like turn matches ghost for ${pendingAck.worker}. Briefly answer current state, then treat the turn as correction: same-turn work-planning -> self-verification -> replacement-first on the same WORK-SURFACE. Do not status-probe the unstarted target as the primary action and do not ask the user to choose.`);
    process.exit(0);
  }
  if (ageMs != null && ageMs >= ackLateMs) {
    emit(`CTX: runtime-recovery. Status-like turn matches ack-late for ${pendingAck.worker}. Briefly answer current state, then keep the turn on correction/monitoring logic: report pending/late state only, do not claim the worker started, do not status-probe the unstarted target as the primary action, and do not ask the user to choose.`);
    process.exit(0);
  }
  emit(`CTX: runtime-recovery. Status-like turn sees dispatch-pending for ${pendingAck.worker}. Briefly answer current state from pending evidence only; do not narrate the work as active and do not status-probe the target as if worker-start evidence already exists.`);
  process.exit(0);
}

const claimedWorker = normalize(procedureState.lastClaimedWorker || procedureState.lastDispatchWorker || "");
const latestReport = claimedWorker ? latestReports.get(claimedWorker) : null;
if (latestReport) {
  if (latestReport.messageClass === "blocker") {
    emit(`CTX: runtime-recovery. Status-like turn sees latest worker report 'blocker' from ${claimedWorker}. Briefly answer current state, then treat the turn as correction: resolve the blocker or request the smallest needed partial result; do not ask the user to choose.`);
    process.exit(0);
  }

  if (latestPermissionRequest && latestPermissionRequest.worker === claimedWorker) {
    const permissionMs = parseIso(latestPermissionRequest.timestamp);
    const reportMs = parseIso(latestReport.timestamp);
    const dispatchMs = parseIso(procedureState.lastDispatchAt);
    if ((permissionMs != null) && (dispatchMs == null || permissionMs >= dispatchMs) && (reportMs == null || permissionMs >= reportMs)) {
      emit(`CTX: runtime-recovery. Status-like turn sees working-permission-pending for ${claimedWorker}. Briefly answer current state, then resolve the permission surface first; do not status-probe the worker and do not infer completion from files.`);
      process.exit(0);
    }
  }

  if (["dispatch-ack", "status"].includes(latestReport.messageClass)) {
    const reportMs = parseIso(latestReport.timestamp);
    const ageMs = reportMs == null ? null : Math.max(0, nowMs - reportMs);
    if (ageMs != null && ageMs >= staleWarnMs) {
      emit(`CTX: runtime-recovery. Status-like turn sees an active-stall candidate on ${claimedWorker}: worker-start evidence exists, but the latest upward report (${latestReport.messageClass}) is stale. Briefly answer current state, then bounded status/partial-result SendMessage is valid before replacement. If the next move escalates into replacement or redispatch, do same-turn work-planning -> self-verification first. File existence is not completion evidence.`);
      process.exit(0);
    }
  }
}
NODE
}

# Worker sessions skip prompt-level lead enforcement. Prefer the session
# registry; TMUX naming is only a fallback for contexts without a known id.
if runtime_sender_session_is_worker "$PROMPT_SESSION_ID" || is_worker_session; then
  exit 0
fi

# System-generated prompt follow-ups must not count as fresh user turns.
if is_system_generated_followup_prompt "$USER_PROMPT"; then
  exit 0
fi

# Real user turns reset destructive cleanup approval. A new approval must name
# the exact workspace cleanup root for this turn; stop/cancel wording is
# lifecycle control, not delete approval.
: > "$USER_APPROVED_DELETE_ROOTS_FILE"

USER_DELETE_APPROVAL_ROOTS="$(USER_PROMPT="$USER_PROMPT" PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" WORKSPACE_ROOT="$(resolve_project_root)" node <<'NODE'
const fs = require("fs");
const path = require("path");

const prompt = String(process.env.USER_PROMPT || "");
const normalizedPrompt = prompt.replace(/\\/g, "/");
const promptSearch = normalizedPrompt.toLowerCase();
const deleteIntent = /(\bdelete\b|\bremove\b|삭제\s*(해|해줘|하라|하자|진행|해도\s*돼)|지워\s*(줘|라|버려)?|날려\s*(줘|라|버려)?|초기화\s*(해|해줘|하라)|리셋\s*(해|해줘|하라)|reset\s+it|remove\s+it)/iu.test(prompt);
if (!deleteIntent) process.exit(0);

const statePath = process.env.PROCEDURE_STATE_FILE || "";
const workspaceRoot = path.resolve(process.env.WORKSPACE_ROOT || process.cwd());
let state = {};
try {
  state = JSON.parse(fs.readFileSync(statePath, "utf8"));
} catch {
  state = {};
}

const unique = (values) => [...new Set(values.filter(Boolean))];
const isWorkspaceChild = (candidate) => {
  const relative = path.relative(workspaceRoot, candidate).replace(/\\/g, "/");
  return Boolean(relative) && !relative.startsWith("..") && !path.isAbsolute(relative);
};
const isProtectedRelative = (relativePath) => {
  return (
    relativePath === "." ||
    relativePath === "" ||
    relativePath === ".claude" ||
    relativePath.startsWith(".claude/") ||
    relativePath === ".git" ||
    relativePath.startsWith(".git/") ||
    relativePath === "references" ||
    relativePath.startsWith("references/")
  );
};

const roots = [];
const checkpoints = state && state.checkpointStatus && typeof state.checkpointStatus === "object"
  ? state.checkpointStatus
  : {};
for (const value of Object.values(checkpoints)) {
  if (!value || typeof value !== "object") continue;
  if (typeof value.projectRoot === "string" && value.projectRoot.trim()) {
    roots.push(value.projectRoot.trim());
  }
}

const explicitPathMatches = normalizedPrompt.match(/(?:[a-zA-Z]:)?\/[^\s"'`]+/g) || [];
for (const rawPath of explicitPathMatches) {
  const candidate = path.resolve(rawPath);
  const relative = path.relative(workspaceRoot, candidate).replace(/\\/g, "/");
  if (isWorkspaceChild(candidate) && !isProtectedRelative(relative)) {
    roots.push(candidate);
  }
}

const explicitRelativeMatches = normalizedPrompt.match(/[A-Za-z0-9._-]+(?:\/[A-Za-z0-9._-]+)*/g) || [];
for (const rawRelative of explicitRelativeMatches) {
  const relative = rawRelative.replace(/^\.\/+/, "").replace(/\/+$/, "");
  if (!relative || !/[._/-]/.test(relative)) continue;
  if (relative.includes("..")) continue;
  if (isProtectedRelative(relative)) continue;
  const candidate = path.resolve(workspaceRoot, relative);
  if (isWorkspaceChild(candidate)) {
    roots.push(candidate);
  }
}

try {
  for (const entry of fs.readdirSync(workspaceRoot, { withFileTypes: true })) {
    const name = String(entry.name || "").trim();
    if (!name) continue;
    const relative = name.replace(/\\/g, "/");
    if (isProtectedRelative(relative)) continue;
    if (promptSearch.includes(relative.toLowerCase())) {
      roots.push(path.resolve(workspaceRoot, name));
    }
  }
} catch {}

const approved = [];
for (const root of unique(roots)) {
  const normalizedRoot = root.replace(/\\/g, "/");
  const base = path.basename(normalizedRoot);
  if (!base) continue;
  const resolvedRoot = path.resolve(root);
  const relative = path.relative(workspaceRoot, resolvedRoot).replace(/\\/g, "/");
  if (isProtectedRelative(relative)) continue;
  if (promptSearch.includes(normalizedRoot.toLowerCase()) || promptSearch.includes(base.toLowerCase())) {
    approved.push(resolvedRoot);
  }
}

process.stdout.write(unique(approved).join("\n"));
NODE
)"
if [[ -n "$USER_DELETE_APPROVAL_ROOTS" ]]; then
  printf '%s\n' "$USER_DELETE_APPROVAL_ROOTS" > "$USER_APPROVED_DELETE_ROOTS_FILE"
fi

# ─── SECTION 1: BOOT ENFORCEMENT ────────────────────────────────────────────
BOOT_CONTEXT=""
BOOT_SUPPRESS="false"
DELIVERY_CONTEXT=""

# E-12 fix: Correction pattern detection runs regardless of boot state so that
# self-growth markers are always set when corrections arrive, including during boot.
# Minimal-guidance policy: only explicit self-growth/process-hardening language should
# arm the hard self-growth gate. Ordinary criticism or correction stays "suspected"
# until stronger evidence appears elsewhere in the workflow.
CONFIRMED_CORRECTION_PATTERN="(self[-[:space:]]*growth|self[-[:space:]]*growth[-[:space:]]*sequence|behavior(al)?[[:space:]]+defect|procedural[[:space:]]+defect|process[[:space:]]+failure|self[-[:space:]]*improvement|change[-[:space:]]*sequence|재발[[:space:]]*방지|자기[[:space:]]*성장|셀프[[:space:]]*그로스|행동[[:space:]]*결함|절차[[:space:]]*결함)"
CORRECTION_PATTERN="((너|네|니)[[:space:]]*잘못(했|됐|된|한)?|틀렸|틀린|(네|너|니)[[:space:]]*(오류|실수)|왜[[:space:]]*(이런|그런|또)[[:space:]]*(오류|실수)|하지[[:space:]]*말|또[[:space:]]*(같은[[:space:]]*)?(실수|문제|오류)|안[[:space:]]*된다고[[:space:]]*(했|말했|했잖)|그게[[:space:]]*아니|규정[[:space:]]*무시|절차[[:space:]]*무시|규정[[:space:]]*위반|절차[[:space:]]*위반|(네|너|니)[[:space:]]*(오류|실수)|you.*wrong|wrong.*again|your mistake|that.s a mistake|you shouldn.t|not like that|you missed|don.t do|why did you (ignore|skip|miss|forget|not))"
if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$CONFIRMED_CORRECTION_PATTERN" 2>/dev/null; then
  if [[ -n "$PROMPT_SESSION_ID" ]]; then
    mark_self_growth_required "$PROMPT_SESSION_ID"
  fi
  BOOT_CONTEXT="CTX: self-growth-required. Next: Skill(self-growth-sequence) before consequential fan-out."
elif printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$CORRECTION_PATTERN" 2>/dev/null; then
  if [[ -n "$PROMPT_SESSION_ID" ]]; then
    mark_self_growth_suspected "$PROMPT_SESSION_ID"
  fi
  BOOT_CONTEXT="CTX: user-challenge-observed. Treat the prompt as evidence to evaluate, not proof of defect. Preserve prior verified conclusions unless direct evidence or governing rules overturn them. If a real behavioral defect is confirmed, then enter self-growth; otherwise answer the current request from verified evidence."
fi

DELIVERY_INCIDENT_PATTERN="(double[-[:space:]]*click|더블클릭|start[._-]?bat|start[._-]?sh|launcher|아이콘|실행[^.]{0,20}(안[[:space:]]*돼|안돼|안됨|실패)|안[[:space:]]*열리|won.t[[:space:]]+launch|doesn.t[[:space:]]+launch|launch[[:space:]]+fail)"
BURDEN_SHIFT_PROMPT_PATTERN="(내[[:space:]]*손이[[:space:]]*가|더블클릭만|hands[-[:space:]]*off|low[-[:space:]]*touch|cmd|powershell|terminal|명령[[:space:]]*(프롬프트|입력)|터미널|삭제[[:space:]]*후|node_modules|\\.next)"

if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$DELIVERY_INCIDENT_PATTERN" 2>/dev/null; then
  DELIVERY_CONTEXT="CTX: delivery-incident-reopen. Treat reported user-run-path failure as an acceptance blocker reopen. Next: verify on the promised user run path, remediate hands-off in the product or launcher, and keep the task open until run-path proof is re-established."
fi

if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$DELIVERY_INCIDENT_PATTERN" 2>/dev/null \
  && printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$BURDEN_SHIFT_PROMPT_PATTERN" 2>/dev/null; then
  if [[ -n "$PROMPT_SESSION_ID" ]]; then
    mark_self_growth_required "$PROMPT_SESSION_ID"
  fi
  DELIVERY_CONTEXT="CTX: self-owned-remediation-required. A promised hands-off delivery path failed and the user is being pulled into recovery steps. Reopen acceptance, keep remediation agent-owned, and enter self-growth before consequential follow-on."
fi

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
  BOOT_STARTUP_STATE="$(get_procedure_state_field "startupState" "")"
  if [[ "$BOOT_STARTUP_STATE" == "ready" ]]; then
    printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
  else
    BOOT_CONTEXT="CTX: boot-required. Next: Skill(session-boot) before task-level work."
    BOOT_SUPPRESS="true"
  fi
fi

# ─── SECTION 2: CLOSEOUT INTENT SYNC + TASK-START PLANNING REMINDER ─────────
CLOSEOUT_CONTEXT=""
CLOSEOUT_SUPPRESS="false"
PLANNING_CONTEXT=""
RECOVERY_CONTEXT=""
CLOSEOUT_ACTION="$(USER_PROMPT="$USER_PROMPT" \
  EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN="${EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN:-}" \
  CLOSEOUT_CANCEL_PROMPT_JS_PATTERN="${CLOSEOUT_CANCEL_PROMPT_JS_PATTERN:-}" \
  NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN="${NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN:-}" \
  node <<'NODE'
try {
  const prompt = process.env.USER_PROMPT || "";
  const closeoutRe = new RegExp(process.env.EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN || "^$", "iu");
  const cancelRe = new RegExp(process.env.CLOSEOUT_CANCEL_PROMPT_JS_PATTERN || "^$", "iu");
  const nonExecRe = new RegExp(process.env.NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN || "^$", "iu");
  let action = "none";
  if (prompt) {
    if (cancelRe.test(prompt)) {
      action = "clear";
    } else if (closeoutRe.test(prompt) && !nonExecRe.test(prompt)) {
      action = "set";
    }
  }
  process.stdout.write(action);
} catch {
  process.stdout.write("none");
}
NODE
)"

case "$CLOSEOUT_ACTION" in
  set)
    clear_lead_planning_required "$PROMPT_SESSION_ID"
    set_closeout_intent "$USER_PROMPT_CLOSEOUT_INTENT_REASON" "user-prompt" "intent_marked" "$PROMPT_SESSION_ID"
    CLOSEOUT_CONTEXT="CTX: closeout-active. Next: Skill(session-closeout) first; keep cleanup inside Closeout Sequence."
    CLOSEOUT_SUPPRESS="true"
    ;;
  clear)
    if closeout_intent_is_active "$PROMPT_SESSION_ID"; then
      clear_closeout_intent "user-prompt-closeout-cancelled" "$PROMPT_SESSION_ID"
    fi
    CLOSEOUT_CONTEXT="CTX: closeout-cleared. Remain in normal monitoring mode until a new explicit end-of-session instruction."
    CLOSEOUT_SUPPRESS="true"
    ;;
esac

if [[ -n "$PROMPT_SESSION_ID" ]] && [[ "$CLOSEOUT_ACTION" != "set" ]] && ! is_system_generated_followup_prompt "$USER_PROMPT"; then
  mark_lead_planning_required "$PROMPT_SESSION_ID"
  PLANNING_CONTEXT="CTX: fresh-turn-preflight. First classify whether this is an SV-only audit: if the turn only asks to audit or self-verify an already-frozen synthesized conclusion, the first skill is Skill('self-verification'); do not re-open work-planning unless scope changes or execution resumes. If an SV-only audit later pivots into execution, dispatch, runtime setup, or mutation, pivot immediately to Skill('work-planning') -> Skill('self-verification') before Agent, TaskCreate, assignment-grade SendMessage, or mutable Bash. Skill('task-execution') may load during that pivot for routing/tier classification, but TeamCreate still waits for observed current-turn work-planning; neither replaces the current-turn dispatch gate. Read-only inspection is evidence gathering only; it does not authorize defect classification, severity/priority judgment, closure-grade audit findings, final user-facing diagnosis, reporting, dispatch, or mutation. Already-reviewed changes may use work-planning only to freeze the current-turn mutation scope. Before observed TeamCreate/Agent/assignment evidence, describe only the next action, not dispatch as already done."
  RECOVERY_CONTEXT="$(status_runtime_recovery_context "$USER_PROMPT")"
fi

# ─── OUTPUT ──────────────────────────────────────────────────────────────────
COMBINED_CONTEXT="$BOOT_CONTEXT"
if [[ -n "$CLOSEOUT_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $CLOSEOUT_CONTEXT"
  else
    COMBINED_CONTEXT="$CLOSEOUT_CONTEXT"
  fi
fi
if [[ -n "$RECOVERY_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $RECOVERY_CONTEXT"
  else
    COMBINED_CONTEXT="$RECOVERY_CONTEXT"
  fi
fi
if [[ -n "$PLANNING_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $PLANNING_CONTEXT"
  else
    COMBINED_CONTEXT="$PLANNING_CONTEXT"
  fi
fi
if [[ -n "$DELIVERY_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $DELIVERY_CONTEXT"
  else
    COMBINED_CONTEXT="$DELIVERY_CONTEXT"
  fi
fi

[[ -n "$COMBINED_CONTEXT" ]] || exit 0

SUPPRESS_OUTPUT="false"
[[ "$BOOT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"
[[ "$CLOSEOUT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"

ADDITIONAL_CONTEXT="$COMBINED_CONTEXT" SUPPRESS_OUTPUT="$SUPPRESS_OUTPUT" node -e "
const ctx = process.env.ADDITIONAL_CONTEXT || '';
const suppress = process.env.SUPPRESS_OUTPUT === 'true';
const out = {hookSpecificOutput:{hookEventName:'UserPromptSubmit',additionalContext:ctx}};
if (suppress) out.suppressOutput = true;
process.stdout.write(JSON.stringify(out));
"
