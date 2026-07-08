---
name: run-app
description: Run the MIGLA Flutter app on the iOS simulator and verify changes visually — env target selection (local backend vs production), launch, screenshot, and how to verify the public pages cache/update flow. Use when asked to run the app, see a change working, screenshot a screen, or test the public content flow end-to-end.
---

# run-app

## 1. Pick the backend target first

`lib/env_switch.dart` decides where debug builds point (`useProdUrl=false` → `devHost`):

- Local Payload dev server: `const String devHost = 'http://localhost:3566';` — requires `pnpm dev` running in `../migla-payload-backend`. iOS ATS already allows HTTP.
- Production: `https://migla.school`. ⚠ Only valid for features whose backend is already deployed there (check `../ai-config-migla/docs/PUBLIC_MOBILE_APP.md` for current state).

Never commit a localhost value silently — mention the current setting in your report.

## 2. Launch

```sh
xcrun simctl list devices booted            # is a simulator up?
open -a Simulator                            # boot default one if not
flutter devices                              # get the device id
flutter run -d <device-id> --debug 2>&1 | tee /tmp/flutter_run.log &
# ready when the log shows "A Dart VM Service … is available at:"
```

Run `flutter run` in the background and grep the log rather than blocking. Hot reload: send `r` is not possible non-interactively — relaunch instead, or use `xcrun simctl terminate booted school.migla.app && xcrun simctl launch booted school.migla.app` for the already-installed build.

Bundle id: `school.migla.app`.

## 3. Screenshot / verify

```sh
xcrun simctl io booted screenshot <path>.png
```

Read the PNG to actually look at it. Programmatic taps are NOT available (no assistive access, no idb) — verify interactions via state on disk / server instead:

- **Public content cache** (proves fetch + cache):
  `CONTAINER=$(xcrun simctl get_app_container booted school.migla.app data)` → `"$CONTAINER/Library/Application Support/public_content_<locale>.json"` (has `version`, `fetchedAt`, `data`).
- **Update flow** (proves version check): bump content (`node ../migla-cli/dist/index.js pages publish <slug>`), relaunch the app, confirm the cache file's `fetchedAt`/`version` changed. The update banner itself flashes <1s against localhost.
- GraphQL sanity without the app: POST the queries from `lib/src/models/api/page/graphql/public_content_queries.dart` to `<host>/api/graphql` with `{"locale": "ja"}`.

## 4. After l10n or model edits

- ARB changes → `flutter gen-l10n` (generated files are checked in under `lib/src/localization/`).
- Always `flutter analyze` before reporting done; the repo has ~40 pre-existing warnings — only new issues in your files count.
