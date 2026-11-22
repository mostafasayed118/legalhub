# Phase 2 — Shell + Settings — Visual Evidence Report (resubmission)

Status: **Phase 2 visual evidence accepted in form; closeout corrections applied —
awaiting owner acceptance of closeout.** Phase 3 has **not** been started.

Branch: `redesign/stitch-alignment` (local checkpoint commit only; nothing pushed).
This report supersedes the rejected Phase 2 submission: it replaces automated-test
claims with rendered screenshots from the Android emulator and a per-screen
comparison against the approved Stitch frames. The closeout corrections requested
by the owner are recorded in §1, §9.1, §10 and §14.

---

## 1. Corrections carried into this report

| Item | Rejected report | Corrected value | Proof |
|---|---|---|---|
| Dark Settings frame ID | `802bbf259370…` — the prefix was **mistranscribed** in the earlier report | **`802bbf259357438fbf857d3934b9f56b`** | fresh canvas read, length 32, name "Settings & Localization (Dark Mode)" |
| Byte arithmetic: intermediate delta | `+5,935` | **`+4,935`** (`24,146 − 19,211 = 4,935`) | recomputed from the file lengths |
| Byte accounting: original → intermediate → final | — | `19,211 → 24,146 (+4,935) → 24,871 (+725)` | `Get-Item` on the three revisions |

The `+725` second step is unchanged and still accounts for exactly two edits:
the Collaboration Task Board ID typo fix and the §11 note 4 dark-twin supplement.
The earlier `5,935` figure was an arithmetic slip, not a different edit set.
The ID error above was likewise a transcription error only — the downloaded
frame was and remains `settings_dark.png` from the approved Phase 0B set.

---

## 2. How the evidence was produced

- **Device:** Android emulator `emulator-5554` (API 36, x86_64), package
  `com.legalhub.app` — the **production flavor built in debug mode**
  (`flutter build apk --debug --flavor production -t lib/main_production.dart
  --target-platform android-x64`), so the result carries no debug banner while
  keeping the development gateways that make a demo session possible.
- **Phone geometry:** `wm size reset` / `wm density reset` → 1080×2400 @ 420 dpi
  = **411×914 dp** (compact: bottom `NavigationBar`).
- **Wide geometry:** `wm size 2560x1600` + `wm density 320` → **1280×800 dp**
  (expanded: leading `NavigationRail`, breakpoint `AppBreakpoints.expanded` = 840).
- **Locales/themes:** driven by the app's own persisted preferences, written
  before launch (`flutter.legalhub.locale`, `flutter.legalhub.theme_mode`,
  `flutter.legalhub.onboarding_completed_v1`) through `run-as`, so every
  screenshot is the real app reading its real stores — not a test harness.
- **Navigation:** UIAutomator dumps locate nodes by the **ARB label** (never a
  hardcoded translation), taps the node centre, then waits for the next screen
  before capturing. Arabic RTL is therefore driven by the real mirrored layout.
- **Capture:** `adb shell screencap -p` → `adb pull` (no PowerShell redirection,
  which corrupts PNG bytes).
- **Comparisons:** each reference frame and its render are normalised to the same
  width and shown side by side at 1:1 relative scale, so spacing/typography
  differences are readable rather than hidden by scaling.

Capture tooling lives outside the repository (scratch scripts under the session
temp directory); the **evidence** lives under `docs/redesign/phase2/visual-comparison/`.

No golden/screenshot tests were added to CI (contract rule 6).

---

## 3. Evidence inventory

### 3.1 Approved reference frames (`visual-comparison/reference/`)

| Screen | Light | Dark |
|---|---|---|
| `/home` | `home_light.png` (frame `bbd6d204ee0f48789f939269667b9134`) | `home_dark.png` (`90f8b78bf0b5447b8b98343dfacb8cd6`) |
| `/settings` | `settings_light.png` (frame `d1d356aa7a814a4db9ca35938b591f59`) | `settings_dark.png` (`802bbf259357438fbf857d3934b9f56b`) |
| `/settings/account` | `account_light.png` (`9d1be566e6a44c91b03c02fa748c9261`) | `account_dark.png` (`36818a8c8db44d39a6a1ad8e6cf0c161`) |

