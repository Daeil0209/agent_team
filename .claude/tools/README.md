# Claude Tool Entrypoints

This directory owns Claude-system tool entrypoints that must be available to agents during current work.

Active entries:
- `codex-mcp/start.sh`: starts the official Codex MCP server for parallel independent review.
- `playwright-cli/start.sh`: runs the local Playwright CLI for tester/dev-loop browser proof.
- `playwright-mcp/start.sh`: starts the local Playwright MCP server for validator/browser acceptance proof.

Do not place research notes, proof-of-concept workers, or unused future adapters here.
If a tool is not wired from `.mcp.json`, a lane packet, or an active skill/tool contract, remove it or keep it outside this system surface.
