#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT_FILE="$(mktemp "${LOG_DIR:-/tmp}/reporting-curtain-input.XXXXXX")"
trap 'rm -f "$INPUT_FILE"' EXIT
cat > "$INPUT_FILE"

HOOK_INPUT_FILE="$INPUT_FILE" node <<'NODE'
const fs = require("fs");
let input = {};
try {
  input = JSON.parse(fs.readFileSync(process.env.HOOK_INPUT_FILE || "/dev/stdin", "utf8") || "{}");
} catch {
  process.exit(0);
}

const eventName = String(input.hook_event_name || "");
const toolName = String(input.tool_name || "");
const toolUseId = String(input.tool_use_id || input.toolUseId || Date.now());
const prompt = String(input.prompt || "").replace(/\s+/g, " ").trim();
const agentType = String(input.agent_type || input.agentType || "").trim().toLowerCase();
const toolInput = input.tool_input && typeof input.tool_input === "object" ? input.tool_input : {};
const rawSkill = String(toolInput.skill || "").trim();
const rawPath = String(toolInput.file_path || toolInput.path || toolInput.notebook_path || "").trim();

const highRiskPrompt = /(보고\s*금지|보고|렌더|랜더|출력|중복|dispatch-ack|subjob-done|scope-pressure|hold\|blocker|거버넌스|governance|agent|에이전트|team|팀|audit|조사|검토|패치|hook|훅)/iu.test(prompt);
const governedAgent = /^(team-lead|reviewer|researcher|developer|tester|validator)$/.test(agentType);
const skillName = rawSkill
  .toLowerCase()
  .replace(/\\/g, "/")
  .replace(/^.*\/skills\/([^/]+)\/skill\.md$/, "$1")
  .replace(/^.*\/skills\/([^/]+)\/?$/, "$1")
  .replace(/^skill:/, "")
  .replace(/^@/, "")
  .replace(/[^a-z0-9._-]+/g, "-")
  .replace(/^-+|-+$/g, "");
const reportingSensitiveSkill = /^(agent-team-lead|session-boot|work-planning|task-execution|review-verification)$/.test(skillName);
const taskExecutionReferenceRead =
  eventName === "PostToolUse" &&
  toolName === "Read" &&
  /(?:^|\/)\.claude\/skills\/task-execution\//.test(rawPath.replace(/\\/g, "/"));
const reportingRelevantTools = new Set([
  "Read", "Grep", "Glob", "LS", "TaskGet", "TaskList", "TaskOutput",
  "Bash", "Edit", "MultiEdit", "Write", "NotebookEdit",
  "Skill", "Agent", "TeamCreate", "TeamDelete",
  "TaskCreate", "TaskUpdate", "TaskStop", "SendMessage"
]);

function toolNameOf(value) {
  if (!value || typeof value !== "object") return "";
  return String(value.tool_name || value.toolName || value.name || value.tool || "").trim();
}

function batchToolNames() {
  const candidates = [];
  for (const key of ["tool_calls", "toolCalls", "tools", "calls"]) {
    const value = input[key];
    if (!Array.isArray(value)) continue;
    for (const item of value) {
      const name = toolNameOf(item);
      if (name) candidates.push(name);
    }
  }
  return candidates;
}