### 3.2 Rendered screenshots (`visual-comparison/rendered/`)

36 captures = 3 screens × 2 themes × 2 layouts × 3 locales.

Naming: `<screen>_<theme>_<layout>_<locale>.png`, e.g.
`settings_dark_phone_ar.png`, `account_light_wide_tr.png`.

**Label:** every `*_ar.png` and `*_tr.png` capture (and the AR/TR strips in
`comparison/`) was taken from a **temporary startup workaround** build — a
local, uncommitted delegate injection in `main.dart` applied only to the capture
APK and reverted before the checkpoint. It documents the intended UI; the
unmodified APK crashes for these locales (§10). English captures needed no
workaround.

### 3.3 Side-by-side comparisons (`visual-comparison/comparison/`)

13 sheets, all human-reviewed:

- 6 frame-vs-render pairs: `{home,settings,account}_{light,dark}__phone_en.png`
  (reference left, render right, same width, top-aligned).
- 3 locale strips: `{home,settings,account}_locale_phone_light.png`
  (EN / AR RTL / TR side by side).
- 4 wide-layout strips: `wide_{en,ar}_{light,dark}.png`
  (Home / Settings / Account at 1280×800 dp; the AR sheets show the rail on
  the trailing edge).

The per-sheet findings are in `visual-comparison/CONFORMANCE.md`.

### 3.4 Baseline diagnostics (`visual-comparison/diagnostics/`)

`BASELINE_LOCALIZATION_REPRO.md` plus four screenshots/XML dumps proving the
AR/TR crash on untouched `main` at `cb65f84`. These are supporting evidence for
§10, not Phase 2 UI comparisons.

---

## 4. Measured colour conformance

Sampled directly from the PNGs (not from the theme source), so these are
rendered-pixel facts:

| Element | Stitch frame | Rendered app | Δ |
|---|---|---|---|
| Dark canvas (`settings_dark` @ (10,1100)) | `#0C1B2E` | `#0D1C2E` | 1/255 on red |
| Dark canvas (`home_dark` @ (10,1100)) | `#0D1C2E` | `#0D1C2E` | exact |
| Dark card fill (`settings_dark`) | `#1A2B3B` | `#1A2B3C` | 1/255 on blue |
| Dark active gold (nav + accents) | `#E8C176` | `#E9C176` | 1/255 on red |
| Light canvas (`home_light` @ (10,1100)) | `#F8F9FF` | `#F8F9FF` | exact |
| Light card fill | `#FFFFFF` (frame cards) | `#FFFFFF` | exact |

The ≤1/255 deltas are the frames' own export rounding of the same tokens
(`darkSecondary #E9C176`), not a styling difference. Two frames have inverted
exports and are treated as artifacts, not targets: `settings_light.png` has a
dark canvas (`#0D1C2E`), and `account_dark.png` has a light canvas (`#F9F9FF`)
with navy cards. See A1/A2 in `visual-comparison/CONFORMANCE.md`.

---

## 5. Per-screen conformance

See `visual-comparison/CONFORMANCE.md` for the frame-by-frame detail. Summary:

### 5.1 Shell / navigation chrome

- Flat bar, hairline top divider, and the short gold rule above the active
  destination now match the frames (measured: gold `#E9C176` vs `#E8C176`,
  bar `#0D1C2E` vs `#0C1B2E`).
- Active destination carries the gold icon + label; inactive is grey.
- **Two** destinations (Home, Settings) instead of the frames' four — contract
  §4 requirement, documented as deviation D2.
- The shell has no canvas frame (Phase 0B §11.1); the rail is app authority and
  is therefore not compared against a frame, only verified for correctness.

### 5.2 `/settings`

- Card geometry (12 px radius, 1 px `outlineVariant`, flat, no elevation),
  row order, and divider inset after the icon column match the dark frame.
