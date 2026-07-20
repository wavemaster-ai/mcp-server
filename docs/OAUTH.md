# OAuth 2.1 — Personal Endpoint (`/mcp-me`)

The Personal endpoint requires per-user authentication so tools can act as the signed-in WaveMaster account (favorites, alerts, logged sessions).

## Overview

- **Authorization server:** Supabase Auth (WaveMaster's managed instance)
- **Resource server:** the `mcp-me` edge function
- **Spec:** OAuth 2.1 with Dynamic Client Registration (RFC 7591) and PKCE
- **Consent screen:** `https://www.wavemasterai.com.br/.lovable/oauth/consent`

Compatible clients (Claude Desktop, ChatGPT Developer Mode, Cursor) auto-register — you never paste a `client_id` or token.

## Flow

1. Client fetches `/.well-known/oauth-protected-resource` from the `mcp-me` endpoint.
2. Client discovers the Supabase authorization server and registers dynamically.
3. Client opens the WaveMaster consent URL in the browser.
4. You sign in (email/password or Google) and click **Approve**.
5. Supabase redirects back to the client with an authorization code.
6. Client exchanges the code + PKCE verifier for an access token.
7. Every subsequent MCP call carries `Authorization: Bearer <token>`; the resource server validates the JWT and derives your user id from the `sub` claim.

## Discovery endpoints

- Protected resource metadata: `GET /functions/v1/mcp-me/.well-known/oauth-protected-resource`
- Authorization server metadata: served by Supabase at the discovered issuer

## Scopes

Supabase access tokens do not carry OAuth scopes. Authorization is enforced by:

- Row-Level Security on every table the tools query (user can only read their own rows)
- Tool code that scopes queries to `auth.uid()` from the verified JWT

## Token lifetime

- Access token: 1 hour (default Supabase)
- Refresh token: rotates on use; clients that support refresh flows will renew silently

## Revoking access

Sign in to `wavemasterai.com.br`, open your profile settings, and revoke the client from your active sessions. All tokens for that client become invalid immediately.

## Reporting issues

Open a GitHub issue in this repo with:
- Which MCP client you used
- The step where the flow failed (discovery / registration / consent / token exchange / tool call)
- Any error message from the client (redact tokens)
