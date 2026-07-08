# migla_flutter_mobile

Flutter app for MIGLA (Japanese supplementary school in Milan). Package name is `migla_flutter` (imports: `package:migla_flutter/...`). Backend is Payload CMS in `../migla-payload-backend`; target URL is chosen in `lib/env_switch.dart` (debug) / `lib/env_vars.dart`.

## Conventions

- **GraphQL**: `graphql_flutter`, hand-written query strings under `lib/src/models/api/<feature>/graphql/`, hand-written `fromJson` models. Payload shape: plural-capitalized collections returning `{ docs }`, `locale: $locale` of type `LocaleInputType!`.
- **State**: `provider` ChangeNotifier view models in `lib/src/view_models/`, registered in `lib/src/providers/feature_providers.dart`, each with a `$xViewModel(context)` accessor.
- **Navigation**: plain Navigator + `nb_utils` `.launch(context)`. No go_router.
- **Localization**: flutter gen-l10n, ARBs in `lib/src/localization/app_{en,it,ja}.arb`, accessed via `context.t.<key>`. Run `flutter gen-l10n` after ARB edits. Locale persists in secure storage (default `ja`) and works pre-login.
- **Storage**: `Storage` static wrapper (secure storage) for small values; file cache in Application Support for larger blobs.

## Public pages (pre-login mode)

Splash lands on `PublicHomeScreen`, which renders CMS pages flagged `showInMobileApp` with disk caching and an updatedAt-based update check. Read [docs/public_pages_feature.md](docs/public_pages_feature.md) before touching anything under `lib/src/screens/public/`, `lib/src/widgets/public_pages/`, or the page models — it documents the CMS contract, version/caching flow, and gotchas (e.g. production needs the backend deployed; flagged-but-draft pages don't appear).

## Browser snapshots & screenshots

Never save browser artifacts (screenshots, page snapshots, console logs) inside this repo. Save them to:

`/Users/yujisato/Development/personal/MIGLA/ai-config-migla/docs/snapshots/`

The Playwright MCP output dir already points there (see `.mcp.json`). When you take a screenshot with an explicit filename, write it to that folder too, using the naming convention `<topic>-<viewport-or-context>[-fixed].png`, and add a line describing it to `docs/snapshots/INDEX.md` in that folder.