- Serif screen title and serif identity name match the frame's display face.
- Differences are behavioural pins or frozen-string constraints, not misses —
  see D1, D3–D8.

### 5.3 `/settings/account`

- White cards with a hairline-separated header, serif card titles, navy filled
  primary action (light), red-tinted danger card with serif red heading — all
  match the light frame.
- Frame-only elements (institutional banner, 2FA, idle-session, hardware rows,
  version footer) are FUTURE/out-of-scope and are **not** implemented — D9.

---

## 6. Presentation changes (what actually changed)

Four source files, presentation only:

| File | Change |
|---|---|
| `lib/app/legalhub_theme.dart` | `navigationBarTheme` + `navigationRailTheme` (flat chrome, 68 dp bar, transparent indicator, 12 sp labels), `navAccent` accessor, hoisted `fontFamily` |
| `lib/app/router_app_shell.dart` | Nav-bar chrome: hairline divider + gold rule positioned over the active destination (direction-aware), rail indicator disabled |
| `lib/features/home/presentation/settings_screen.dart` | Rewritten presentation: identity header, two grouped cards, borderless 48 dp preference rows, indented dividers, error-outlined sign-out; all strings/routes/cubits unchanged |
| `lib/features/profile/presentation/account_screen.dart` | Card presentation (`_AccountCard`, `_DangerCard`), serif headings; cubits/validation/sheet unchanged |

No routes, cubits, gateways, stores, validators, or ARB files were modified.
`test/` was not touched (see §8.4).

---

## 7. Behaviour preservation

- Routes unchanged; the shell still derives destinations from capabilities and
  keeps the fixed Home → Settings order.
- `LocaleCubit.setLocale` / `ThemeCubit.setThemeMode` / `AuthCubit.signOut` are
  still the only actions the Settings screen performs.
- The delete-account sheet, password validation and profile-edit flows are
  untouched.
- All eight Settings tiles still navigate to their original routes, in the
  original order.

---

## 8. Gates

All gates were run against the final source state (temporary capture-only
delegate injection and the regenerated localization file reverted first).

| Gate | Result |
|---|---|
| `flutter analyze` | **No issues found!** (exit 0, 74.6 s) |
| `dart format --output=none --set-exit-if-changed .` | **837 files, 0 changed** (exit 0, 8.26 s) |
| `flutter test --coverage` | **2,447 passed, 13 skipped, 0 failed** (exit 0, 3 min 52 s) |
| Coverage | **84.6934%** (LH 18,619 / LF 21,984), vs 84.6016% baseline (18,466 / 21,827) — **+0.0918 pp** |
| Test files changed | **none** (`git status --porcelain -- test` is empty) |

The coverage denominator grows by 157 instrumented lines because the
presentation widgets are new code; the hit count grows by 153, so the rate
still improves slightly. Full command tails are in §12.

---

## 9. Deviations register

Each deviation is a frame element deliberately **not** reproduced, with the
reason and the contract clause that forces it.

