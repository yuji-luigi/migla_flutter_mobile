# Public pages feature (pre-login CMS content) — added 2026-07-07

The app opens into a **public mode** (no account needed): splash → `PublicHomeScreen`, which renders the MIGLA website's CMS pages. Login is a button in the app bar / drawer; the members' dashboard flow after login is unchanged. Purpose: App Store guidelines require public value without credentials; content comes from the same Payload backend as migla.school, so nothing is duplicated.

## Data flow

1. `PublicContentViewModel.init()` (registered in `FeatureProviders`, follows the `StudentsViewModel` pattern) loads the **disk cache** for the current locale and renders instantly.
2. It then runs `publicContentVersionQuery` (ids + `updatedAt` only, network-only).
3. If the computed version differs from the cached one, `isUpdating` becomes true — `PublicContentUpdateBanner` shows the localized "New contents are available, please wait…" message (ja/en/it) — and the full `publicContentQuery` refetches and re-caches.
4. Offline / server unreachable → cached content keeps serving; the check fails silently (logged).

Version string = sorted `pageId@updatedAt` pairs + `header#<fnv1a>|footer#<fnv1a>` content hashes (`PublicContentCache.computeVersion`). Pages use `updatedAt` (bumped on every publish), but the globals are **hashed by content** because Payload does NOT bump a global's `updatedAt` on update — comparing timestamps would silently miss nav edits (found and fixed 2026-07-07). Consequence: the Header/Footer selections in `publicContentVersionQuery` must stay byte-identical to `publicContentQuery` (both localized), or every probe would hash differently and refetch forever.

## Files

| File | Role |
|---|---|
| `lib/src/models/api/page/graphql/public_content_queries.dart` | `publicContentQuery` (pages + Header + Footer, `$locale`), `publicContentVersionQuery` (light probe) |
| `lib/src/models/api/page/public_page_model.dart` | `PublicPageModel`, `PageHeroModel` |
| `lib/src/models/api/page/page_block_model.dart` | Block models: cta / content / mediaBlock / archive / formBlock (`tryFromJson` dispatch on `blockType`) |
| `lib/src/models/api/page/public_link_model.dart` | Link model tolerant of missing `appearance`; keeps reference slug for in-app navigation |
| `lib/src/models/internal/public_content_cache.dart` | JSON file per locale in Application Support (`public_content_<locale>.json`) + `computeVersion` |
| `lib/src/view_models/public_content_view_model.dart` | Cache-first load, version check, locale switch, pull-to-refresh |
| `lib/src/widgets/rich_text/lexical_rich_text.dart` | Payload Lexical JSON → Flutter (headings, lists, links w/ recognizers, quotes, images, format bitmask) |
| `lib/src/widgets/public_pages/*` | `RenderBlocks`, `PublicPageHero`, `PublicLinkButtons`, `PublicFooter`, `PublicContentUpdateBanner`, `openPublicLink` |
| `lib/src/screens/public/public_home_screen.dart` | Landing: drawer = Header navItems, language menu, login button, home page content, footer |
| `lib/src/screens/public/public_page_screen.dart` | Any other flagged page |

## CMS contract (backend: `../migla-payload-backend`)

- Only pages with `showInMobileApp: true` **and** `_status: published` are fetched. Block-level `showInMobileApp` (default true) filters within a page (`PublicPageModel.visibleBlocks`).
- Pages/nav items also carry a symmetric `showOnWebsite` flag (web-side concern; the app ignores it). Header/Footer navItems carry `showInMobileApp` per item — `PublicLinkModel.listFromLinksJson` drops rows where it is explicitly `false` (null = visible, for rows older than the flag).
- GraphQL union members are the block `interfaceName`s: `CallToActionBlock`, `ContentBlock`, `MediaBlock`, `ArchiveBlock`, `FormBlock`.
- Header/Footer globals provide navItems; page references open natively via `openPublicLink` when the slug is in the fetched set, otherwise fall back to `https://migla.school/<slug>` in the browser.
- **FormBlock is not rendered natively yet** — intro text + an "open this form on our website" button (`$host/<pageSlug>`). ArchiveBlock renders only its intro (no posts list yet). These are the two known next iterations.

## Home-page convention

The landing content is resolved as **`mobile-home` → `home` → first fetched page**. To give the app its own homepage, create an app-only page with slug `mobile-home` (`showInMobileApp: true`, `showOnWebsite: false`) — the website keeps its own `home`. Content updates are detected at launch **and on every foreground resume** (lifecycle observer on `PublicHomeScreen`).

## Gotchas

- **Production works only after the backend with `showInMobileApp` is deployed.** Until then keep `lib/env_switch.dart` on `http://localhost:3566` (ATS already allows HTTP). Switch back to `https://migla.school` before release builds.
- Flagging a page via REST PATCH can leave it `draft` (if it had pending edits) — it will silently not appear; publish it.
- Localization works pre-login: locale is read from secure storage (`Storage.getLocale`, default `ja`); the language menu calls `settingsController.updateLocale` **and** `PublicContentViewModel.onLocaleChanged()` (cache is per-locale).
- New l10n keys: `publicContentUpdateAvailable`, `publicOpenFormOnWebsite`, `publicNoContent`, `retry` (in all 3 ARBs; run `flutter gen-l10n` after editing).
- Cache location on the iOS simulator (for verification):
  `$(xcrun simctl get_app_container booted school.migla.app data)/Library/Application Support/public_content_ja.json`
