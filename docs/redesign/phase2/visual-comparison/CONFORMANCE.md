# Phase 2 visual conformance — frame-by-frame record

All claims below were made by looking at rendered PNGs captured from the Android
emulator (`com.legalhub.app`, 1080×2400@420 phone / 2560×1600@320 wide). The
side-by-side sheets are under `comparison/`, raw captures under `rendered/`,
and the approved frames under `reference/`. No automated theme/responsive test
is used as a substitute for visual inspection.

**Capture caveat:** every AR/TR render, and the AR/TR strips in `comparison/`,
used a temporary, uncommitted startup delegate injection in `main.dart`
(reverted before the checkpoint commit). The unmodified APK crashes for those
locales on this baseline too; see `diagnostics/BASELINE_LOCALIZATION_REPRO.md`.
The captures document intended UI, not a shippable APK.

## Evidence reviewed

| Sheet | What it proves |
|---|---|
| `comparison/home_light__phone_en.png` | Home chrome vs light frame |
| `comparison/home_dark__phone_en.png` | Home chrome vs dark frame |
| `comparison/settings_light__phone_en.png` | Settings vs light twin (see artifact A1) |
| `comparison/settings_dark__phone_en.png` | Settings vs dark frame (primary reference) |
| `comparison/account_light__phone_en.png` | Account vs light frame |
| `comparison/account_dark__phone_en.png` | Account vs dark twin (see artifact A2) |
| `comparison/home_locale_phone_light.png` | Home EN / AR RTL / TR |
| `comparison/settings_locale_phone_light.png` | Settings EN / AR RTL / TR, dropdown mirroring |
| `comparison/account_locale_phone_light.png` | Account EN / AR RTL / TR |
| `comparison/wide_en_light.png`, `wide_en_dark.png` | Expanded (≥840dp) rail, light + dark |
| `comparison/wide_ar_light.png`, `wide_ar_dark.png` | Expanded rail in RTL (rail moves to the trailing edge) |

## Measured colour samples (from pixels, not source)

| Sample | Frame | Render |
|---|---|---|
| `home_dark` canvas @ (10,1100) | `#0D1C2E` | `#0D1C2E` (render @ analogous background point) |
| `settings_dark` canvas | `#0C1B2E` | `#0D1C2E` |
| `settings_dark` card | `#1A2B3B` | `#1A2B3C` |
| `settings_dark` active gold | `#E8C176` | `#E9C176` |
| `home_light` canvas @ (10,1100) | `#F8F9FF` | `#F8F9FF` |
| Light card fill | `#FFFFFF` | `#FFFFFF` |

The ≤1/255 differences are export rounding of the same frozen tokens
(`darkSecondary #E9C176`, `darkPrimary #0B1D2E` family). No new colour token
was introduced in Phase 2.

## Frame export artifacts (not conformance defects)

- **A1 — `settings_light.png` is a dark render.** Its canvas is `#0D1C2E`
  (sampled at (10,900)); the light twin was exported with dark controls. The
  true light reference is `home_light.png` (`#F8F9FF`) and `account_light.png`.
  The app's light Settings render therefore follows the light design language
  rather than this artifact.
- **A2 — `account_dark.png` has a light canvas.** Sampled (10,1200) and
  (20,600) are `#F9F9FF` while its cards are `#0B1D2E`. It is the inverse of
  A1. The app's dark Account render uses the coherent dark canvas/card pair
  proven by `home_dark` and `settings_dark`; matching A2 would mean a white
  page with dark cards, which no other frame does.

Neither artifact is "fixed" by changing app colours: the frozen token contract
(`Primary #0B1D2E`, canvas is *not* Primary) takes precedence.

## 1. `/home` (shell chrome only — dashboard content is Phase 4)

Reference: `reference/home_light.png`, `reference/home_dark.png`.
Renders: `rendered/home_{light,dark}_{phone,wide}_{en,ar,tr}.png` (12 files).

**Matches (visual):**
- Serif navy `LegalHub` app-bar title, leading avatar, trailing bell with badge.
- Serif greeting + body sentence, with the same ~16 px gap between them.
- Search field: full-width outlined box, leading magnifier, ~12 px corner radius.
- Bottom bar on phone: flat white/dark surface, single hairline above it, short
  gold rule over the active item, gold active icon + label, grey inactive.
- Wide: leading rail (left in LTR, right in RTL), flat with vertical hairline;
  content centred and capped rather than stretched.
- RTL: avatar/bell swap sides, text aligns right, chevrons and text field
  icons mirror, active gold rule follows the mirrored destination.

