# Changelog

## 0.3.0 — Personal endpoint (2026-07)
- Added authenticated `/mcp-me` endpoint with 3 personalized tools.
- Supabase OAuth 2.1 with Dynamic Client Registration.
- Consent screen at `wavemasterai.com.br/.lovable/oauth/consent`.
- Public endpoint expanded from 3 → 8 tools.
- Attribution tracking for signups and returning users driven by MCP invocations.

## 0.1.0 — Initial public launch (2026-07)
- Public MCP server with 3 read-only tools: `get_forecast`, `melhores_praias_hoje`, `praias_perto_de_mim`.
- MCP Streamable HTTP transport (spec 2025-06-18).
- Rate-limit: 60 req/hour per client.
