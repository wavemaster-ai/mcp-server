# Contributing

This repository is the **public specification and documentation** for the WaveMaster AI MCP server. The server implementation itself is maintained in the WaveMaster private monorepo and deployed as a Supabase Edge Function.

## What lives here

- `manifest.json` / `tools.json` — the served tool schemas (mirror of the live server)
- `README.md`, `docs/` — usage guides for MCP clients
- `examples/` — copy-paste snippets for Claude Desktop, Cursor, and raw HTTP
- `.github/workflows/health-check.yml` — weekly ping to detect regressions

## Reporting issues

Open a GitHub issue with:
- The MCP client you're using (Claude Desktop, ChatGPT, Cursor, custom)
- Endpoint (`/mcp` or `/mcp-me`)
- Tool name + input arguments
- Observed vs. expected result
- Redact any OAuth tokens

## Suggesting new tools

Open an issue tagged `tool-request` describing:
- The end-user question the tool would answer
- Which data (already public on wavemasterai.com.br) it would surface
- Whether it needs user context (`/mcp-me`) or is anonymous (`/mcp`)

## Pull requests

Docs, examples, and workflow improvements are welcome via PR. Tool-schema changes must originate in the source repo and are mirrored here automatically on each release.
