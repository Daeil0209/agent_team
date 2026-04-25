# Governance-restricted .claude/ file rm carve-out — split out of compliance-supervisor.sh
# to keep that file compact and to reuse the existing $USER_APPROVED_DELETE_ROOTS_FILE
# marker pattern.
#
# Allows narrow single-file rm of governance-restricted .claude/ surfaces
# (hooks/, agents/, rules/, CLAUDE.md, settings*.json) when the target is
# explicitly listed in $USER_APPROVED_DELETE_ROOTS_FILE.
#
# Strictly single-file: no recursion, no globs, no compound, no pipe/redirect/
# quote-escape, no command substitution. Complements
# command_is_narrow_nonrestricted_claude_file_rm (which forbids governance-
# restricted subpaths) and user_approved_delete_subcommand (which forbids
# .claude/ targets).

command_is_governance_restricted_file_rm_with_approval() {
  local cmd="${1-}"
  [[ -n "$cmd" && -s "$USER_APPROVED_DELETE_ROOTS_FILE" ]] || return 1
  printf '%s' "$cmd" | grep -qE '\||`|\$\(|>|<|&&|;|&' && return 1

  COMMAND_TEXT="$cmd" \
  APPROVED_ROOTS_FILE="$USER_APPROVED_DELETE_ROOTS_FILE" \
  WORKSPACE_ROOT="$(resolve_project_root)" \
  node <<'NODE'
const fs = require("fs");
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const rootsFile = String(process.env.APPROVED_ROOTS_FILE || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";
  for (let i = 0; i < text.length; i += 1) {
    const ch = text[i];
    if (quote) {
      if (ch === quote) quote = "";
      else if (ch === "\\" && quote === '"' && i + 1 < text.length) current += text[++i];
      else current += ch;
      continue;
    }
    if (ch === '"' || ch === "'") { quote = ch; continue; }
    if (/\s/.test(ch)) {
      if (current) { words.push(current); current = ""; }
      continue;
    }
    current += ch;
  }
  if (quote) return null;
  if (current) words.push(current);
  return words;
}

if (!command.trim() || /[|;&<>`$*?[\]{}]/.test(command)) process.exit(1);

const words = tokenize(command);
if (!words || words.length < 2 || words[0] !== "rm") process.exit(1);

const targets = [];
for (let i = 1; i < words.length; i += 1) {
  const word = words[i];
  if (word === "--") continue;
  if (word.startsWith("-")) {
    if (!/^-f$/.test(word)) process.exit(1);
    continue;
  }
  targets.push(path.resolve(word));
}
if (targets.length !== 1) process.exit(1);

const target = targets[0];
const relative = path.relative(workspaceRoot, target).replace(/\\/g, "/");
if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) process.exit(1);
if (!relative.startsWith(".claude/")) process.exit(1);
if (relative === ".claude" || relative === ".claude/") process.exit(1);

let stat;
try { stat = fs.lstatSync(target); } catch { process.exit(1); }
if (!stat.isFile()) process.exit(1);

let approved = [];
try {
  approved = fs.readFileSync(rootsFile, "utf8")
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter(Boolean)
    .map((line) => path.resolve(line));
} catch {
  process.exit(1);
}

if (!approved.includes(target)) process.exit(1);

process.stdout.write(target);
process.exit(0);
NODE
}
