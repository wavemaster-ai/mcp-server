#!/usr/bin/env bash
# Invoke get_forecast for a named spot.
set -euo pipefail

ENDPOINT="https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp"
SPOT="${1:-Joaquina}"

curl -sS "$ENDPOINT" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"tools/call\",\"params\":{\"name\":\"get_forecast\",\"arguments\":{\"spot\":\"$SPOT\"}}}" \
  | jq .
