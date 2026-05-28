#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config-core.sh"

INPUT="$(cat)"

# PermissionRequest is the narrow place where Claude Code asks the operator for
# protected self-edit approval. Keep this hook smaller than the governance
# doctrine: it only removes repeat prompts for structured Edit/MultiEdit changes to non-protected
# document surfaces that the normal PreToolUse gates have already allowed.
RESULT="$(INPUT_JSON="$INPUT" WORKSPACE_ROOT="$(resolve_project_root)" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const fs = require("fs");
const path = require("path");

const emit = (behavior) => {
  if (behavior !== "allow" && behavior !== "deny") {
    return;
  }
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
  if (toolName === "Edit") {
    return (
      typeof toolInput.old_string === "string" ||
      typeof toolInput.new_string === "string" ||
      typeof toolInput.oldString === "string" ||
      typeof toolInput.newString === "string"
    );
  }

  if (toolName === "MultiEdit") {
    return Array.isArray(toolInput.edits) && toolInput.edits.length > 0;
  }

  return false;
};

const collectEditTextFragments = (toolName, toolInput) => {
  const fragments = [];
  const add = (value) => {
    if (typeof value === "string" && value) fragments.push(value);
  };

  add(toolInput.old_string);
  add(toolInput.new_string);
  add(toolInput.oldString);
  add(toolInput.newString);

  if (toolName === "MultiEdit" && Array.isArray(toolInput.edits)) {
    for (const edit of toolInput.edits) {
      if (edit && typeof edit === "object") {
        add(edit.old_string);
        add(edit.new_string);
        add(edit.oldString);
        add(edit.newString);
      }
    }
  }

  return fragments;
};

const touchesProtectedRoleCurtainContent = (toolName, toolInput) => {
  const protectedRolePattern =
    /PROTECTED-CURTAIN-SURFACE|Curtained Communication|IR-3|Constitutional Reporting Curtain|reporting curtain|reporting-prohibition/i;
  return collectEditTextFragments(toolName, toolInput).some((fragment) =>
    protectedRolePattern.test(fragment)
  );
};

const safeRelativeDocSurface = (relativePath) => {
  const rel = relativePath.replace(/\\/g, "/");
  if (rel === ".claude/CLAUDE.md") return true;
  if (/^\.claude\/agents\/[^/]+\.md$/.test(rel)) return true;
  if (/^\.claude\/reference\/[^/]+\.md$/.test(rel)) return true;
  if (/^\.claude\/skills\/[^/]+\/SKILL\.md$/.test(rel)) return true;
  if (/^\.claude\/skills\/[^/]+\/references\/[^/]+\.md$/.test(rel)) return true;
  return false;
};

// PermissionRequest auto-allow stays conservative for protected surfaces. This
// helper returns to host/manual handling only for enumerated protected files or
// role-file edits whose actual Edit/MultiEdit text touches protected curtain
// role content. It is not an instruction for the assistant to ask the user;
// the assistant continues any non-conflicting internal work while the host owns
// the protected permission surface.
const manualPermissionFallbackGovernanceSurface = (relativePath, protectedRoleContentTouched) => {
  const rel = relativePath.replace(/\\/g, "/");
  if (rel === ".claude/CLAUDE.md") return true;
  if (rel === ".claude/reference/reporting-core-law.md") return true;
  if (rel === ".claude/reference/reporting-prohibition-law.md") return true;
  if (rel === ".claude/reference/modification-core-law.md") return true;
  if (rel === ".claude/reference/review-and-verification-core-law.md") return true;
  if (/^\.claude\/agents\/[^/]+\.md$/.test(rel)) return protectedRoleContentTouched;
  return false;
};

const safeRelativeOperationalSurface = (relativePath, toolName) => {
  const rel = relativePath.replace(/\\/g, "/");
  if (rel === ".runtime/procedure-state.json") {
    return toolName === "Edit" || toolName === "MultiEdit";
  }
  return false;
};

try {
  const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
  const input = parseInput();
  const toolName = String(input.tool_name || input.toolName || "");
  const toolInput = input.tool_input || input.toolInput || input.input || {};

  if (!["Edit", "MultiEdit"].includes(toolName)) {
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

  const protectedRoleContentTouched = touchesProtectedRoleCurtainContent(toolName, toolInput);
  for (const relative of resolvedRelatives) {
    if (manualPermissionFallbackGovernanceSurface(relative, protectedRoleContentTouched)) {
      emit(null);
      process.exit(0);
    }
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
