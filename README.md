# WaveMaster AI — Official MCP Server

[![MCP](https://img.shields.io/badge/MCP-2025--06--18-blue)](https://modelcontextprotocol.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Website](https://img.shields.io/badge/site-wavemasterai.com.br-00b3ff)](https://www.wavemasterai.com.br)

Official Model Context Protocol (MCP) server for **[WaveMaster AI](https://www.wavemasterai.com.br)** — a global surf forecast platform monitoring **880+ spots across 51 countries**.

Use these tools inside **ChatGPT (Developer Mode)**, **Claude Desktop / Claude Code**, **Cursor**, or any MCP-compatible client to get real-time surf forecasts, best-day rankings, and personalized recommendations powered by NOAA + Open-Meteo + WaveMaster's proprietary SurfScore engine.

---

## Endpoints

WaveMaster ships **two** MCP endpoints. Both speak [MCP Streamable HTTP](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports).

| Endpoint | Auth | Tools | Use case |
|----------|------|-------|----------|
| **Public** — `https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp` | None | 8 | Anonymous surf discovery: forecast, rankings, comparisons |
| **Personal** — `https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp-me` | OAuth 2.1 | 3 | Signed-in user data: favorites, active alerts, last logged session |

The Personal endpoint uses **Supabase OAuth 2.1 with Dynamic Client Registration** — no manual client setup, no tokens to paste. Approve once at `wavemasterai.com.br` and your assistant acts as you.

---

## Tools

### Public (`/mcp`)
- **`get_forecast`** — today's surf forecast (wave face-height range, period, wind, SurfScore) for any spot by free-text name (PT-BR).
- **`melhor_dia_da_semana`** — best day of the next 7 days at a given spot.
- **`melhores_praias_hoje`** — Top 10 spots to surf **today** in a given country.
- **`praias_perto_de_mim`** — nearest surfable spots for a lat/lng.
- **`comparar_spots`** — side-by-side comparison of multiple spots.
- **`melhor_horario_hoje`** — best hour window today at a spot.
- **`recomendar_praia_nivel`** — recommendations filtered by surfer level (beginner/intermediate/advanced).
- **`resumo_semana_pais`** — weekly summary for a country's coastline.

### Personal (`/mcp-me` — OAuth)
- **`meus_favoritos_hoje`** — today's conditions for **your** favorited spots.
- **`meus_alertas_ativos`** — your active surf alerts and last-triggered state.
- **`minha_ultima_sessao`** — your last logged surf session.

Full schemas in [`manifest.json`](./manifest.json) and [`tools.json`](./tools.json).

---

## Quick start

### Claude Desktop / Claude Code
Add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "wavemaster": {
      "url": "https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp"
    },
    "wavemaster-me": {
      "url": "https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp-me"
    }
  }
}
```

### Cursor
Add to `~/.cursor/mcp.json` — same shape as above. See [`examples/cursor.json`](./examples/cursor.json).

### ChatGPT (Developer Mode)
Settings → Connectors → Advanced → Developer Mode → **Add server** → paste the endpoint URL.

### Raw HTTP (any client)
```bash
curl -s https://wosilzqqvhdmpdvhcfyu.supabase.co/functions/v1/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

More examples in [`examples/`](./examples).

---

## OAuth (Personal endpoint)

The `/mcp-me` endpoint is a resource server that verifies Supabase-issued OAuth 2.1 access tokens. Clients that support Dynamic Client Registration (Claude Desktop, ChatGPT Dev Mode, Cursor) auto-register — no manual client_id needed.

Flow: assistant discovers `/.well-known/oauth-protected-resource` → redirects you to `wavemasterai.com.br/.lovable/oauth/consent` → you sign in and approve → assistant gets a token scoped to your account.

Details: [`docs/OAUTH.md`](./docs/OAUTH.md).

---

## Data sources & pedigree

- **NOAA GFS-Wave** — global swell model
- **Open-Meteo Marine + Weather** — hourly wave, wind, tides
- **WaveMaster SurfScore** — proprietary scoring blending wave energy, period, wind alignment, and local orientation
- Wave heights reported in **face-height range** (Surfline/MSW standard), not raw Hs
- Direction vectors point **toward the swell's origin** (industry-standard)

Coverage: 880+ monitored spots across 51 countries and 6 continents (real-time count in the [platform stats](https://www.wavemasterai.com.br)).

---

## Rate limits

- Public endpoint: **60 requests/hour per client** (in-memory soft limit)
- Personal endpoint: authenticated calls scoped to the user's own data (RLS-enforced)

---

## Support & contact

- Website: [wavemasterai.com.br](https://www.wavemasterai.com.br)
- Issues in this repo for MCP-specific bugs or tool requests
- Platform bugs: use the in-app feedback form

---

## License

[MIT](./LICENSE) © WaveMaster AI
