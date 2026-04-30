#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config-core.sh"

INPUT="$(cat)"

# PermissionRequest is the narrow place where Claude Code asks the operator for
# protected self-edit approval. Keep this hook smaller than the governance
# doctrine: it only removes repeat prompts for structured edits to document
# surfaces that the normal PreToolUse gates have already allowed.
RESULT="$(INPUT_JSON="$INPUT" WORKSPACE_ROOT="$(resolve_project_root)" node <<'NODE'
const fs = require("fs");
const path = require("path");

const emit = (behavior) => {
  const output = {
    hookSpecificOutput: {
      hookEventName: "PermissionRequest",
      decision: {
        behavior,
        updatedInput: null,
      },
    },
  };
  process.stdout.write(JSON.stringify(output));
};

const flattenPaths = (toolName, toolInput) => {
  const paths = [];
  const addPath = (value) => {
    if (typeof value === "string" && value.trim()) paths.push(value.trim());
  };

  addPath(toolInput.file_path);
  addPath(toolInput.filePath);
  addPath(toolInput.path);

  if (Array.isArray(toolInput.edits)) {
    for (const edit of toolInput.edits) {
      if (edit && typeof edit === "object") {
        addPath(edit.file_path);
        addPath(edit.filePath);
        addPath(edit.path);
      }
    }
  }

  if (toolName === "MultiEdit" && paths.length === 0) {
    addPath(toolInput.file_path);
    addPath(toolInput.filePath);
    addPath(toolInput.path);
  }

  return [...new Set(paths)];
};

const hasAllowedEditShape = (toolName, toolInput) => {
  if (toolName === "Edit" || toolName === "Update") {
    return (
      typeof toolInput.old_string === "string" ||
      typeof toolInput.new_string === "string" ||
      typeof toolInput.oldString === "string" ||
      typeof toolInput.newString === "string" ||
      typeof toolInput.update === "string" ||
      typeof toolInput.patch === "string"
    );
  }

  if (toolName === "MultiEdit") {
    return Array.isArray(toolInput.edits) && toolInput.edits.length > 0;
  }

  if (toolName === "Write") {
    return typeof toolInput.content === "string" || typeof toolInput.text === "string";
  }

  return false;
};

const safeRelativeDocSurface = (relativePath) => {
  const rel = relativePath.replace(/\\/g, "/");
  if (rel === ".claude/CLAUDE.md") return true;
  if (/^\.claude\/agents\/[^/]+\.md$/.test(rel)) return true;
  if (/^\.claude\/rules\/[^/]+\.md$/.test(rel)) return true;
  if (/^\.claude\/skills\/[^/]+\/SKILL\.md$/.test(rel)) return true;
  return false;
};

const safeRelativeOperationalSurface = (relativePath, toolName) => {
  const rel = relativePath.replace(/\\/g, "/");
  if (rel === ".runtime/procedure-state.json") {
    return toolName === "Edit" || toolName === "Update" || toolName === "MultiEdit";
  }
  if (rel === ".claude/session-state.md") {
    return toolName === "Edit" || toolName === "Update" || toolName === "MultiEdit" || toolName === "Write";
  }
  return false;
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || input.toolName || "");
  const toolInput = input.tool_input || input.toolInput || input.input || {};

  if (!["Edit", "Update", "MultiEdit", "Write"].includes(toolName)) {
    emit(null);
    process.exit(0);
  }

  const workspaceRoot = path.resolve(process.env.WORKSPACE_ROOT || process.cwd());
  const paths = flattenPaths(toolName, toolInput);
  if (paths.length === 0) {
    emit(null);
    process.exit(0);
  }

  const resolvedRelatives = [];
  for (const rawPath of paths) {
    const resolved = path.resolve(workspaceRoot, rawPath);
    let canonical = resolved;
    try {
      canonical = fs.realpathSync.native(resolved);
    } catch {
      canonical = resolved;
    }

    const relative = path.relative(workspaceRoot, canonical).replace(/\\/g, "/");
    if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) {
      emit(null);
      process.exit(0);
    }

    resolvedRelatives.push(relative);
  }

  const allOperational = resolvedRelatives.every((relative) =>
    safeRelativeOperationalSurface(relative, toolName)
  );
  if (allOperational) {
    emit("allow");
    process.exit(0);
  }

  if (!hasAllowedEditShape(toolName, toolInput)) {
    emit(null);
    process.exit(0);
  }

  for (const relative of resolvedRelatives) {
    if (!safeRelativeDocSurface(relative) && !safeRelativeOperationalSurface(relative, toolName)) {
      emit(null);
      process.exit(0);
    }
  }

  emit("allow");
} catch (error) {
  emit(null);
}
NODE
)"

printf '%s' "$RESULT"

if [[ "$RESULT" == *'"behavior":"allow"'* ]]; then
  mkdir -p "$(dirname "$PERMISSION_REQUEST_LOG")" 2>/dev/null || true
  printf '[%s] PERMISSION-REQUEST auto-allow: bounded governance or continuity surface edit\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$PERMISSION_REQUEST_LOG" 2>/dev/null || true
fi
