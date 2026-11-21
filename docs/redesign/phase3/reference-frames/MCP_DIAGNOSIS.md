# Stitch MCP — final diagnosis, restoration, and verification

## Diagnosis

- Config source: `C:\Users\ASUS\.config\opencode\opencode.json`, key path `mcp.stitch`.
- State before change: `type = remote`, `url = https://stitch.googleapis.com/mcp`, `headers.X-Goog-Api-Key` present (53 chars, value never printed), **`enabled = false`**.
- `opencode mcp list` before: `○ stitch disabled` (codebase-memory / exa / memmy were `✓ connected`).
- Root cause: **disabled by configuration** — not missing, not failing to initialize, not failing authentication. The earlier plain-REST 401 came from a client that omitted the API key and was not evidence of a bad key.

## Authorized change (single flag)

- Backup created **before** any edit:
  `C:\Users\ASUS\AppData\Local\Temp\opencode\opencode.json.bak-20261120-stitch-enable` (518,844 bytes).
- Change made: inside the `mcp.stitch` block only, `"enabled": false` → `"enabled": true`.
- Exact diff proof: first and only differing byte at offset 2414 (`false,` → `true,`); file length 518,844 → 518,843; bytes after that point are identical. URL, API key header, and all other MCP settings untouched.
- No explicit app restart was needed: `opencode mcp list` immediately reported `✓ stitch connected`.

## Read-only verification evidence

1. `opencode mcp list` → `✓ stitch connected`.
2. `get_project({ name: "projects/17670909757013221834" })` → project returned with **188 screen instances**.
3. `get_screen` for the known frame `54416f7ad13f4b009ffe50b69f97c0ff` → title **"Sign In"**, resource name matches, width 876 / height 1864, screenshot file `…/files/e204876b93e845c9a8ba87572387be51`.
4. `get_screen` for the owner-verified frame `9a52c7a5570143989da097c5cd5eb5fe` → title **"Delete Account"**, resource name matches.
5. `download_file` for the Sign In screenshot file → returned PNG image data (mimeType `png`, 152,764 base64 characters). Retrieval works.

## Prerequisites (still required for continued operation)

- Valid, unexpired `X-Goog-Api-Key` with Stitch API access.
- Read permission on project `17670909757013221834` for the key's Google identity.
- Network access to `stitch.googleapis.com`.
- Header-based auth needs no OAuth; `opencode mcp auth stitch` applies only if the server is later changed to OAuth.
- Never print or paste the key; do not change any other config, credential, or permission without explicit owner approval.

## Rollback

Restore the backup file above over `C:\Users\ASUS\.config\opencode\opencode.json` (with owner approval) to return to `enabled = false`.
