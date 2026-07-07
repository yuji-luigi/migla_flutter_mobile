# migla_flutter_mobile

## Browser snapshots & screenshots

Never save browser artifacts (screenshots, page snapshots, console logs) inside this repo. Save them to:

`/Users/yujisato/Development/personal/MIGLA/ai-config-migla/docs/snapshots/`

The Playwright MCP output dir already points there (see `.mcp.json`). When you take a screenshot with an explicit filename, write it to that folder too, using the naming convention `<topic>-<viewport-or-context>[-fixed].png`, and add a line describing it to `docs/snapshots/INDEX.md` in that folder.