| # | Frame element | App behaviour | Reason |
|---|---|---|---|
| D1 | Settings app bar has avatar + bell, **no title** | Serif `Settings` title | `test/features/home/settings_screen_test.dart:75` asserts `find.text('Settings')` exactly once when the screen is pumped standalone; removing the title breaks a pinned behavioural test (contract §8 DoD 4: no test weakening) |
| D2 | Four destinations (Home, Cases, Messages, Profile) | Two (Home, Settings) | Contract §4 + DoD 2: exactly two destinations |
| D3 | Uppercase section labels `PREFERENCES`, `LEGAL & SUPPORT` | Two visually separated cards, no labels | New labels need new ARB keys in all three locales; ARB key-set parity is frozen (contract §7) |
| D4 | Photographic avatar | Monogram avatar from the display name | No portrait asset exists in the app; a stock photo would misrepresent the session |
| D5 | Language segmented control `EN | AR` | Dropdown of supported locales | The existing, tested control is a `DropdownButtonFormField`; changing the widget changes pinned behaviour |
| D6 | Theme switch ("Dark mode active") | Three-way dropdown (System default / Light / Dark) | `ThemeMode.system` is a real, persisted state the app supports and tests pin all three labels |
| D7 | Icon column with a tinted leading block | Bare leading icons | Cosmetic; keeping the icon column width preserves the frame's divider inset (already matched) |
| D8 | `Log Out` as a centred red strip | Error-outlined full-width destructive button | Same action; keeps an explicit 48 dp target and the app's existing outlined-button token |
| D9 | Institutional banner, `Verified Counsel` chip, 2FA, idle sessions, hardware devices, version footer, `Help & Support`, `Account Settings` search/avatar | Not implemented | FUTURE / out-of-scope frames (contract §1); the authorization explicitly excludes them |
| D10 | `settings_light.png` looks dark | Light Settings rendered from the app's true light tokens | The Stitch file itself is a dark render (sampled `#0D1C2E` canvas) — a canvas export artifact. The light reference is derived from `home_light` + `account_light`, which are true light frames |
| D11 | Account title `Account Settings` + search + avatar | Serif `Account` | Title comes from the existing `l10n.accountTitle`; search/avatar are not app capabilities |
| D12 | Buttons with ~16 px corner radius | `FilledButton` keeps the M3 stadium shape | Filled-button shape is an app-global token; changing it restyles screens outside Phase 2 scope (contract §1) |
| D13 | `account_dark.png` canvas is light (`#F9F9FF`) with navy cards | Dark Account uses the coherent dark canvas + dark cards proven by `home_dark` / `settings_dark` | Second Stitch export artifact (inverse of D10); reproducing it would break the frozen dark token pair |

### 9.1 Design/behavior conflict — escalation record (D5, D6)

**Explicit record:** the approved Stitch frames show a two-option segmented
control for Language (`EN | AR`) and a switch for Theme ("Dark mode active"),
while the app ships a locale dropdown and a three-way theme dropdown
(System default / Light / Dark). This is a **Stitch visual authority vs. app
behavioral authority conflict**. It should have been escalated for owner approval
*before* the Phase 2 presentation work; it was recorded only as deviations D5/D6
in the earlier submission. That is a process gap on this side, and it is recorded
here explicitly rather than presented as an agreed design choice.

**Owner decision (current closeout instruction):** **RETAIN the existing
dropdown behavior for Phase 2.** No widget, interaction, route, Cubit, ARB key
or test is changed for this decision. The dropdowns remain in place in the
checkpoint commit; D5 and D6 stay on the deviations register as *owner-ratified
for Phase 2*, not as an unresolved defect. Any future move to the Stitch
controls needs a new owner decision and its own behavioral-test wave.

---

## 10. Known release-blocking issue — pre-existing, outside Phase 2 scope

**Any `flutter build apk` in this repository produces an APK that cannot render
Arabic or Turkish** — the app crashes with `No MaterialLocalizations found`.
**Confirmed pre-existing on the untouched baseline branch (see below).**

- Cause: `flutter gen-l10n` runs on **every** `flutter build apk` and rewrites
  `lib/l10n/app_localizations.dart`. The repo already documents this and ships
  `tool/fix_l10n_delegate_imports.dart`, which CI runs at
  `.github/workflows/ci.yml:119-120` — but CI then builds the appbundle at
  line 276 and the APK at line 289, and those builds regenerate the file again,
  reverting the fix before compilation. Measured SHA-256 of the l10n file:
  `529066F4…` after `dart run tool/fix_l10n_delegate_imports.dart`,
  `305E6002…` after the subsequent `flutter build apk`; `git status` confirms
  the file is modified again.
- The fixed file takes `GlobalMaterialLocalizations` from `package:material_ui`
  and `GlobalCupertinoLocalizations` from `package:cupertino_ui`; the generated
  file imports the deprecated `flutter_localizations` implementations instead.
