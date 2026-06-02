#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
let input = {};
try {
  input = JSON.parse(process.env.INPUT_JSON || "{}");
} catch {
  process.stdout.write(["pass", ""].map((value) => Buffer.from(String(value || ""), "utf8").toString("base64")).join("\n"));
  process.exit(0);
}
const toolName = String(input.tool_name || "");
const toolInput = input.tool_input && typeof input.tool_input === "object" ? input.tool_input : {};
const tokens = new Set(["dispatch-ack", "scope-pressure", "hold|blocker", "subjob-done"]);
const reminder = [
  "REPORTING-CURTAIN-SPINE:",
  "Consume .claude/reference/reporting-curtain-spine.md for this worker-to-lead state signal.",
  "State signals render exactly one token in SendMessage.summary; message is omitted or one ASCII space.",
  "Escalate to full reporting-prohibition only if a user-facing report reason is being considered."
].join("\n");

function firstString(...values) {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
}

function textOf(value) {
  if (value == null) return "";
  if (typeof value === "string") return value;
  if (typeof value === "number" || typeof value === "boolean") return String(value);
  if (Array.isArray(value)) return value.map(textOf).join("\n");
  if (typeof value === "object") return Object.values(value).map(textOf).join("\n");
  return "";
}

function cleanText(value) {
  return textOf(value).replace(/\r\n?/g, "\n");
}

function normalizedOneLine(value) {
  return cleanText(value).trim().replace(/\s+/g, " ").toLowerCase();
}

function encode(value) {
  return Buffer.from(String(value || ""), "utf8").toString("base64");
}

if (toolName !== "SendMessage") {
  process.stdout.write(["pass", ""].map(encode).join("\n"));
  process.exit(0);
}

const target = firstString(
  toolInput.to,
  toolInput.recipient,
  toolInput.recipient_name,
  toolInput.recipientName,
  toolInput.target_name,
  toolInput.targetName
).toLowerCase();

if (target !== "team-lead") {
  process.stdout.write(["pass", ""].map(encode).join("\n"));
  process.exit(0);
}

const summary = normalizedOneLine(toolInput.summary);
const messageRaw = cleanText(toolInput.message);
const message = messageRaw.trim().replace(/\s+/g, " ").toLowerCase();
const hasMessageField = Object.prototype.hasOwnProperty.call(toolInput, "message");
const messageHasVisibleText = hasMessageField && messageRaw.trim().length > 0;

if (tokens.has(summary)) {
  if (messageHasVisibleText) {
    const updated = {...toolInput, summary, message: " "};
    process.stdout.write(["update", summary, JSON.stringify(updated), reminder].map(encode).join("\n"));
    process.exit(0);
  }
  process.stdout.write(["context", summary, "", reminder].map(encode).join("\n"));
  process.exit(0);
}

if (!summary && tokens.has(message)) {
  const updated = {...toolInput, summary: message, message: " "};
  process.stdout.write(["update", message, JSON.stringify(updated), reminder].map(encode).join("\n"));
  process.exit(0);
}

for (const token of tokens) {
  const escaped = token.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const visibleStatePrefix = new RegExp(`^${escaped}(?:[\\s:;,.#_-]|$)`);
  if (!summary && visibleStatePrefix.test(message)) {
    const updated = {...toolInput, summary: token, message: " "};
    process.stdout.write(["update", token, JSON.stringify(updated), reminder].map(encode).join("\n"));
    process.exit(0);
  }
}

process.stdout.write(["pass", ""].map(encode).join("\n"));
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
DECISION="$(hook_decode_base64_field "${FIELDS[0]:-}")"
TOKEN="$(hook_decode_base64_field "${FIELDS[1]:-}")"
UPDATED_INPUT="$(hook_decode_base64_field "${FIELDS[2]:-}")"
ADDITIONAL_CONTEXT="$(hook_decode_base64_field "${FIELDS[3]:-}")"

case "$DECISION" in
  update)
    UPDATED_INPUT="$UPDATED_INPUT" ADDITIONAL_CONTEXT="$ADDITIONAL_CONTEXT" node <<'NODE'
const updatedInput = JSON.parse(process.env.UPDATED_INPUT || "{}");
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "allow",
    updatedInput,
    additionalContext: process.env.ADDITIONAL_CONTEXT || ""
  }
}));
NODE
    ;;
  context)
    ADDITIONAL_CONTEXT="$ADDITIONAL_CONTEXT" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    additionalContext: process.env.ADDITIONAL_CONTEXT || ""
  }
}));
NODE
    ;;
esac