function shellQuote(value) {
  return "'" + String(value).replace(/'/g, "'\\''") + "'";
}

function safeId(value) {
  const cleaned = String(value || Date.now()).replace(/[^A-Za-z0-9._-]+/g, "-").replace(/^-+|-+$/g, "");
  return cleaned || String(Date.now());
}

function bashInternalCaptureCandidate(command) {
  if (eventName !== "PreToolUse" || toolName !== "Bash") return false;
  if (toolInput.run_in_background === true || toolInput.runInBackground === true) return false;
  const text = String(command || "");
  if (!text.trim()) return false;
  if (/\btmux\s+kill(?:-|\s)/i.test(text)) return false;
  if (/\brm\s+-[^\n;]*r[^\n;]*f\b/i.test(text)) return false;
  const internalSurface = /(?:^|[\s"'=;:])(?:\.claude|claude_doc|\.runtime|\/mnt\/d\/Agent_team\/(?:\.claude|claude_doc|\.runtime))\b/i.test(text);
  const stdoutProducer = /\b(find|rg|grep|ls|cat|head|tail|wc|sed|awk|echo|printf)\b/i.test(text);
  const stdoutAlreadyRedirected = /(?:^|[^0-9])(?:1?>|&>)/.test(text);
  return internalSurface && stdoutProducer && !stdoutAlreadyRedirected;
}

function capturedBashInput(command) {
  const id = safeId(toolUseId);
  const dir = ".runtime/reporting-curtain";
  const out = `${dir}/${id}.stdout`;
  const err = `${dir}/${id}.stderr`;
  const encoded = Buffer.from(String(command || ""), "utf8").toString("base64");
  const wrapper = [
    `__gov_dir=${shellQuote(dir)}`,
    `__gov_out=${shellQuote(out)}`,
    `__gov_err=${shellQuote(err)}`,
    `__gov_cmd_b64=${shellQuote(encoded)}`,
    `mkdir -p "$__gov_dir"`,
    `bash -lc "$(printf '%s' "$__gov_cmd_b64" | base64 -d)" >"$__gov_out" 2>"$__gov_err"`
  ].join("; ");
  return {
    updatedInput: {
      ...toolInput,
      command: wrapper,
      description: toolInput.description || "Capture internal evidence stdout/stderr to governed files"
    },
    capture: {out, err}
  };
}

function continuationLines(target) {
  if (target === "TeammateIdle") {
    return [
      "Immediate next-continuation rule: after teammate idle, dispatch-ack, or subjob-done display, proceed silently with retained-carrier acceptance, reuse/redispatch, monitoring, synthesis, blocker routing, or final admitted answer.",
      "Waiting/resume/hold prose such as 'I'll wait...', 'I'll hold...', 'I'll pause...', or 'I'll resume...' has REPORT-REASON:none while any lane completion, reuse, monitoring, or dispatch owner action remains open."
    ];
  }
  if (/^(Skill\(task-execution\)|PostToolUse(?:Failure)?\(Skill:task-execution\)|PostToolUse\(Read:task-execution-reference\))$/.test(target)) {
    return [
      "Immediate next-continuation rule: this is a task-execution continuation boundary; the next assistant-authored surface is a tool call, corrected transport, retained non-rendered carrier move, blocker route, final admitted answer, or empty body.",
      "The exact next-sentence class 'Materializing...', 'fetching...', 'creating...', 'verifying...', 'dispatching...', 'opening...', or 'awaiting...' about binding surfaces, runtime schemas, carriers, teams, lanes, reads, or dispatch has REPORT-REASON:none."
    ];
  }
  if (target.startsWith("PostToolUse(") || target.startsWith("PostToolUseFailure(") || target === "PostToolBatch") {
    return [
      "Immediate next-continuation rule: after this tool result or tool batch, proceed with the next governed tool/action silently unless the exact next sentence is an admitted final/status/blocker/closeout answer.",
      "Tool-result interpretation, path choice, measurement, setup, verification, and transition wording has REPORT-REASON:none."
    ];
  }
  return [];
}

function startupOrderLines(target) {
  if (eventName !== "SessionStart" || target !== "team-lead") return [];
  return [
    "Startup owner-order reminder: after the team-lead Startup Contract records REPORTING-BASIS, load Skill(agent-team-lead) and Skill(session-boot) before Skill(work-planning) or other lead-owned procedure movement.",
    "Hook startupState, boot-complete, or clean-session-start markers are runtime evidence only; they do not satisfy Skill(session-boot) load-and-learn."
  ];
}

function contextFor(target, capture) {
  const lines = [
    "REPORTING-CURTAIN-SPINE:",
    `Target owner: ${target}.`,
    "Consume .claude/reference/reporting-curtain-spine.md for routine suppression.",
    "Renderable-candidate test: before any assistant-authored visible sentence, classify REPORT-REASON for that exact sentence; if it is not final verified result, current explicit status answer, proven user-action blocker, or closeout residual, render no prose.",
    "Routine internal progress, skill-loaded/ready/review/opening/waiting, dispatch, monitoring, carrier, and verification facts render nothing; execute the next governed action silently.",
    "Forbidden routine-prose examples: I have..., Let me..., The Critical Review Gate surfaced..., Binding surface..., Team runtime active..., Dispatching..., Awaiting..., or any measurement/path-choice/retry narration.",
    "A host-rendered tool row, skill-loaded row, file-read row, captured Bash path, or tool failure row creates no adjacent prose slot.",
    "Worker state signals use exactly one SendMessage.summary token: dispatch-ack, scope-pressure, hold|blocker, or subjob-done; SendMessage.message is omitted or one ASCII space.",
    "Escalate to .claude/reference/reporting-prohibition-law.md only for final/status/user-blocker/closeout, exact internal material requested by the user, uncertain admission, or reporting/governance defect claims.",
    "Load .claude/reference/reporting-user-reporting-law.md only after reporting-prohibition admits the exact report reason."
  ];
  lines.splice(3, 0, ...startupOrderLines(target), ...continuationLines(target));
  if (capture) {
    lines.push(`Current Bash stdout/stderr was redirected to ${capture.out} and ${capture.err}; treat those files as internal evidence only and continue without path-choice or capture narration.`);
  }
  return lines.join("\n");
}

let shouldInject = false;
let shouldUpdate = false;
let target = "";
let updatedInput = null;
let capture = null;
const batchRelevant = batchToolNames().some((name) => reportingRelevantTools.has(name));
const currentToolRelevant = reportingRelevantTools.has(toolName);
const command = String(toolInput.command || "");

if (bashInternalCaptureCandidate(command)) {
  const updated = capturedBashInput(command);
  shouldInject = true;
  shouldUpdate = true;
  updatedInput = updated.updatedInput;
  capture = updated.capture;
  target = "PreToolUse(Bash)";
} else if (eventName === "SubagentStart" && governedAgent) {
  shouldInject = true;
  target = agentType;
} else if (eventName === "UserPromptSubmit" && highRiskPrompt) {
  shouldInject = true;
  target = "team-lead";
} else if (eventName === "SessionStart" && governedAgent) {
  shouldInject = true;
  target = agentType;
} else if (eventName === "PreToolUse" && toolName === "Skill" && reportingSensitiveSkill) {
  shouldInject = true;
  target = `Skill(${skillName})`;
} else if ((eventName === "PostToolUse" || eventName === "PostToolUseFailure") && toolName === "Skill" && reportingSensitiveSkill) {
  shouldInject = true;
  target = `${eventName}(Skill:${skillName})`;
} else if (taskExecutionReferenceRead) {
  shouldInject = true;
  target = "PostToolUse(Read:task-execution-reference)";
} else if (eventName === "PostToolBatch" && batchRelevant) {
  shouldInject = true;
  target = "PostToolBatch";
} else if (eventName === "TeammateIdle") {
  shouldInject = true;
  target = "TeammateIdle";
} else if ((eventName === "PostToolUse" || eventName === "PostToolUseFailure") && currentToolRelevant) {
  shouldInject = true;
  target = `${eventName}(${toolName})`;
}

if (!shouldInject) {
  process.exit(0);
}

const hookSpecificOutput = {
  hookEventName: eventName,
  additionalContext: contextFor(target, capture)
};

if (shouldUpdate) {
  hookSpecificOutput.permissionDecision = "allow";
  hookSpecificOutput.updatedInput = updatedInput;
}

process.stdout.write(JSON.stringify({hookSpecificOutput}));
NODE