- Those deprecated classes implement `package:flutter/material.dart`'s
  `MaterialLocalizations`, while this app's widgets come from
  `package:material_ui/material_ui.dart` — different type identity. English
  survives because `MaterialApp` supplies `DefaultMaterialLocalizations`; any
  other locale resolves to no `MaterialLocalizations` at all.
- Verified on device: Turkish and Arabic showed the red error screen and
  `No MaterialLocalizations found` / locale-not-supported messages in logcat.
  English was unaffected.
- Reproduced on both installed toolchains (3.47.8 and 3.50.0), so it is not a
  one-off local glitch.
- **Baseline confirmation:** a fresh worktree of untouched `main` at
  `cb65f84ecc4bb09d8db08d5b9278f4a44edb6f6a` (no Phase 2 edits, tests, ARBs or
  config changes) was built with Flutter 3.50.0 and installed on the same
  emulator. Both `tr` and `ar` crashed identically; logcat reported
  `This application's locale, tr/ar, is not supported by all of its localization
  delegates` followed by `Another exception was thrown: No MaterialLocalizations
  found.` Only the welcome heading, subtitle and e-mail label rendered. Proof:
  `visual-comparison/diagnostics/BASELINE_LOCALIZATION_REPRO.md` and its four
  baseline screenshots/XML dumps.

**Disposition:** known, pre-existing, **release-blocking for all non-English
locales**. It is deliberately **not fixed in Phase 2**.

- **Separate remediation task:** `LH-REL-001 — keep material_ui/cupertino_ui Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
  localization delegates through APK builds` (to be registered in the owner's
  tracker; no external tracker was touched).
- **Owner:** Project Owner (github.com/mostafasayed118), matching the repo's
  `> **Owner:**` convention; implementation to be assigned by that owner to the
  app/platform maintainer, with its own branch, gates and approval.
- **Temporary startup workaround used for capture only:** the evidence APK
  injected the `material_ui`/`cupertino_ui` delegates in `main.dart` (one import
  plus an explicit delegate list), exactly what the committed
  `app_localizations.dart` intends. It was local, uncommitted, and **reverted
  before the checkpoint commit and all gates**. All AR/TR captures — and the
  AR strips in `comparison/` — are explicitly labelled as produced with this
  workaround; they show intended UI, not a shippable APK.

---

## 11. DoD checklist

| # | Item | Status |
|---|---|---|
| 1 | SettingsScreen + shell implemented, Settings first | **Done** — shell chrome + Settings + Account presentation |
| 2 | Exactly two shell destinations preserved | **Verified** — Home, Settings; EN/AR/TR + wide captures |
| 3 | No new routes/cubits/gateways/capabilities/refactors | **Verified** — see §6 |
| 4 | Behavioural tests green, none weakened/deleted/skipped | **Verified** — §12, zero test edits |
| 5 | Light, dark, EN, AR RTL, TR verified | **Done** — 36 rendered screenshots + comparison sheets |
| 6 | Human-reviewed visual comparisons only, no CI goldens | **Done** — §2–§5, no test files added |
| 7 | Gates: analyze 0, format 0, suite passing | **Verified** — §12 |
| 8 | Changed-file list, evidence, results, gates, deviations, DoD submitted | **This document** |
| 9 | Branch + checkpoint discipline preserved | **Verified** — §13 |
| 10 | No push/PR/merge without approval | **Verified** — nothing pushed |
| 11 | Phase 0A evidence preserved | **Verified** — `REDESIGN_EXECUTION_CONTRACT.md` unchanged |
| 12 | Behaviour preservation contract (§4–§7) verified | **Verified** — §7 |
| 13 | Spacing/radius/typography reconciled against the frames | **Done** — §4–§5, D12 |
| 14 | No unresolved token conflict / behavioural change / scope expansion / gate failure | **Verified for Phase 2** — no token conflict, behaviour change, scope expansion or gate failure; one *pre-existing, out-of-scope* APK/localization build issue is reported in §10 and deliberately not fixed here |

---

## 12. Gate log

Commands run from `C:\flutter_projects\law_app` with Flutter 3.50.0 on PATH:

