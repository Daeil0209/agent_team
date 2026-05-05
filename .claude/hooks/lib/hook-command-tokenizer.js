"use strict";

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";

  for (let index = 0; index < text.length; index += 1) {
    const ch = text[index];
    if (quote) {
      if (ch === quote) {
        quote = "";
      } else if (ch === "\\" && quote === "\"" && index + 1 < text.length) {
        current += text[++index];
      } else {
        current += ch;
      }
      continue;
    }

    if (ch === "\"" || ch === "'") {
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

module.exports = { tokenize };
