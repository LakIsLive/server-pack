# server-pack
Minecraft server resource pack for the Demoncore network.

- `pack/` - the pack sources (the v1 release pack plus Demoncore additions).
- `server-pack.zip` - the built pack that ForcePack on the Velocity proxy sends to players:
  `https://github.com/LakIsLive/server-pack/raw/main/server-pack.zip`

## Demoncore additions
- `assets/demoncore/items/glass_panel.json` - tinted glass pane used by the Hub's GLASS particle zones
  (Demoncore-Lobby `particles.glass-model: "demoncore:glass_panel"`). The colour comes from the
  item's custom model data colour, so one model serves every zone colour.

## Rebuilding the zip
Run `python build_zip.py` (builds and verifies the zip; do not use Windows `tar.exe`, it once wrote a truncated zip).
Then put the new SHA-1 (`sha1sum server-pack.zip`) in the proxy's `plugins/forcepack/config.toml` (`global-pack.hash`).