```
$ flutter analyze
Analyzing law_app...
No issues found! (ran in 74.6s)
exit=0

$ dart format --output=none --set-exit-if-changed .
Formatted 837 files (0 changed) in 8.26 seconds.
exit=0

$ flutter test --coverage
03:52 +2447 ~13: All tests passed!
exit=0
LH=18619 LF=21984 pct=84.6934
```

These are the **post-checkpoint** runs, against the committed source state.
`lib/l10n/app_localizations.dart` was restored with `git checkout --` after each
command, because `flutter analyze` and `flutter test` also regenerate it; the
final `git status --porcelain=v1` is empty.

## 13. Git state

- Branch: `redesign/stitch-alignment`.
- Checkpoint commit created locally (see the closeout message / `git log -1`).
- Commits ahead of `main`: **1**. Commits ahead of `origin/main`: **1**.
- Worktrees: one (the current checkout). The temporary baseline worktree used
  for §10 was removed; it never touched this branch.
- Nothing pushed, PR'd or merged — remote `main` is still at `cb65f84…`.
- Changed source files (presentation only):
  `lib/app/legalhub_theme.dart`, `lib/app/router_app_shell.dart`,
  `lib/features/home/presentation/settings_screen.dart`,
  `lib/features/profile/presentation/account_screen.dart`.
- No files under `test/`, `lib/l10n/`, `lib/main.dart`, `pubspec.yaml` or CI
  were changed.
- Final state after the checkpoint commit: branch still
  `redesign/stitch-alignment`, working tree clean, remote `main` unchanged at
  `cb65f84…` (nothing pushed, no PR, no merge). Exact checkpoint hash is in the
  closeout message and available via `git log -1 --format=%H`.

---

## 14. Evidence closeout summary

### Changed presentation source files (exactly four)

1. `lib/app/legalhub_theme.dart`
2. `lib/app/router_app_shell.dart`
3. `lib/features/home/presentation/settings_screen.dart`
4. `lib/features/profile/presentation/account_screen.dart`

Diff summary (tracked sources only): 4 files, **619 insertions(+), 166
deletions(-)**. No test, l10n, pubspec, CI or behavior file is in the diff.

### Preserved evidence

- 36 rendered screenshots — `visual-comparison/rendered/`
- 13 comparison sheets — `visual-comparison/comparison/`
- `visual-comparison/CONFORMANCE.md` — per-screen conformance report
- 6 approved reference frames — `visual-comparison/reference/`
- 4 baseline crash dumps + repro note — `visual-comparison/diagnostics/`
- This report — `docs/redesign/phase2/PHASE2_EVIDENCE_REPORT.md`

### Concise disposition of D1–D13

| # | Disposition |
|---|---|
| D1 | **Accepted deviation** — Settings title retained; pinned by `settings_screen_test.dart:75`. |
| D2 | **By contract** — two shell destinations (Home, Settings) only. |
| D3 | **Deferred** — no section labels; new ARB keys would break frozen key-set parity. |
| D4 | **Accepted deviation** — monogram instead of photographic avatar; no asset exists. |
| D5 | **Owner-ratified for Phase 2** — dropdown retained; conflict now explicitly recorded in §9.1. |
| D6 | **Owner-ratified for Phase 2** — three-way theme dropdown retained; conflict in §9.1. |
| D7 | **Accepted deviation** — bare leading icons preserve divider inset. |
| D8 | **Accepted deviation** — outlined destructive button; same action, 48 dp target. |
| D9 | **Out of scope** — frame-only extras are FUTURE and not implemented. |
| D10 | **Frame artifact** — `settings_light.png` is dark; light render follows true light tokens. |
| D11 | **Accepted deviation** — `Account` title from existing l10n key; no search/avatar capability. |
| D12 | **Deferred** — global button-radius token would touch screens outside Phase 2. |
| D13 | **Frame artifact** — `account_dark.png` has a light canvas; dark render follows the frozen dark pair. |

No deviation required a test change, and none was made. Phase 3 remains blocked
pending explicit owner acceptance.
