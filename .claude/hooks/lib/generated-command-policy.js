"use strict";

const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const root = String(process.env.PROJECT_ROOT || process.cwd());
const mode = String(process.argv[2] || "");
// Generated-output cleanup/reset carve-outs stay inside the repository-root
// projects/ tree. outputs/ and backups/ are not approved task-output roots.
const allowedRoots = ["projects"];

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";

  for (let index = 0; index < text.length; index += 1) {
    const ch = text[index];
    if (quote) {
      if (ch === quote) {
        quote = "";
      } else if (ch === "\\" && quote === '"' && index + 1 < text.length) {
        current += text[++index];
      } else {
        current += ch;
      }
      continue;
    }

    if (ch === '"' || ch === "'") {
      quote = ch;
      continue;
    }

    if (/\s/.test(ch)) {
      if (current) {
        words.push(current);
        current = "";
      }
      continue;
    }

    current += ch;
  }

  if (quote) return null;
  if (current) words.push(current);
  return words;
}

function expandSimpleBrace(candidate) {
  const first = candidate.indexOf("{");
  if (first < 0) return [candidate];

  const last = candidate.indexOf("}", first + 1);
  if (
    last < 0 ||
    candidate.indexOf("{", first + 1) >= 0 ||
    candidate.indexOf("}", last + 1) >= 0
  ) {
    return [];
  }

  const before = candidate.slice(0, first);
  const body = candidate.slice(first + 1, last);
  const after = candidate.slice(last + 1);
  if (!body || body.includes("/") || /[$`*?\[\]{}<>|;&\n\r]/.test(body)) return [];
  return body.split(",").filter(Boolean).map((part) => `${before}${part}${after}`);
}

function pathAllowed(candidate, { allowBrace = false } = {}) {
  if (!candidate || /[$`*?\[\]<>|;&\n\r]/.test(candidate)) return false;

  const expanded = allowBrace ? expandSimpleBrace(candidate) : [candidate];
  if (!expanded.length) return false;

  return expanded.every((item) => {
    if (!item || /[$`*?\[\]{}<>|;&\n\r]/.test(item)) return false;
    const resolved = path.resolve(root, item);
    const relative = path.relative(root, resolved).replace(/\\/g, "/");
    if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) return false;
    return allowedRoots.some(
      (prefix) => relative.startsWith(`${prefix}/`) && relative.length > prefix.length + 1,
    );
  });
}

function isBoundedCleanup(subcommand) {
  const words = tokenize(subcommand);
  if (!words || words.length < 3 || words[0] !== "rm") return false;

  let sawRecursive = false;
  let sawForce = false;
  let sawPath = false;

  for (let index = 1; index < words.length; index += 1) {
    const word = words[index];
    if (word === "--") continue;

    if (word.startsWith("-")) {
      if (!/^-+[rf]+$/.test(word)) return false;
      if (word.includes("r")) sawRecursive = true;
      if (word.includes("f")) sawForce = true;
      continue;
    }

    sawPath = true;
    if (!pathAllowed(word)) return false;
  }

  return sawRecursive && sawForce && sawPath;
}

function isGeneratedMkdir(subcommand) {
  const words = tokenize(subcommand);
  if (!words || words.length < 3 || words[0] !== "mkdir") return false;

  let sawPath = false;

  for (let index = 1; index < words.length; index += 1) {
    const word = words[index];
    if (word === "--") continue;

    if (word.startsWith("-")) {
      if (!/^-p+$/.test(word)) return false;
      continue;
    }

    sawPath = true;
    if (!pathAllowed(word, { allowBrace: true })) return false;
  }

  return sawPath;
}

function standaloneCleanupAllowed() {
  if (!command.trim() || /[|;&<>`$]/.test(command)) return false;
  return isBoundedCleanup(command);
}

function resetScaffoldAllowed() {
  if (!command.trim() || /(\|\||[;|<>`$])/.test(command)) return false;

  const parts = command.split("&&").map((part) => part.trim()).filter(Boolean);
  if (parts.length < 2) return false;

  let index = 0;
  while (index < parts.length && isBoundedCleanup(parts[index])) index += 1;
  if (index === 0 || index === parts.length) return false;

  while (index < parts.length && isGeneratedMkdir(parts[index])) index += 1;
  return index === parts.length;
}

if (mode === "cleanup" && standaloneCleanupAllowed()) {
  process.exit(0);
}

if (mode === "reset-scaffold" && resetScaffoldAllowed()) {
  process.exit(0);
}

process.exit(1);