**Differences (all out of Phase 4 content scope, not Phase 2 chrome):**
- Frame shows a "Practice Areas" carousel and "Recent Activity" case cards;
  the app shows action cards (Book a consultation, Video consultation, …).
  Contract §1 explicitly leaves Home dashboard content to Phase 4.
- Frame uses photographic avatars; the app uses an initials monogram (D4).
- The dark frame tints Home-card icon circles dark; the render tints them light.
  This lives inside the dashboard content slated for Phase 4.
- Two shell destinations instead of four (D2).

**Required corrections:** none to the shell chrome. The bar/rail treatment was
the Phase 2 change and now matches.

## 2. `/settings` (primary implementation surface)

Reference: `reference/settings_dark.png` (frame id
`802bbf259357438fbf857d3934b9f56b`); `settings_light.png` is artifact A1.
Renders: `rendered/settings_{light,dark}_{phone,wide}_{en,ar,tr}.png` (12 files).

**Matches (visual):**
- Dark canvas, 12 px-radius cards with a 1 px `outlineVariant` hairline and no
  elevation; gap between cards matches the frame's ~16 px rhythm.
- Identity block: monogram/avatar left, display name in the serif display face,
  role and session notice beneath; no card around it, matching the frame's
  borderless header.
- Grouped preference card (Language, Theme) above the navigation card; divider
  inset starts after the icon column (measured against the frame's dividers).
- Gold active accent, serif headings, hairline-bottom app-bar area.
- RTL: labels, icons, chevrons and dropdown arrows mirror; the gold nav rule
  moves to the trailing destination; divider inset follows directionality.

**Differences (each traced to a frozen test or scope rule):**
- App-bar title `Settings` remains (D1) — pinned by
  `test/features/home/settings_screen_test.dart:75`; the frame's avatar+bell
  header cannot be reproduced without weakening that test.
- Dropdowns instead of segmented control / switch (D5, D6) —
  `DropdownButtonFormField` is the existing, tested a11y-compliant control.
- No uppercase section labels `PREFERENCES` / `LEGAL & SUPPORT` (D3) — would
  require new ARB keys in all three locales (frozen key set).
- Bare leading icons instead of tinted blocks (D7); outlined destructive
  button instead of a centred red strip (D8); monogram instead of photo (D4).
- Frame-only extras (Verified Counsel chip, Help & Support, 2FA, version
  footer, four destinations) are absent (D2, D9).
- `settings_light` render is light because A1 is a mis-exported twin.

**Required corrections:** the gold top-edge rule, flat bar/rail chrome, identity
header, card grouping, divider inset and serif headings were implemented this
phase; all are visible in the sheets. No further correction is possible without
breaking a pinned test or expanding scope.

## 3. `/settings/account`

Reference: `reference/account_light.png`, `reference/account_dark.png` (A2).
Renders: `rendered/account_{light,dark}_{phone,wide}_{en,ar,tr}.png` (12 files).

**Matches (visual):**
- Serif app-bar title and back arrow; in RTL the arrow flips and title centres.
- White (light) / dark (dark) cards with a hairline separating the serif card
  heading from its fields; same 12 px radius and card rhythm as the frame.
- Navy filled primary action in light theme; red-tinted danger card with a
  serif red "Danger zone" heading and a destructive row.
- Wide layout centres the same cards under the rail; RTL mirrors the cards.

**Differences:**
- Title `Account` from existing `l10n.accountTitle`, not `Account Settings`;
  no search icon or avatar in the app bar (D11) — neither is an app capability.
- Frame extras (institutional governance banner, licence/clearance chips,
  password strength meter, 2FA, idle-session, hardware devices, version
  footer) are FUTURE/out-of-scope (D9).
- In dark theme the danger card is dark maroon rather than the frame's pale
  pink, because A2's canvas is light; the app follows the dark token set.
- Filled buttons keep the M3 stadium shape rather than the frame's ~16 px
  radius (D12) — a global token change would affect screens outside Phase 2.

**Required corrections:** card presentation and serif headings were implemented
this phase and match; remaining items are scope/test-governed deviations.

## Conformance verdict

- **Shell chrome and Settings presentation: conformant** to the approved frames
  within the frozen test and scope constraints.
- **Account presentation: conformant** at the component/spacing/typography
  level; frame-only content intentionally omitted.
- **Home dashboard content: not compared as a Phase 2 target** — Phase 4.
- No test was changed, added, skipped or weakened to obtain these renders.
