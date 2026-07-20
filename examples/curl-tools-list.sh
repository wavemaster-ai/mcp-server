#!/usr/bin/env bash
# List all public tools from the WaveMaster AI MCP server.
set -euo pipefail

ENDPOINT="https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp"

curl -sS "$ENDPOINT" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' \
  | jq '.result.tools[] | {name, title}'
