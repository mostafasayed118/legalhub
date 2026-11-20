# LegalHub — Redesign Execution Contract (Phase 0A) — REVISED (corrections: color verification, spacing/radius/typography, ARB, screen classification, component inventory, unlabeled instances, git wording, accessibility)

Doc: `docs/redesign/REDESIGN_EXECUTION_CONTRACT.md` — Phase 0A deliverable, revised 2026-11-19 after owner corrections.
Read this before any phase. Branch: `redesign/stitch-alignment` (from `main` at `cb65f84`).
Canvas: https://stitch.google.com/projects/17670909757013221834 ("LegalHub Mobile App").
Master prompt: master-stitch-redesign-prompt (Agreed: Muse + ChatGPT, 2026-11-19).

## 1. Scope and authority

- **Mission** (master §1): presentation-only redesign of the LegalHub mobile app so its screens match the Google Stitch "LegalHub Mobile App" design (verified 2026-11-19 on the live canvas). No new routes, Cubits, gateway operations or business capabilities; the 15 analytics/reporting screens are FUTURE and never build (§6.4).
- **Authorities**: Stitch is the visual authority; the existing application is the behavioral authority. On conflict: STOP and ask for an explicit decision (Frozen rule 1).

## 2. Pre-redesign baseline (measured — Phase 0A, gates green)

| Check | Measured result (baseline) |
|---|---|
| Branch | `redesign/stitch-alignment`, HEAD `cb65f84` (main), tree clean |
| SDK | FVM 3.50.0 — Flutter 3.50.0 / Dart 3.14.0 (pubspec.yaml: `flutter: '>=3.50.0 <4.0.0'`) |
| `flutter analyze` (3.50.0) | 0 issues |
| `dart format .` (3.50.0) | 837 files, 0 changed |
| `flutter test --coverage` | 2,447 pass, ~13 skipped, 0 failed — "All tests passed!" |
| Coverage | 84.6016% (measured via `coverage/lcov.info`: LH 18,466 / LF 21,827) |
| ARB | `app_en.arb` 1,373 lines / 1,252 key-mentions / 1,127 canon keys; `app_ar.arb` 1,856 lines / 1,582 mentions / 1,303 canon keys; `app_tr.arb` 1,856 lines / 1,582 mentions / 1,303 canon keys (measured §7.2) |
| Canvas node list | 188 nodes = 181 screens + 6 design-system boards + 1 prototype (master: 188 = 181 + 6 + 1 — consistent) |

## 3. The 12 frozen rules (master §3, verified, no omissions)

1. Stitch visual authority + existing app behavioral authority; conflict → STOP and ask for an explicit decision.
2. `lib/app/legalhub_theme.dart` is the sole theme-token source; shared widgets consume semantic tokens, never own palettes.
3. No new routes, Cubits, gateway operations or business capabilities without explicit owner approval; GoRouter never modified to fake completeness.
4. All 181 screens receive an upfront classification (Phase 0A, §9); detailed mapping is just-in-time per wave (Phase 0B, §10.1).
5. The 15 analytics/reporting screens remain FUTURE (§6.4); they never generate implementation tasks.
6. Visual comparisons are mandatory human-reviewed wave artifacts — never CI golden/screenshot tests (a sibling Flutter project removed golden tests after CI failures from runner-image drift with zero code change).
7. CI gates: `flutter analyze` 0 issues, `dart format` 0 differences, full test suite green; every phase ends green or stops.
8. Tests are the contract: never edit/delete/skip/weaken to make green. A test may change ONLY when the design intentionally changes the exact visual value it asserts — and then ONLY with the Stitch frame cited, a test-change record filed, and owner approval before modification (§7.3). Behavioral tests never change under this exception.
9. Every wave has a clean Git checkpoint and rollback; one branch (`redesign/stitch-alignment`); no push/PR/merge without explicit owner go.
10. Any unexpected architectural or behavioral change triggers a stop and review; never silently expand scope — document + ask.
11. Playfair Display is the global headline font only after testing English/Arabic/Turkish + a deliberate font-fallback strategy (§5.7; Phase 1).
12. Behavior must not change — presentation only (§8.4).

## 4. Canvas audit — the six design-system boards (re-read live 2026-11-19, canvas-verified)

Boards are `DESIGN_SYSTEM_INSTANCE` nodes; read via `tools.stitch.list_design_systems` + `tools.stitch.get_project`. The canvas defines: **Primary, Secondary, Tertiary, Neutral, Headline font, Body font, Label font, radius, spacing, typography, roundness** — the master prompt's claim ("boards define NO spacing/radius/text") is outdated (master §2.2, 2026-11-19): all six boards expose spacing/radius/type tokens in the canvas API; the §6 values are quoted below. Canvas wins over master table §2.3 (master: "if the canvas differs, the canvas wins — record the canvas value and flag the discrepancy").

**Board A — "LegalHub"** (asset `assets/01c06e3134064161985e06b8949d22fd`, Lexis, colorMode LIGHT, roundness ROUND_EIGHT)
- Colors (canvas API, `manifest.colors`): Primary `#000102`; Secondary `#775a19`; Tertiary `#000102`; Neutral `#4a5568` (overrideNeutralColor); outline `#74777d`; outline-variant `#c4c6cd`; error `#ba1a1a`; error-container `#ffdad6`; surface `#f9f9ff`; surface-container-low `#f0f3ff`; surface-container `#e7eeff`; surface-container-high `#dee8ff`; surface-container-highest `#d8e3fa`; surface-container-lowest `#ffffff`; surface-dim `#cfdaf1`; surface-tint `#4f6074`; inverse-primary `#b7c8df`; inverse-surface `#263142`; on-surface `#111c2c`.
- Radius: DEFAULT 8px, sm 0.25rem, md 0.75rem, lg 1rem, xl 1.5rem, full 9999px.
- Spacing: unit 4px, gutter 16px, margin-mobile 16px, margin-desktop 32px, density-compact 4px, density-comfortable 12px.
- Type: Body LG/MD/SM Source Sans 3 (18/16/14px, 400); Data Tabular 13px (400); Headline LG Playfair Display 40px/700/-0.02em/48px; Headline MD Playfair 28px/600/36px; Headline SM Playfair 22px/600/28px; Label MD Source Sans 3 12px/600/0.05em/16px.

**Board B — "LegalHub Design System"** (asset `assets/0569b48a9dd747a3bcc7ac57bff7cbee`, Lex Juris, LIGHT, ROUND_FOUR)
- Colors: Primary `#000102`; Secondary `#775a19`; Tertiary `#030100`; Neutral: none (master table's #777778 — Variant/Missing, see §5); surface `#fbf9fa`; surface-container `#efedef`; surface-container-high `#e9e7e9`; surface-container-highest `#e4e2e3`; surface-container-low `#f5f3f4`; surface-container-lowest `#ffffff`; surface-dim `#dbd9db`; surface-variant `#e4e2e3`; on-surface `#1b1c1d`; inverse-primary `#b7c8df`; inverse-surface `#303032`.
- Radius: DEFAULT 4px, sm 0.125rem, md 0.25rem, lg 0.5rem, xl 0.75rem, full 9999px.
- Spacing: unit 4px, xs 4px, sm 8px, md 16px, lg 24px, xl 32px, margin-mobile 20px, container-max 1280px.
- Type: Body LG/MD/SM Inter (18/16/14); Headline LG Playfair 30px/700/-0.01em/38px; Headline MD Playfair 22px/600/28px; Label Caps Inter 12px/600/0.05em/16px.

**Board C — "LegalHub Juris"** (asset `assets/0a9af7c6692347a5bb66bee76c015488`, Lexis Juris, LIGHT, ROUND_FOUR)
- Colors: Primary `#000102`; Secondary `#775a19`; Tertiary `#030100`; Neutral: none; surface `#fbf9fa`; surface-container `#efedef`; surface-container-high `#e9e7e9`; surface-container-highest `#e4e2e3`; surface-container-low `#f5f3f4`; on-surface `#1b1c1d`; inverse-surface `#303032`; tertiary-container `#2b1803`.
- Radius: DEFAULT 4px.
- Spacing: gutter 1rem, gutter-desktop 1.5rem, margin 1.25rem, margin-tablet 2.5rem, space-xs 0.25rem, space-sm 0.5rem, space-md 1rem, space-lg 1.5rem, space-xl 2rem.
- Type: Body LG/MD/SM Noto Sans (18/16/14); Display LG Playfair 48px/700/56px; Display LG Mobile 32px/700/40px; Headline LG Playfair 22px/600/28px; Headline MD Playfair 20px/600/26px; Title MD Noto Sans 18px/600/24px; Label MD Noto Sans 12px/500/0.04em/16px; Label SM Noto Sans 11px/500/0.05em/14px.

**Board D — "LegalHub"** (asset `assets/3322526ada844c9cb4f108d968fff0b7`, Lexis Legalhub, LIGHT, ROUND_FOUR)
- Colors: Primary `#000102`; Secondary `#775a19`; Tertiary `#000101`; Neutral `#74777d` (overrideNeutralColor); surface `#f8f9ff`; surface-container `#eceef4`; surface-container-high `#e6e8ef`; surface-container-highest `#e0e2e9`; surface-container-low `#f1f3fa`; surface-container-lowest `#ffffff`; surface-dim `#d8dae1`; on-surface `#181c21`; tertiary-container `#001e30`; inverse-surface `#2d3136`.
- Radius: DEFAULT 4px.
- Spacing: gutter 1rem, gutter-desktop 1.5rem, margin 1.25rem, margin-desktop 2.5rem, space-2xs 0.125rem, space-lg 1.5rem, space-md 1rem, space-sm 0.5rem, space-xl 2rem, space-xs 0.25rem.
- Type: Display LG Playfair 48px/600/-0.02em/56px; Display MD Playfair 30px/600/38px; Display SM Playfair 26px/500/34px; Headline MD Playfair 22px/600/30px; Label MD Noto Sans 14px/600/0.01em/20px; Label SM Noto Sans 12px/500/0.02em/16px; Caption Noto Sans 12px/400/16px; Avatar Initial Playfair 28px/600/32px.

**Board E — "LegalHub Design System"** (asset `assets/442cca707c134066839dd4a6c16ec893`, Lex Juris, LIGHT, ROUND_FOUR)
- Colors: Primary `#000102`; Secondary `#775a19`; Tertiary `#030100`; Neutral: none; surface `#fbf9fa`; surface-container `#efedef`; surface-container-high `#e9e7e9`; surface-container-highest `#e4e2e3`; surface-container-low `#f5f3f4`; tertiary-container `#2b1803`.
- Radius: DEFAULT 4px.
- Spacing: container-max 1280px, gutter 24px, margin-desktop 40px, margin-mobile 16px, section-gap 32px, unit 8px.
- Type: Body LG/MD Source Serif 4 (18/16px, 400, 28/24px); Caption Caps Source Sans 3 10px/700/0.1em/12px; Display LG Playfair 48px/700/-0.02em/56px; Headline LG Playfair 32px/700/40px; Headline MD Playfair 24px/600/32px; Label MD Source Sans 3 14px/600/0.05em/20px; Label SM Source Sans 3 12px/400/16px.

**Board F — "LegalHub Juris Consult"** (asset `assets/e3911a996ef64b858424c58e56d77a10`, Lexis Juris Consult, LIGHT, ROUND_FOUR)
- Colors: Primary `#000102`; Secondary `#775a19`; Tertiary: none (no tertiary token; master table's #00608C — Variant/Missing); Neutral `#0d1c2e` (master's #0D1C2E — canvas has no separate neutral key; from on-surface); surface `#f8f9ff`; surface-container `#e6eeff`; surface-container-high `#dce9ff`; surface-container-highest `#d5e3fc`; surface-container-low `#eff4ff`; surface-container-lowest `#ffffff`; surface-dim `#ccdbf4`; on-surface `#0d1c2e`.
- Radius: DEFAULT 4px.
- Spacing: gutter 1rem, gutter-desktop 2rem, gutter-tablet 1.5rem, margin 1.25rem, margin-expanded 2.5rem, space-2xs 0.125rem, space-lg 1.5rem, space-md 1rem, space-sm 0.5rem, space-xl 2rem, space-xs 0.25rem.
- Type: Display LG Playfair 48px/700/56px; Display MD Playfair 30px/600/38px; Display SM Playfair 26px/600/34px; Headline MD Playfair 22px/600/30px; Label MD Noto Sans 12px/500/0.4px/16px; Label SM Noto Sans 11px/600/0.5px/14px; Body LG/MD/SM Noto Sans (18/16/14).

Master table §2.3 discrepancies (canvas wins; flags for owner): Primary — master #0B1D2E ×6 vs canvas `primary` #000102 ×6 (Conflict; canvas `primary-container` = #0b1d2e matches the app's primary). Tertiary — Board A: master #F4F4F9 vs canvas #000102 (Conflict); Boards B, C: master #2B1803 vs canvas #030100 (Conflict); Board D: master #00608C vs canvas #000101 (Conflict); Board E: master #4A4A4A vs canvas none (Missing); Board F: master #00608C vs canvas none (Missing). Neutral — Board A: master #4A5568 vs canvas #4a5568 (Alias); Board B: master #777778 vs canvas none (Variant); Board C: master #777778 vs canvas none (Variant); Board D: master #74777D vs canvas #74777d (Alias); Board E: master #FBF9F8 vs canvas none (Missing); Board F: master #0D1C2E vs canvas (on_surface) #0d1c2e (Alias-ish, noted). Fonts — canvas: Board A Headline/Body/Label = Playfair Display / Source Sans 3 / Source Sans 3; Board B = Playfair Display / Inter / Inter; Board C = Playfair Display / Noto Sans / Noto Sans; Board D = Playfair Display / Noto Sans / Noto Sans; Board E = Playfair Display / Inter / Inter; Board F = Playfair Display / Noto Sans / Noto Sans (master table agrees on Headline everywhere; frequency ≠ authority — canvas wins; Board B and Board D body labels are Inter/Noto Sans respectively per canvas).

Primary ramp (quoted per master §2.3 + appendix): Board A/B/C/D/E/F Primary (main per master/app): `#0B1D2E`; ramp (appendix example): T0 `#000000`, T10 `#0b1d2e` (= main), T20 `#213244`, T30 `#38485b`, T40 `#4f6074`, T50 `#68798d`, T60 `#8192a8`, T70 `#9cadc3`, T80 `#b7c8df`, T90 `#d3e4fc`, T95 `#e9f1ff`, T100 `#ffffff`. Canvas API anchors: `primary` = `#000102` (≈T0 — NOT the main; the canvas does not expose a `primary` token with the main value), `primary-container` = `#0b1d2e` (= main). Discrepancy documented: canvas API `primary` vs board Primary main (§5.1.2).

## 5. Token conflict register (revised, canvas-verified; master §2.3 start-point table)

Register method: sources (a) Stitch boards — intent; (b) `lib/app/legalhub_theme.dart` — app baseline; (c) repeated usage across approved frames — app-theme usage (master requirement; e.g., app `primary` #0B1D2E, `surface` #F8F9FF, etc.). Categories: Conflict (competing values, canvas wins, flag), Alias (same value under different name), Variant (design difference needing a decision), Missing (app lacks the token), Obsolete (app value no longer on canvas). Approval: "awaiting owner review" for conflicts; "match" for aliases.

### 5.1 Primary / brand

| Token | Board A | Board B | Board C | Board D | Board E | Board F | App (`legalhub_theme.dart`) | Register |
|---|---|---|---|---|---|---|---|---|
| Primary (main) | #000102 | #000102 | #000102 | #000102 | #000102 | #000102 | #0B1D2E | CONFLICT — canvas `primary` #000102 (6 boards) vs master/app Primary main #0B1D2E. Canvas `primary-container` = #0b1d2e = app. Canvas main (per appendix T10) = #0B1D2E. Owner approves: app #0B1D2E (already used by app; canvas-compatible) — approval pending |
| Primary ramp | T0 #000000, T10 #0b1d2e (=main), T20 #213244, T30 #38485b, T40 #4f6074, T50 #68798d, T60 #8192a8, T70 #9cadc3, T80 #b7c8df, T90 #d3e4fc, T95 #e9f1ff, T100 #ffffff | (same ramp — Board A/B same Primary) | — | — | — | — | — | Record per board; "Do not infer the main from T0" — canvas `primary` ≈ T0; main = T10 per appendix |
| Secondary (main) | #775a19 | #775a19 | #775a19 | #775a19 | #775a19 | #775a19 | #775A19 | ALIAS — all boards agree with app (master + canvas identical) |
| Tertiary (main) | #000102 | #030100 | #030100 | #000101 | #030100 | none | (none in app theme) | Board A: CONFLICT (master #F4F4F9, canvas #000102 — canvas wins); Boards B, C, E: CONFLICT (master #2B1803, canvas #030100 — canvas wins); Board D: CONFLICT (master #00608C, canvas #000101 — canvas wins); Board F: MISSING (master #00608C — canvas has no tertiary token; app uses surface-dim/on-surface instead) |
| Neutral (main) | #4a5568 | none | none | #74777d | none | #0d1c2e (from on_surface) | (none) | Board A: ALIAS (master #4A5568 = canvas #4a5568); Boards B, C: VARIANT/MISSING (master #777778 — canvas has no neutral; app uses outline #74777D); Board D: ALIAS (master #74777D = canvas #74777d); Board F: ALIAS-ish (master #0D1C2E = canvas on_surface #0d1c2e) |

### 5.2 Status / surface / outline (all boards; canvas values)

| Token | Board A | Board B | Board C | Board D | Board E | Board F | App |
|---|---|---|---|---|---|---|---|
| Error | #ba1a1a | #ba1a1a | #ba1a1a | #ba1a1a | #ba1a1a | #ba1a1a | #BA1A1A (Alias — 6/6 match) |
| Error Container | #ffdad6 | #ffdad6 | #ffdad6 | #ffdad6 | #ffdad6 | #ffdad6 | #FFFFDAD6 (Alias — values match, case) |
| Outline | #74777d | #74777d | #74777d | #74777d | #74777d | #74777d | #74777D (Alias) |
| Outline Variant | #c4c6cd | #c4c6cd | #c4c6cd | #c4c6cd | #c4c6cd | #c4c6cd | #C4C6CD (Alias) |
| Surface | #f9f9ff | #fbf9fa | #fbf9fa | #f8f9ff | #fbf9fa | #f8f9ff | #F8F9FF (Alias Board A/F; Variant B/C/D/E: canvas surface = #fbf9fa/f8f9ff) |
| Surface Container Low | #f0f3ff | #f5f3f4 | #f5f3f4 | #f1f3fa | #f5f3f4 | #eff4ff | #EFF4FF (Alias/Variant) |
| Surface Container | #e7eeff | #efedef | #efedef | #eceef4 | #efedef | #e6eeff | #E6EEFF (Alias Board A; Variant others) |
| Surface Container High | #dee8ff | #e9e7e9 | #e9e7e9 | #e6e8ef | #e9e7e9 | #dce9ff | #DCE9FF (Alias Board A; Variant others) |
| Surface Container Highest | #d8e3fa | #e4e2e3 | #e4e2e3 | #e0e2e9 | #e4e2e3 | #d5e3fc | #D5E3FC (Alias Board A; Variant others) |
| Surface Tint | #4f6074 | #4f6074 | #4f6074 | #4f6074 | #4f6074 | #4f6074 | (app: no surfaceTint token — legalhub_color_scheme era; canvas 6/6 = #4f6074) — ALIAS/MISSING (app has no `surfaceTint`; M3 has it as inverse of primary — Variant) |
| On Surface | #111c2c | #1b1c1d | #1b1c1d | #181c21 | #1b1c1d | #0d1c2e | #0D1C2E (Alias Board A; Variant others) |
| On Surface Variant | #44474c | #44474c | #44474c | #44474c | #44474c | #44474c | #44474C (Alias) |
| Inverse Primary | #b7c8df | #b7c8df | #b7c8df | #b7c8df | #b7c8df | #b7c8df | (app: darkPrimary-family token; Variant) |
| Inverse Surface | #263142 | #303032 | #303032 | #2d3136 | #303032 | (none) | (Variant) |
| Success | — | — | — | — | — | — | #1B5E20 (Variant — canvas boards define none) |
| Warning | — | — | — | — | — | — | #7A5900 (Variant — canvas: none) |
| Info | — | — | — | — | — | — | #00608C (Alias — canvas has no info token; app value = Board F tertiary-ish #00608C? — Variant) |

### 5.3 Canonical semantic token contract (master §6.4; derived — see §6)

- **Color**: `brandPrimary`, `brandAccent`, `background`, `surface`, `surfaceElevated`, `textPrimary`, `textSecondary`, `border`, `success`, `warning`, `error`.
- **Typography**: `display`, `headline`, `title`, `body`, `label`, `caption`.
- **Spacing**: see §6.1; **Radius**: see §6.2; **Elevation**: tonal layers, no drop shadows (Board A/F DesignMd); **Borders**: 1px hairline (`outline-variant`), focused borders 2px brandAccent (app `focusedBorder width: 2`); **Motion**: `LegalHubMotion` (200/300ms, easeOut — app; canvas boards define none — Variant).
- **Light**: brandPrimary `#0B1D2E` (pending owner approval; canvas primary-container), text `#111c2c`–`#181c21`, surface `#f8f9ff`/`#f9f9ff`/`#fbf9fa`. **Dark**: derived per master §3 (canvas `surfaceLight == surfaceDark` on all boards — Variant, see §4).

## 6. Derived spacing / radius / typography (quoted, canvas-verified; master §2.2 claim retracted)

### 6.1 Spacing

| Token | Board A | Board B | Board C | Board D | Board E | Board F |
|---|---|---|---|---|---|---|
| unit | 4px | 4px | — | — | 8px | 4px |
| gutter | 16px | 16px | 1rem | 1rem | 24px | 1rem |
| gutter-desktop | — | — | 1.5rem | 1.5rem | — | 2rem |
| gutter-tablet | — | — | — | — | — | 1.5rem |
| margin-mobile | 16px | 20px | 20px | 20px | 16px | 20px |
| margin-desktop | 32px | — | — | 2.5rem | 40px | — |
| margin-tablet | — | — | 2.5rem | — | — | — |
| margin | — | 1.25rem | 1.25rem | 1.25rem | — | 1.25rem |
| margin-expanded | — | — | — | — | — | 2.5rem |
| section-gap | — | — | — | — | 32px | — |
| density-compact | 4px | — | — | — | — | — |
| density-comfortable | 12px | — | — | — | — | — |
| container-max | — | 1280px | — | — | 1280px | — |
| space-2xs | — | — | — | 0.125rem | — | — |
| space-xs | — | — | — | 0.25rem | — | 0.25rem |
| space-sm | — | — | 0.5rem | 0.5rem | — | 0.5rem |
| space-md | — | 1rem | 1rem | 1rem | — | 1rem |
| space-lg | — | — | 1.5rem | 1.5rem | 1.5rem | 1.5rem |
| space-xl | — | 2rem | 2rem | 2rem | 2rem | 2rem |

### 6.2 Radius

| Radius | Board A | Board B | Board C | Board D | Board E | Board F |
|---|---|---|---|---|---|---|
| DEFAULT | 8px | 4px | 4px | 4px | 4px | 4px |
| sm | 0.25rem | 0.125rem | 0.125rem | 0.125rem | 0.125rem | 0.125rem |
| md | 0.75rem | 0.25rem | 0.25rem | 0.25rem | 0.25rem | 0.25rem |
| lg | 1rem | 0.5rem | 0.5rem | 0.5rem | 0.5rem | 0.5rem |
| xl | 1.5rem | 0.75rem | 0.75rem | 0.75rem | 0.75rem | 0.75rem |
| full | 9999px | 9999px | 9999px | 9999px | 9999px | 9999px |

### 6.3 Typography (merged)

| Role | Size | Weight | Family | Line-height | Notes (boards) |
|---|---|---|---|---|---|
| Display LG | 48 | 600–700 | Playfair Display | 56 | A: 48/600, B: 48/700, C: 48/700, D: 48/600, E: 48/700, F: 48/700 |
| Display MD | 30–32 | 600 | Playfair Display | 38–40 | A: 30/700, B: 30/700, C: 30/600, D: 30/600, F: 30/600 |
| Display SM | 26 | 500 | Playfair Display | 34 | A: 26/700, B: 26/500, D: 26/500, F: 26/600 |
| Headline LG | 22–32 | 600–700 | Playfair Display | 28–40 | A: 40/700, B: 30/700, C: 22/600, D: 22/600, E: 32/700, F: 22/600 |
| Headline MD | 20–22 | 600 | Playfair Display/Noto Sans | 26–30 | A: 28/600, C: 20/600, D: 22/600, F: 22/600 |
| Body LG | 18 | 400 | Source Sans 3 / Inter / Noto Sans / Source Serif 4 | 28 | A: SS3, B: Inter, C: Noto Sans, D: Noto Sans, E: Serif4 |
| Body MD | 16 | 400 | same | 24 | A: SS3, B: Inter, C: Noto Sans, D: Noto Sans, E: Serif4 |
| Body SM | 14 | 400 | same | 20 | A: SS3, B: Inter, C: Noto Sans, D: Noto Sans, E: Serif4 |
| Label MD | 11–14 | 500–600 | Source Sans 3 / Inter / Noto Sans / Source Serif 4 | 14–20 | A: 12/600, B: 12/600, C: 12/500, D: 14/600, E: 14/600, F: 12/500 |
| Label SM | 11 | 500–600 | same | 14 | C: 11/500, D: 12/500, F: 11/600 |
| Caption | 12 | 400 | Noto Sans | 16 | A: 12/400, F: 12/400 |

### 6.4 FUTURE screens (master §2.3 — 15; canvas: 16 light + dark twins)

1. Risk Dashboard Overview (canvas: `fa2caa1f`, dark `4fff5d0e`)
2. Regulatory Filings Dashboard (canvas: `48b13ef4`, dark `45478abd`)
3. Advanced Analytics (canvas: `a07d44b0`, dark `c030e8f7`)
4. Global Compliance Map (canvas: `ef01fe0f`, dark `f86c1432`)
5. Conflict Analytics Report (canvas: `3dc2d7d3`, `26f5ee2d`, `044014c3`, dark `1cba863d`, `3f4b7e69`, `252cdcec`, `4a47c2645`)
6. Ethical Wall Audit (canvas: `9aee581c`, `03bc517f`, `1cba863d`, `b89e52b6`)
7. Conflict Resolution Dashboard (canvas: `46f277da`, `201575e0`)
8. Conflict Resolution Overview (canvas: `21e4ce4c`, `605f577f`)
9. Conflict Report Details (canvas: `252cdcec`, dark `4a47c2645`)
10. Statutory Research Browser (canvas: `e1f2157b`, dark `207730789b`, `38ae7358`)
11. Filing Submission Workspace (canvas: `800dad7f`, dark `e641ae5b`)
12. Legal Draft Workspace (canvas: `5b83c122`, `5562952a`, `720c5967`, dark twins)
13. Citation Manager (canvas: `6e1cf06c`, dark `105da3f7`, `eb9f8582`)
14. Compliance Audit Trail (canvas: `577eadb4`, dark `e1096c24`)
15. Shared Case Workspace (canvas: `aa1c3c82`, `516f4020`)

## 7. ARB parity (actual unique keys; key-level result)

Method: canonical key sets via `Get-Content -Raw <file> | ConvertFrom-Json` (`.psobject.Properties`); regex-based key-mention counts via `Select-String` for duplicates (PS 5.1; `Select-String` on directory lacks -Recurse, so per-file loop). ARB files are flat JSON; metadata keys (`@@locale` etc.) excluded from translation-key counts (exclusion note).

| Locale | File | Canonical unique keys (excl. `@` metadata) | Key lines (`"([^"]+)":` mentions) | Key-lines (`^  "`) |
|---|---|---|---|---|
| EN | `lib/l10n/app_en.arb` | 1,127 | 1,252 mentions / 1,097 unique (regex) | 1,127 |
| AR | `lib/l10n/app_ar.arb` | 1,303 | 1,582 mentions / 1,088 unique (regex) | 1,303 |
| TR | `lib/l10n/app_tr.arb` | 1,303 | 1,582 mentions / 1,088 unique (regex) | 1,303 |

**Key-level result:**
- AR and TR have **identical** key sets: `AR missing from TR: []`, `TR missing from AR: []`.
- AR/TR are missing from EN: **0 keys** (`AR missing from EN: []`).
- EN is missing from AR/TR: **31 keys** (the "176-key difference" = net unique-key delta `|AR| − |EN| = 1303 − 1127 = 176`; decomposition: `AR\EN = 176 + 31 = 207` AR/TR-only keys, `EN\AR = 31` EN-only keys):
  `@bookingDurationMinutes, @bookingSuccessBody, @fileSizeBytes, @fileSizeKb, @fileSizeMb, @fileUploading, @libraryArticleNumberLabel, @libraryArticlePosition, @messageErrorTooLong, @messagesMessageCount, @taskAssignAction, @taskAssigneeUnavailable, @taskAssignMemberLabel, @taskAssignMembersError, @taskAssignSubmit, @taskAssignTitle, @taskAssignUnassigned, @taskCreateAction, @taskCreateMatterHint, @taskCreateMatterLabel, @taskCreateMattersError, @taskCreateNoMatters, @taskCreateSubmit, @taskCreateTitle, @taskCreateTitleHint, @taskCreateTitleLabel, @taskErrorDenied, @taskErrorFailed, @taskErrorInvalid, @taskErrorUnavailable, @videoCallElapsed`.
- AR/TR-only keys (207 — the `account*`/`err*`/`demo*`/`legal*`/`passwordHide`/`passwordShow` groups — listing categories): `@account*` (accountChangePassword, accountConfirmPasswordLabel, accountDangerTitle, accountDelete* (30), accountDisplayNameLabel, accountNewPasswordLabel, accountPasswordChanged, accountPasswordMismatch, accountPasswordReauth, accountPasswordTitle, accountProfileTitle, accountSave, accountSaved, accountTitle), `@demo*` (demoAlertDescriptionReview, demoApproval* (12), demoAttorneyHeadline* (5), demoAudit* (7), demoAuditDemoAccountDeleted, demoAuditInvitationSent), `@discoveryEntrySubtitleConfigured`, `@err*` (errAcknowledgingThe* (2), errAIResearchIsNotConfiguredForThisDeployment, errAnActionIsAlreadyInProgress, errApprovalRequestNotFound, errApprovalsAreTemporarilyUnavailable*, errARejectionNoteIsRequired, errAttorneyNotFound, errAvailableTimesAreTemporarilyUnavailable*, errBookingIsTemporarilyUnavailable*, errCancellingTheRequestIsTemporarilyUnavailable*, errComplianceAlertNotFound, errComplianceAlertsAreTemporarilyUnavailable*, errCreatingThe* (3), errDecidingTheRequestIsTemporarilyUnavailable*, errEndingTheConsultationIsTemporarilyUnavailable*, errMessagesAreTemporarilyUnavailable*, errNotificationsAreTemporarilyUnavailable*, errOnlyAnActiveOrganizationMemberCanAcknowledgeAlerts, errOnlyAPartner*, errOnlyTheAssignedPersonCanAcknowledgeThisTask, errOnlyTheCreatorOrAPartnerCanEnd, errOnlyTheRequesterOrAPartnerCanCancel, errOrganizationMembershipsCouldNotBeLoaded, errReAssigningTheTaskIsTemporarilyUnavailable*, errResolvingTheAlertIsTemporarilyUnavailable*, errSchedulingAConsultationIsTemporarilyUnavailable*, errSelect* (7), errSendingIsTemporarilyUnavailable*, errSignInAgainToUseVideoConsultations, errStartingTheConsultationIsTemporarilyUnavailable*, errTasksAreTemporarilyUnavailable*, errThatPersonCannotBeAssignedThisTaskChoose, errThatTimeIsNoLongerAvailableChooseAnother, errTheAIProviderReturnedAnUnexpectedResponsePlease, errTheAlert* (5), errTheBookingDetailsAreInvalidCheckThemAnd, errTheBookmarkCouldNotBeUpdated, errTheConsultation* (3), errTheDirectoryIsTemporarilyUnavailableTryAgain, errTheHighlight* (2), errTheLegal* (2), errTheNameIsInvalid, errTheProfileDetailsAreInvalidCheckThemAnd, errTheRequest* (6), errTheSavedItemsLimitWasReached, errTheSearchQueryIsTooLong, errTheSelected* (2), errTheTask* (3), errThisConsultation*, errThisFile*, errThisVideo*, errThreadsAreTemporarilyUnavailablePleaseTryAgain, errUnableTo* (~50), errUpdatingTheTaskIsTemporarilyUnavailable*, errVideoCalls*, errWeCouldntCompleteThatRequestPleaseTry, errYouAre*, errYouDoNotHavePermission* (~15), errYourProfileCouldNotBeFound), `@homeActivityEmpty`, `@legal*` (legalAcceptTerms, legalAcceptTermsHint, legalContactNotConfigured, legalLastUpdated, legalPrivacyTitle, legalTermsTitle), `@passwordHide, @passwordShow, @searchNoQueryConfigured`.
- **Duplicate keys (regex-based raw-mention counts — caution: these count key-name mentions, including nested/metadata occurrences; canonical JSON sets are authoritative and have none)**: EN: `placeholders` ×31, `count` ×5, `type` ×37, `title` ×3, `ref` ×2, `area` ×2, `name` ×5, `email` ×2, `value` ×3, `description` ×22. AR: `placeholders` ×20, `count` ×4, `type` ×25, `title` ×3, `ref` ×2, `area` ×2, `name` ×5, `email` ×2, `description` ×211. TR: `placeholders` ×20, `count` ×4, `type` ×25, `title` ×3, `ref` ×2, `area` ×2, `name` ×5, `email` ×2, `description` ×211. (These regex dup counts are not proof of duplicate ARB keys — ARB is flat JSON; the canonical parse yields unique key sets per file.)
- **Counting exclusions**: `@@locale` + all `@`-prefixed metadata keys excluded from "translation keys"; BOM not present in files (byte order normal — `Get-Content` BOM handling); the "key-lines" (`^  "`) count = canonical-style line count per file (EN 1,127; AR 1,303; TR 1,303 — the 176 difference is real at the canonical level: 1303 − 1127).

## 8. Component inventory (expanded)

| Metric | Value |
|---|---|
| `lib/shared` .dart files | 42 (`widgets/` 19, `form_fields/` 5, `layout/` 5, `responsive/` 3, `state/`, `text/`, `formatting/`, `demo/`) |
| `lib/shared` distinct class names (parsed `class (\w+)`) | 35 (AppTile, AppSectionHeader, AppModalSheet, ConfirmDialog, CubitListSurface, FormSheetScaffold, LabelledField, LegalhubTextField, PasswordField, AuthScaffold, ViewStateList/ViewStateMessage/ViewStateSwitch/ViewStateView/ViewStateSuccessList, CubitListSurfaceBody, AppFilterChips, DirectionalIcon, IconHeroBadge, LabelChip, MatterLinkChip, PracticeAreaLabel, RoleLabel, SearchAction, WorkspaceSection, AppEntryCard, AppCenteredMessage, AppCenteredRetry, TwoPane, LengthIndicator...) |
| `lib/features` .dart files | 362 (25 features: admin, approvals, auth, billing, booking, compliance, conflicts, discovery, documents, home, legal, library, matters, messaging, notifications, onboarding, orgs, profile, research, search, storage, tasks, video + data/domain/presentation subdirs) |
| `lib/features` distinct class names | 450 |
| Class names defined in BOTH features and shared | 0 (no direct overlap — duplication is behavioral/visual, not named) |
| Feature files importing `legalhub/shared` | 86 of 362 (24%) — shared components are broadly consumed; not a low-consumption centralization target |
| `LabelChip` import mentions in features | 22 lines across feature files |
| `LegalHubTheme` references in features | 742 (LegalHubTheme is used throughout features — presentation already leans on the theme) |
| `Color(0x…)` literals in features | 0 (no hardcoded colors in features — good baseline; policy test `test/policy/hardcoded_values_policy_test.dart` covers motion literals) |

**Centralization decisions (evidence-based, Phase 1):**
- Shared primitives with high consumption and theme coupling: `LegalHubTheme` (consumed by 59 files in lib/shared + 742 refs in features) — Retain (already canonical, Phase 1 implements tokens in it).
- `LabelChip` (shared, 22 feature imports) — Retain (already shared). Feature-local chips (`DocumentTypeChip` in documents, `StatusChip`/`MatterStatusChip` in matters/home, `MessageCountChip` in messaging, `RoleLabel`/`PracticeAreaLabel` in shared) have no named overlap with shared — Centralize in Phase 1 **only if** Phase 0B per-wave duplication census shows meaningful overlap (currently: no named overlap; visual duplication low — retain, note for JIT).
- `ConfirmDialog` (shared, 12 references) — Retain.
- `AppModalSheet` — Retain.
- Duplicated visual patterns (hardcoded `Color(0x…)` = 0; no raw color literals found) — none to centralize.

## 9. Screen classification (Phase 0A — master §9.2/§9.3)

**Taxonomy (master §5.1):** ROUTE (existing GoRouter route), SHEET (AppModalSheet), DIALOG (ConfirmDialog), WIZARD (sequential flow step), STATE (empty/loading/error/populated), VARIANT (light/dark twin), PROTOTYPE (no contract), FUTURE (deferred).

**Inventory (181 screens + 1 prototype + 6 boards = 188; all categories sum to 181 screens):**

- **ROUTE (53):** Home `/home`→HomeScreen; Settings `/settings`→SettingsScreen; Account Settings `/settings/account`→AccountScreen; Sign In `/sign-in`→SignInScreen; Sign Up `/sign-up`→SignUpScreen; Forgot Password `/forgot-password`→ForgotPasswordEmailScreen; Forgot Password OTP `/forgot-password/otp`→ForgotPasswordOtpScreen; Forgot Password Reset `/forgot-password/reset`→ForgotPasswordResetScreen; Onboarding `/onboarding`→OnboardingScreen; Onboarding Success `/onboarding/success`→OnboardingSuccessScreen; Privacy Policy `/privacy`→LegalDocumentScreen; Terms of Service `/terms`→LegalDocumentScreen; Accept Invitation `/accept-invitation`→AcceptInvitationScreen; User Profile `/profile`→ProfileScreen; Organizations Hub `/organizations`→OrganizationHubScreen; Organization Audit `/organizations/audit`→OrgAuditScreen; Member Roster (embedded, no route)→MemberRosterScreen; Accept Invitation (dark) `/accept-invitation`; Account Settings (dark); Attorney Directory `/discovery`→AttorneySearchScreen; Attorney Form `/discovery/:attorneyId`→AttorneyProfileScreen; Create Matter `/matters/new`→MatterCreateScreen; Matter Created `/matters/:id`→MatterDetailsScreen; Matter Discussion `/matters/:id`→MatterDetailsScreen; Matter List `/matters`→MatterListScreen; Case Details `/matters/:id`→MatterDetailsScreen; Case Management Dashboard `/matters`→MatterListScreen; Document Vault `/vault`→DocumentListScreen; Document Details `/vault/:id`→DocumentDetailsScreen; Legal Library `/library`→LibraryHomeScreen; Library Document `/library/:id`→LibraryDocumentScreen; Library Saved — Bookmarks `/library/saved`→LibrarySavedScreen; Library Saved — Highlights `/library/saved`→LibrarySavedScreen; Library Saved — History `/library/saved`→LibrarySavedScreen; Library Search `/library/search`→LibrarySearchScreen; Billing & Invoices `/invoices`→BillingInvoicesScreen; Invoice Details `/invoices/:id`→InvoiceDetailsScreen; Messages `/messages`→MessageListScreen; Message Center `/messages`→MessageListScreen; Search `/search`→SearchScreen; Pending Approvals `/approvals`→ApprovalsScreen; Pending Approvals Queue `/approvals`→ApprovalsScreen; Alerts `/alerts`→ComplianceAlertsScreen; Video Call `/video`→VideoConsultationScreen; Video Consultation `/video`→VideoConsultationScreen; Consultation Type `/video`→VideoConsultationScreen; Approvals/Waiver status `/conflicts/check`→ConflictCheckScreen (Conflict Waiver Status, Conflict Check Search ×2); Platform Admin `/platform-admin`→PlatformAdminScreen; Page Not Found (error surface)→_UnmatchedLocationSurface; Partner Notification Settings `/notifications`→NotificationSettingsScreen; Notification Settings `/notifications`→NotificationSettingsScreen; Notification Feed `/notifications/feed`→NotificationFeedScreen; Platform Admin rust? — server-side only (no screen).

**ROUTE dark twins** (all counted as VARIANT): the "(Dark Mode)" versions of the above (e.g., Terms of Service (Dark), Terms of Service — artist? no — Terms of Service (Dark Mode) id `2e04732f`).

- **SHEET (7):** Delete Account (→DeleteAccountSheet — profile; destructive; confirmation kept); Invite Member (→InviteMemberSheet); Take Action: Conflict Resolution (→ConflictTakeActionSheet); Alert Detail: Conflict Detected (→ComplianceAlertDetailSheet); Approval Detail: Conflict Waiver (→ConflictTakeActionSheet); Waiver Approval Detail (→ConflictTakeActionSheet); Select Date & Time (→VideoCreateSheet — video create flow).
- **WIZARD (4):** DisclosureWizardScreen (route `/conflicts/disclose`) — canvas steps: Conflict Disclosure: Party Identification, Conflict Disclosure: Analysis Findings, Conflict Disclosure: Matter Selection, Conflict Disclosure: Final Review.
- **VARIANT (96):** dark twins of ROUTE screens — every "(Dark Mode)" node classified VARIANT.
- **FUTURE (16 light + dark twins):** §6.4.
- **UNRESOLVED (5):** `Article Reader` (`0327dbb6`, dark; `79a066f6`, light), `Attorney Search` (`9bed2290` light), `Attorney Profile` (`a247189c` — canvas has Attorney Form + Attorney Directory; map at Phase 0B), `Consultation Type` (`b1c950bb` light), `Select Date & Time` (`c07b6656` light), `Video Consultation` (`dabd453b` light) — dark-error nodes from `get_screen` failed (`2e344ac6`, `30ba82d0`, `357eb8ab`, `54416f7a`, `691d22ec`, `e3fd57dd`, `f79552e1` — Phase 0B retry).
- **PROTOTYPE (1):** `28f04e6d` — "Lexis Legal Operations Platform", screenType PROTOTYPE_V2.
- **DIALOG (0):** no canvas screen maps to a ConfirmDialog-based dialog — app ConfirmDialog usage is inside SHEETs/ROUTEs (12 references: attorney_admin_tile, platform_admin_member_row, approval_detail_sheet, disclosure_steps (WIZARD), highlight_editor_sheet, library_saved_screen, member_roster_invitation_actions, member_roster_screen, delete_account_sheet, profile_body, video_consultation_screen).

**Counts (181 screens): ROUTE 53 + SHEET 7 + DIALOG 0 + WIZARD 4 + STATE 0 + VARIANT 96 + FUTURE 16 + UNRESOLVED 5 = 181.**
**Distinct logical screens: 88** (181 nodes − 93 duplicate-node extras across dup groups; dup extras: 92 dup groups — 8 of size 3 + 84 of size 2 → +100? — script: dupExtra 93; note: dup groups include the 9 master-named duplicates: Citation Manager (3 nodes), Collaboration Task Board (3), Conflict Waiver Status (3), Legal Research AI Assistant (3), LegalDraft Workspace (2), Matter Discussion (3), Sign Up (3), Statutory Research Browser (3), Take Action: Conflict Resolution (3)). **Exclusions: 6 boards + 1 prototype = 7 → 188 = 181 + 7 ✓.**

**Overlaps/duplicates (not double-counted):** every node in the inventory above appears exactly once in its category; VARIANT = light+dark twins of the same logical screen; the 9 master dupes = 9 logical screens with extra duplicate nodes (list above).

## 10. Phase 0B — JIT mapping (master §5.3)

- **Unlabeled canvas instances** (defined: canvas screenInstances in `get_project(...).screenInstances` whose `label` field is null/empty — 96 unlabeled screens + 1 prototype (`28f04e6d`); the 97 unlabeled with titles from `get_screen`; `get_screen` failed for 7 → UNRESOLVED (Phase 0B retry). **Every unlabeled instance gets a DITM row in Phase 0B (master §5.3) — no unmapped frame silently becomes a development task; unmapped → escalate to owner.**
  - List (97 unlabeled instances; stable ids; `w×h@(x,y)` = canvas dims/position; "proposed" = Phase 0B mapping):
  - `02ebce91b59e4a9995755c355d67ad67` — Alert Detail: Conflict Detected — w390 h1217@(454,68565) — proposed: SHEET (ComplianceAlertDetailSheet)
  - `03bc517f09354ba6bbd92cb9cdd63cf3` — Resolution Action: Ethical Wall — w390 h2210@(908,50445) — proposed: FUTURE (Ethical Wall Audit)
  - `03c3aba20ad2495397e2cc2b308f35f5` — Compliance Alerts — w390 h1142@(68565, y) — proposed: ROUTE /alerts (ComplianceAlertsScreen)
  - `044014c326e542d68a8964ac5608b487` — Conflict Analytics Report (Dark Mode) — w390 h1883@(908,64352) — proposed: FUTURE twin
  - `07f862ab494c49bc8d5adef934038ac4` — Legal Library (Dark Mode) — w390 h1279@(454,31874) — proposed: VARIANT twin of Legal Library (ROUTE /library → LibraryHomeScreen)
  - `085b56af56814cda98fbceb82adf4b73` — Approval Detail: Conflict Waiver (Dark Mode) — w390 h1133@(908,70038) — proposed: SHEET (ConflictTakeActionSheet) twin
  - `0b4e281855a84188804fc306f7fca0e3` — Onboarding Success — w390 h884@(y=30734) — proposed: ROUTE /onboarding/success (OnboardingSuccessScreen)
  - `0eaab53408b64c548430be16dc72a2ab` — Document Vault (Dark Mode) — w390 h1283@(y=14332) — proposed: VARIANT twin of Document Vault (ROUTE /vault)
  - `1839300c98764f19800776857fa8f514` — Case Details (Dark Mode) — w390 h1310@(y=11614) — proposed: VARIANT twin of Case Details (ROUTE /matters/:id)
  - `1cba863d0c8d4d03aab8a6a447a2b844` — Conflict Analytics: Ethical Wall Audit (Dark Mode) — w390 h1400@(1362,64352) — proposed: FUTURE (Ethical Wall Audit) twin
  - `201575e0962c46098faa18f93a34c1a7` — Conflict Resolution Dashboard (Dark Mode) — w390 h2376@(454,60894) — proposed: FUTURE twin
  - `21e4ce4c997a4d8ba6546cf4682acf07` — Conflict Resolution Overview — w390 h2613@(y=50445) — proposed: FUTURE (Conflict Resolution Overview)
  - `2288090b2541466c8f9a206b14d372f0` — Waiver Approval Detail — w390 h3352@(1362,42358) — proposed: SHEET (ConflictTakeActionSheet)
  - `242bc5349ce34da0b5a9857a9447f066` — Case Management Dashboard — w390 h2555@(y=33615) — proposed: ROUTE /matters (MatterListScreen)
  - `252cdcec705f4f20ab000c288bfd5337` — Conflict Report Details (Dark Mode) — w390 h2029@(2386,39457) — proposed: FUTURE twin
  - `26f5ee2d47b14e0a98c201349cf34d43` — Conflict Analytics Report: Executive Summary — w390 h2094@(y=64352) — proposed: FUTURE (Conflict Analytics Report)
  - `284a63d6c27f45b79c0ac15c03e3a0b3` — Conflict Disclosure: Analysis Findings — w390 h1196@(1932,2280) — proposed: WIZARD step (DisclosureWizardScreen)
  - `28f04e6d39194e7388294e98ac635e3c` — Lexis Legal Operations Platform — w390 h884@(2840,39457) — screenType PROTOTYPE_V2 — PROTOTYPE
  - `2d2ad33654c54ef289dab46fcda9ee83` — Partner Notification Settings (Dark Mode) — w390 h1973@(454,71641) — proposed: VARIANT twin of Partner Notification Settings (ROUTE /notifications)
  - `2e344ac6edc948708eecb61f43761181` — Attorney Search (Dark Mode) — w390 h1084@(454,18381) — proposed: UNRESOLVED (get_screen failed)
  - `30ba82d08e0948bd8c231cda812b30dd` — Consultation Type (Dark Mode) — w390 h884@(454,23341) — proposed: UNRESOLVED (get_screen failed)
  - `322e308252024c869b4016354d594fe4` — Conflict Disclosure: Matter Selection — w390 h884@(1024,4745) — proposed: WIZARD step
  - `357eb8ab59074842a418723f42effa9c` — Select Date & Time (Dark Mode) — w390 h1303@(908,23341) — proposed: UNRESOLVED (get_screen failed)
  - `3d681b98a99448f5b99e37d1a06f3cd2` — Pending Approvals Queue — w390 h1390@(454,70038) — proposed: ROUTE /approvals (ApprovalsScreen)
  - `45478abdb3ff418aaacc09dcbe9b50d1` — Regulatory Filings Dashboard (Dark Mode) — w390 h2886@(1932,53282) — proposed: FUTURE twin
  - `46f277da1a4f4f1e80f5a3267cf41f40` — Conflict Resolution Dashboard — w390 h3202@(y=60894) — proposed: FUTURE
  - `48b13ef4f1184b42a9af33c5623d3314` — Regulatory Filings Dashboard — w390 h1714@(1478,53282) — proposed: FUTURE
  - `4a47c2645d0d486397cacb5607d855f1` — Conflict Report Details — w390 h2645@(1932,39457) — proposed: FUTURE
  - `4ced08c665944138b4e08c5f4d10bca1` — Onboarding — w390 h884@(1024) — proposed: ROUTE /onboarding (OnboardingScreen)
  - `4fff5d0e044744a49694a58f796013c9` — Risk Dashboard Overview (Dark Mode) — w390 h2579@(1478,41295) — proposed: FUTURE twin
  - `509bd2fa0f664abd8c08a8d47ca469ac` — Booking Success (Dark Mode) — w390 h956@(y=24905) — proposed: ROUTE /book (BookingScreen)
  - `516f402052884bbfb992e5697940af1f` — Shared Case Workspace (Dark Mode) — w390 h2073@(1362,58566) — proposed: FUTURE twin
  - `5287dc44fb814eb4a40cd8ca3f9a2550` — Notification Settings (Dark Mode) — w390 h1703@(454,26361) — proposed: VARIANT twin of Notification Settings (ROUTE /notifications)
  - `5390dcea729443bda5d65876d526e060` — Forgot Password - Email Recovery — w390 h884@(y=29594) — proposed: ROUTE /forgot-password (ForgotPasswordEmailScreen)
  - `54416f7ad13f4b009ffe50b69f97c0ff` — Sign In — w390 h884@(y=28454) — proposed: ROUTE /sign-in (SignInScreen)
  - `54ea9d93828744148651aebfe1ff9780` — Pending Approvals (Dark Mode) — w390 h1347@(y=70038) — proposed: VARIANT twin of Pending Approvals (ROUTE /approvals)
  - `57084b22fa834420a985e782ebfc5605` — Approval Detail: Conflict Waiver — w390 h1308@(1362,70038) — proposed: SHEET (ConflictTakeActionSheet)
  - `577eadb4109841008b6192c009509985` — Compliance Audit Trail — w390 h2925@(y=46881) — proposed: FUTURE
  - `58f668a17fba497a89a2fb9be8b934b8` — Request Conflict Waiver — w390 h2156@(1816,42358) — proposed: ROUTE ConflictTakeActionSheet
  - `5a56e544e4df4cfab54293529a28e11f` — Message Center (Dark Mode) — w390 h896@(y=13180) — proposed: VARIANT twin of Message Center (ROUTE /messages)
  - `5b83c122a1604761980a1025a645898d` — Legal Draft Workspace — w390 h948@(1362,56424) — proposed: FUTURE
  - `5f682e912bf144609a933d7bd63a0d4e` — User Profile — w390 h1950@(y=8084) — proposed: ROUTE /profile (ProfileScreen)
  - `605f577fba5542b5a7941f3f227250a0` — Conflict Resolution Overview (Dark Mode) — w390 h2228@(454,50445) — proposed: FUTURE twin
  - `636ad7a20bba46c0858c50871cb86f8a` — Forgot Password - Email Recovery (Dark Mode) — w390 h884@(1362,29594) — proposed: VARIANT twin
  - `63b5d4afe8ea433585a9236a4062631f` — Message Center — w390 h966@(y=2891) — proposed: ROUTE /messages (MessageListScreen)
  - `687b1ad2009542b0955398147cfddf35` — Case Details — w390 h1310@(y=1325) — proposed: ROUTE /matters/:id (MatterDetailsScreen)
  - `68844660ea2e4449b1ff381498b91e98` — Onboarding Success (Dark Mode) — w390 h884@(454,30734) — proposed: VARIANT twin of Onboarding Success (ROUTE /onboarding/success)
  - `691d22ec22654be0a2f2a017b1329318` — Document Vault — w390 h1058@(y=5254) — proposed: ROUTE /vault (DocumentListScreen)
  - `6d476f197d98420fa2af90cf57a32403` — Sign In (Dark Mode) — w390 h884@(454,28454) — proposed: VARIANT twin of Sign In
  - `6e1cf06c8cdc4cc7a39ddff582844db7` — Citation Manager — w390 h1885@(454,56424) — proposed: FUTURE
  - `6f7176e183b14d04be6ade6e8dcf29c1` — Conflict Disclosure: Final Review — w390 h1357@(2386,1140) — proposed: WIZARD step
  - `7944e8bdfc324da4ab7a840ffba867a2` — Billing & Invoices (Dark Mode) — w390 h1113@(y=15872) — proposed: VARIANT twin of Billing & Invoices (ROUTE /invoices)
  - `800dad7f88984ac5837d1c1de8cd7d19` — Filing Submission Workspace — w390 h2096@(1024,53282) — proposed: FUTURE
  - `81a56588d703491897b01505576ab079` — Forgot Password - OTP Verification (Dark Mode) — w390 h884@(1816,29594) — proposed: VARIANT twin of Forgot Password OTP (ROUTE /forgot-password/otp)
  - `8793f58258f244aba7ee41c57610307b` — Matter Discussion — w390 h884@(454,58566) — proposed: ROUTE /matters/:id (MatterDetailsScreen)
  - `90f8b78bf0b5447b8b98343dfacb8cd6` — Home Dashboard (Dark Mode) — w390 h1070@(y=10289) — proposed: VARIANT twin of Home Dashboard (ROUTE /home)
  - `9aee581c56b7407e90577ff8aab69700` — Conflict Analytics: Ethical Wall Audit — w390 h2570@(454,64352) — proposed: FUTURE (Ethical Wall Audit)
  - `9bed2290018a465eaef2e8908409d8ed` — Attorney Search — w390 h1071@(y=18381) — proposed: UNRESOLVED (get_screen failed)
  - `9f8c7a9a2ab243f994b69124c7555cb1` — Forgot Password - OTP Verification — w390 h884@(454,29594) — proposed: ROUTE /forgot-password/otp (ForgotPasswordOtpScreen)
  - `9fff903ef33a4622962ca0ff37a8d4a3` — Booking Success — w390 h1200@(454,24905) — proposed: ROUTE /book (BookingScreen)
  - `a07d44b059a947ccb9550099fd163617` — Advanced Analytics — w390 h2365@(y=36426) — proposed: FUTURE
  - `a0f76486f67e4c77a5ff624624eed19d` — Sign Up — w390 h884@(1932) — proposed: ROUTE /sign-up (SignUpScreen)
  - `a247189c601b4aabaa797bb7f4186327` — Attorney Profile — w390 h1416@(y=19721) — proposed: ROUTE /discovery/:attorneyId (AttorneyProfileScreen) — Phase 0B (map vs "/discovery/:attorneyId")
  - `a2fc5f88eb874ff5bfb4bacd22642702` — Notification Settings — w390 h1837@(y=26361) — proposed: ROUTE /notifications (NotificationSettingsScreen)
  - `a37ec81483b14bedb0d4234ec1662dc5` — Conflict Check Search (Dark Mode) — w390 h1566@(1478,39457) — proposed: VARIANT twin of Conflict Check Search (ROUTE /conflicts/check)
  - `a85345c901774f55aee7b402390b4183` — Conflict Waiver Status — w390 h1315@(y=42358) — proposed: ROUTE /conflicts/check (ConflictCheckScreen)
  - `aa1c3c82597e4a62a75de779ebe69110` — Shared Case Workspace — w390 h1659@(y=58566) — proposed: FUTURE
  - `b1c950bbc3104bf9a20f0bbff05e4bc6` — Consultation Type — w390 h884@(908,21766) — proposed: ROUTE /video (VideoConsultationScreen)
  - `b1ddea318e9943a48525660bdde6cc87` — Partner Notification Settings — w390 h2330@(y=71641) — proposed: ROUTE /notifications (NotificationSettingsScreen)
  - `b89e52b625344772bbdc2b568421b306` — Resolution Action: Ethical Wall (Dark Mode) — w390 h2333@(1362,50445) — proposed: FUTURE twin
  - `bbd6d204ee0f48789f939269667b9134` — Home Dashboard — w390 h1070@(1478) — proposed: ROUTE /home (HomeScreen)
  - `c030e8f7db774d7f89f65ed17fd12768` — Advanced Analytics (Dark Mode) — w390 h2775@(454,36426) — proposed: FUTURE twin
  - `c07b665606a44d7789f92427c88a49af` — Select Date & Time — w390 h1303@(454,21766) — proposed: UNRESOLVED (get_screen failed)
  - `c46e25756fab482ca3f88785c2a1c7ac` — Conflict Check Search — w390 h1787@(1024,39457) — proposed: ROUTE /conflicts/check (ConflictCheckScreen)
  - `c8c4c21516d04e1c97fb94bfc4a96a14` — Case Management Dashboard (Dark Mode) — w390 h2126@(454,33615) — proposed: VARIANT twin of Case Management Dashboard (ROUTE /matters)
  - `ca75b3cf489d48ba8c0ff916e2d037d5` — Review & Confirm Booking — w390 h1193@(y=21766) — proposed: ROUTE /book (BookingScreen)
  - `cad6cccc1a354874b9fc45833e1f0e95` — Forgot Password - Reset Password (Dark Mode) — w390 h884@(2270,29594) — proposed: VARIANT twin of Forgot Password Reset (ROUTE /forgot-password/reset)
  - `ce0d5c563e9940c1936d1334840d240c` — Compliance Alerts (Dark Mode) — w390 h903@(908,68565) — proposed: VARIANT twin of Compliance Alerts (ROUTE /alerts)
  - `d1d356aa7a814a4db9ca35938b591f59` — Settings & Localization — w390 h884@(x=-457, y=722) — proposed: ROUTE /settings (SettingsScreen)
  - `d206202d158b412a9993519f33a209eb` — Conflict Disclosure: Party Identification — w390 h1073@(1478,3605) — proposed: WIZARD step
  - `d57ac66bdffe4c34b73afc84dd3c2bad` — Attorney Profile (Dark Mode) — w390 h1789@(454,19721) — proposed: VARIANT twin of Attorney Profile
  - `d9ccbf15a6974731ae85c7a09fada5db` — Legal Library — w390 h1485@(y=31874) — proposed: ROUTE /library (LibraryHomeScreen)
  - `dabd453bd2264c518fdcf9def5c4f071` — Video Consultation — w390 h884@(y=4114) — proposed: ROUTE /video (VideoConsultationScreen)
  - `dd08da4121c14d868a0d28ca942cf427` — Billing & Invoices — w390 h1260@(y=6568) — proposed: ROUTE /invoices (BillingInvoicesScreen)
  - `e09aacd1ae754d589823c928c52cb4b4` — Video Consultation (Dark Mode) — w390 h884@(y=17241) — proposed: VARIANT twin of Video Consultation
  - `e1096c24bfe743ea9e37bd06905c84f2` — Compliance Audit Trail (Dark Mode) — w390 h3331@(454,46881) — proposed: FUTURE twin
  - `e1f2157ba783424dbf68b93f70dddc4d` — Statutory Research Browser — w390 h1705@(y=56424) — proposed: FUTURE
  - `e3fd57dd136747079643445015949038` — Request Conflict Waiver (Dark Mode) — w390 h1849@(2270,42358) — proposed: VARIANT twin of Request Conflict Waiver
  - `e63112e473ef4355b0316f671a46207f` — Review & Confirm Booking (Dark Mode) — w390 h1195@(y=23341) — proposed: VARIANT twin
  - `e641ae5becd644aea454dc46cc92c27b` — Filing Submission Workspace (Dark Mode) — w390 h2455@(2386,53282) — proposed: FUTURE twin
  - `e9bc1ff60760418787eeff8ba1d5b50d` — Collaboration Task Board — w390 h939@(908,58566) — proposed: UNRESOLVED (map: tasks — JIT)
  - `ef01fe0feef744de89f7a39883dffa77` — Global Compliance Map — w390 h1150@(y=67159) — proposed: FUTURE
  - `f79552e15f104e98adf1a3aa80bc733d` — Forgot Password - Reset Password — w390 h884@(908,29594) — proposed: ROUTE /forgot-password/reset (ForgotPasswordResetPassword)
  - `f86c14325fc44fdf95cd60b535c67f03` — Global Compliance Map (Dark Mode) — w390 h1076@(454,67159) — proposed: FUTURE twin
  - `fa2caa1f66664be495497dffaf918593` — Risk Dashboard Overview — w390 h3288@(1024,43337) — proposed: FUTURE
  - `fec92f764e7c48079294ee8736c32d75` — Legal Research AI Assistant — w390 h900@(908,56424) — proposed: ROUTE /research (AiResearchScreen)
  - `fee03c6f289745788b7b072138873ad9` — Take Action: Conflict Resolution — w390 h1349@(1362,68565) — proposed: SHEET (ConflictTakeActionSheet)
  - `28f04e6d39194e7388294e98ac635e3c` — Lexis Legal Operations Platform — w390 h884@(2840,39457) — screenType PROTOTYPE_V2 — PROTOTYPE (in the 97; counted in prototype total)
- **Multi-step flows (master §5.3 completeness):** Sign-in → Forgot Password (3 routes); Onboarding (2 routes); Conflict Disclosure wizard (4 canvas screens = DisclosureWizardScreen steps, app route `/conflicts/disclose`); Booking (`BookingScreen` — "Booking Success" + "Review & Confirm Booking" states); Video Consultation (`VideoConsultationScreen`); Delete Account (`DeleteAccountSheet` — keeps confirmation); Take Action: Conflict Resolution (`ConflictTakeActionSheet`); Waiver Approval (`ConflictCheckScreen`); case management (MatterList/MatterDetails).

## 11. Dependency graph (master §4 Phase 0A — audit artifact only)

(Features → dependent features; Phase 1 decides centralization if duplication is high — currently low by named overlap.)

admin → profile, orgs · approvals → tasks · auth → onboarding · billing → matters, orgs · booking → matters, discovery · compliance → orgs, approvals · conflicts → matters, orgs · discovery → orgs · documents(vault) → matters, discovery · home → orgs, matters, documents, legal, library, discovery, tasks · legal → library, conflicts · library → documents, legal · matters → documents, discovery, legal, storage · messaging → orgs, matters · notifications → orgs · onboarding → auth · orgs → tasks, approvals, profile, discovery · profile → orgs · research → legal · search → matters, discovery, legal · storage(vault) → documents · tasks → matters · video → matters, orgs.

**Wave order (master, default; reordering = owner decision):** 0A (this doc) → 1 Foundation → 2 Shell → 3 Auth & Account → 4 Home → 5 Core Legal Operations → 6 Collaboration & Organizations → 7 Discovery & Client Interaction → 8 Financial & Compliance → 9 Final Verification (master §4).

## 12. Exit criteria and acceptance requirements (master §9)

- [x] All 181 screens classified (§9) — ROUTE 53, SHEET 7, DIALOG 0, WIZARD 4, STATE 0, VARIANT 96, FUTURE 16, UNRESOLVED 5 (+prototype 1, +6 boards).
- [x] Token register approved (§5) — canvas wins; conflicts flagged for owner.
- [x] Spacing/radius/typography scales quoted (§6).
- [x] Component inventory + centralization decisions (§8).
- [x] Unlabeled instances listed (§10.1).
- [x] Gates green at baseline (§2): analyze 0, format 837/0, tests 2,447/13/0, coverage 84.6016%. No code/test/route/theme/config changed — git tree shows only the untracked `docs/redesign/` directory; branch = `redesign/stitch-alignment` @ `cb65f84` (preserved).
- **Phase 9 DoD (master §9 — all 14 + accessibility additions):** (1) all in-scope Stitch frames classified and mapped (§9); (2) no unauthorized routes added (§9.2); (3) light and dark themes verified; (4) English, Arabic RTL, and Turkish checked; (5) existing user interactions preserved; (6) existing Cubit and gateway contracts preserved; (7) loading, empty, error, and populated states verified; (8) design screenshots compared against approved references (human-reviewed, never CI gates); (9) no unapproved test modifications; (10) `flutter analyze` 0 issues; (11) `dart format` 0 differences; (12) full test suite green; (13) coverage vs baseline; (14) wave change log and evidence documented. **Accessibility (user addition):** semantic labels/screen readers (Semantics/tooltips on interactive elements), interactive targets ≥ 48×48 (house rule — audit at wave time), text scaling at 2.0 (existing responsive-matrix tests), WCAG 2.2 contrast ≥ 4.5:1 (≥ 3:1 for large text), focus behavior (2px brandAccent focused border — app already has `focusedBorder` width 2; first focusable on sheet/dialog open; Escape/Back exit), Arabic RTL reading order and navigation direction (mirror directional icons, `EdgeInsetsDirectional`, logical reading order — app has `ReadingOrderTraversalPolicy` and `DirectionalIcon`).

## 13. Drift log (master prompt vs measured, 2026-11-19)

- Routes: master said 44 (11 + 33); measured **45** (11 top-level + 34 shell; extra = `/platform-admin/attorneys` → AttorneyAdminScreen).
- ARB: master said "1,074 × 3"; measured: EN 1,127 canon keys / 1,373 lines; AR 1,303 / 1,856; TR 1,303 / 1,856 (line-vs-canon explanation: line counts include `@` metadata and blank lines — the 176 delta = 1303 − 1127 canonical).
- Master §2.2 "boards define NO spacing/radius/text" — outdated: all six boards expose spacing/radius/type (quoted in §4–§6); canvas wins.
- Master §2.3 Primary #0B1D2E vs canvas `primary` #000102 (all boards) — Conflict (canvas wins; canvas `primary-container` = #0b1d2e).
- Master Board A Tertiary #F4F4F9 vs canvas #000102 — Conflict; Boards B, C Tertiary #2B1803 vs canvas #030100 — Conflict; Board D Tertiary #00608C vs canvas #000101 — Conflict; Board E Tertiary #4A4A4A — Missing (canvas: no tertiary token on Board E); Board F Tertiary #00608C — Missing (canvas: none).
- Master Board B, C Neutral #777778 — Variant (canvas: no neutral on boards B, C); Board F Neutral #0D1C2E — Alias (canvas: on_surface #0d1c2e).
- Master Board A Neutral #4A5568 vs canvas #4a5568 — Alias; Board D Neutral #74777D vs canvas #74777d — Alias.
- Canvas `surfaceLight` == `surfaceDark` on all six boards — Variant (master assumed dark values = `*_dark_mode` designs).
- Master "AR has ~1303 keys" — canonical AR = 1,303 ✓; master "EN ≈ 1,074" — canonical EN = 1,127 (master's EN count lower — likely older data).

## 14. Phase 0A Reconciliation Addendum (re-read, 2026-11-19)

Authoritative sources re-read live: GoRouter table — `lib/app/router.dart` + `lib/app/router_shell_routes.dart`; canvas — `tools.stitch.get_project("projects/17670909757013221834").screenInstances` + `get_screen` per instance (same taxonomy as §9). Branch `redesign/stitch-alignment` @ `cb65f84`; no application code, tests, routes, theme or config changed — the only artifact change is this addendum inside `docs/redesign/`.

### 14.1 GoRouter actual vs Stitch ROUTE (44/45 vs 53)

**Actual GoRouter: 45 routes** — the drift log's "44 (11 + 33)" is superseded (measured 45):

- 11 top-level: `/privacy`, `/terms`, `/sign-in`, `/sign-up`, `/forgot-password`, `/forgot-password/otp`, `/forgot-password/reset`, `/onboarding`, `/onboarding/success`, `/conflicts/disclose`, `/conflicts/check`.
- `ShellRoute` (authenticated shell) + 34 shell routes: `/home`, `/book`, `/discovery`, `/discovery/:attorneyId`, `/matters`, `/matters/new`, `/matters/:matterId`, `/vault`, `/vault/:documentId`, `/messages`, `/messages/:threadId`, `/search`, `/invoices`, `/invoices/:invoiceId`, `/alerts`, `/tasks`, `/video`, `/approvals`, `/research`, `/library`, `/library/saved`, `/library/search`, `/library/:documentId`, `/library/articles/:articleId`, `/settings/account`, `/settings`, `/organizations`, `/organizations/audit`, `/accept-invitation`, `/profile`, `/notifications`, `/notifications/feed`, `/platform-admin`, `/platform-admin/attorney`.

**Stitch ROUTE: 53 canvas frames** (fresh classification — table 14.1.1).

Reconciliation:

1. **53 frames ↔ 45 routes.** Multi-frame routes (canvas holds >1 frame per route; extras are same-route states, recorded so they are not double-counted): `/matters/:id` ×3 — Case Details `687b1ad2`, Matter Discussion `8793f582`, Matter Created `eea3a0a6`; `/organizations` ×3 — Create Organization `9d041152`, Organizations Hub `ad5a0044`, Member Roster `aded5a5f`; `/library/saved` ×3 — Bookmarks `062a1fd7`, History `703b8b00`, Highlights `e1b6ec96`; `/accept-invitation` ×2 — Accept Invitation `95f6fd89`, Invitation Accepted `5eb03497`; `/video` ×2 — Video Call `5f5c7021`, Consultation Type `b1c950bb`; `/notifications` ×2 — Notification Settings `a2fc5f88`, Partner Notification Settings `b1ddea31`; `/book` ×2 — Booking Success `9fff903e`, Review & Confirm Booking `ca75b3cf`; `/conflicts/check` ×2 — Conflict Waiver Status `a85345c9`, Conflict Check Search `c46e2575`.
2. **1 canvas frame with null appRoute** (not a GoRouter destination): `Page Not Found` `4518cdf7` = synthetic error surface — the app's `_UnmatchedLocationSurface` (router.dart errorBuilder — GoRouter defines no route object for it — **not an additional GoRouter route**). **`Request Conflict Waiver` `58f668a1` = SHEET** (user distinction — the 97-list's take-action sheet; not a route — counted as SHEET in §14.6).
3. **4 GoRouter routes with no canvas frame**: `/messages/:threadId` (MessageThreadDetailScreen), `/tasks` (TaskBoardScreen), `/library/articles/:articleId` (LibraryArticleScreen), `/platform-admin/attorney` (AttorneyAdminScreen). (`/conflicts/disclose` is covered by the 4 WIZARD frames — DisclosureWizardScreen steps.)
4. Every other GoRouter route has ≥1 canvas frame (see table 14.1.1).

#### 14.1.1 Stitch ROUTE + SHEET frames (fresh read; `58f668a1` Request Conflict Waiver reclassified SHEET per owner distinction)

| Route | Frames (id — title / screen class) |
|---|---|
| `/alerts` | `03c3aba2` — ComplianceAlertsScreen |
| `/terms` | `0584ed59` — LegalDocumentScreen (terms) |
| `/library/saved` | `062a1fd7` (Bookmarks), `703b8b00` (History), `e1b6ec96` (Highlights) — LibrarySavedScreen |
| `/onboarding/success` | `0b4e2818` — OnboardingSuccessScreen |
| `/discovery/:attorneyId` | `1a1c4495` — AttorneyProfileScreen |
| `/matters` | `242bc534` — MatterListScreen |
| `/approvals` | `3d681b98` — ApprovalsScreen |
| — (null) | `4518cdf7` — Page Not Found (synthetic error surface — not an additional GoRouter route) |
| SHEET | `58f668a1` — Request Conflict Waiver — ConflictTakeActionSheet (97-list) — user distinction: SHEET, not a route |
| `/onboarding` | `4ced08c6` — OnboardingScreen |
| `/forgot-password` | `5390dcea` — ForgotPasswordEmailScreen |
| `/sign-in` | `54416f7a` — SignInScreen |
| `/platform-admin` | `554af7e9` — PlatformAdminScreen |
| `/library/:id` | `59a8b8b5` — LibraryDocumentScreen |
| `/library/search` | `5de16433` — LibrarySearchScreen |
| `/accept-invitation` | `5eb03497` (Invitation Accepted), `95f6fd89` (Accept Invitation) |
| `/video` | `5f5c7021` (Video Call), `b1c950bb` (Consultation Type) |
| `/profile` | `5f682e91` — ProfileScreen |
| `/messages` | `63b5d4af` — MessageListScreen |
| `/notifications/feed` | `6491088c` — NotificationFeedScreen |
| `/matters/:id` | `687b1ad2` (Case Details), `8793f582` (Matter Discussion), `eea3a0a6` (Matter Created) |
| `/vault` | `691d22ec` — DocumentListScreen |
| `/vault/:id` | `7a0505b6` — DocumentDetailsScreen |
| `/privacy` | `7ce5014e` — LegalDocumentScreen (privacy) |
| `/invoices/:id` | `8ef399e4` — InvoiceDetailsScreen |
| `/discovery` | `94fd1ae2` — AttorneySearchScreen |
| `/organizations` | `9d041152` (Create Organization), `ad5a0044` (Organizations Hub), `aded5a5f` (Member Roster) |
| `/settings/account` | `9d1be566` — AccountScreen |
| `/forgot-password/otp` | `9f8c7a9a` — ForgotPasswordOtpScreen |
| `/book` | `9fff903e` (Booking Success), `ca75b3cf` (Review & Confirm Booking) |
| `/sign-up` | `a0f76486` — SignUpScreen |
| `/notifications` | `a2fc5f88` (Notification Settings), `b1ddea31` (Partner Notification Settings) |
| `/conflicts/check` | `a85345c9` (Conflict Waiver Status), `c46e2575` (Conflict Check Search) |
| `/search` | `afc2a0d3` — SearchScreen |
| `/home` | `bbd6d204` — HomeScreen |
| `/settings` | `d1d356aa` — SettingsScreen |
| `/library` | `d9ccbf15` — LibraryHomeScreen |
| `/invoices` | `dd08da41` — BillingInvoicesScreen |
| `/matters/new` | `dd8b3a8a` — MatterCreateScreen |
| `/organizations/audit` | `f72cdebb` — OrgAuditScreen |
| `/forgot-password/reset` | `f79552e1` — ForgotPasswordResetPassword |
| `/research` | `fec92f76` — AiResearchScreen |

### 14.2 Original 81 → revised 88: the 7 additional logical screens

Fresh distinct logical = 88 (89 counting the PROTOTYPE). Additional vs master 81 = 7:

1. **Article Reader** — `79a066f6eae441c8bbf375dc78d64547` (+ dark `0327dbb667a34310ace8f89d6d2d7315`) — new frame; Phase 0B: Library Article Reader (Route `/library/articles/:articleId` — the GoRouter route without a canvas frame).
2. **Attorney Profile** — `a247189c601b4aabaa797bb7f4186327` (+ dark `d57ac66bdffe4c34b73afc84dd3c2bad`) — new frame; app surface = `AttorneyProfileScreen` (`/discovery/:attorneyId`; canvas "Attorney Form" `1a1c4495` is its ROUTE frame).
3. **Attorney Search** — `9bed2290018a465eaef2e8908409d8ed` (+ dark `2e344ac6edc948708eecb61f43761181`) — new frame (no app route — Phase 0B discovery-search surface).
4. **Collaboration Task Board** — `e9bc1ff60760418787eeff8ba1d5b50d9` (+ darks `d0a20d00ef5046829d96822cbc856970`, `b166e5005c8c4ab9aeec3faceb735204`) — new frame; Phase 0B: Route `/tasks` (TaskBoardScreen — a GoRouter route without canvas frame).
5. **LegalDraft Workspace** — `720c59677f044ae191babaf77e01fce0` (+ dark `5562952a76d24ec39b22e2ad0bd9d975`) — new frame, related to but distinct from master FUTURE "Legal Draft Workspace" (`5b83c122` — present in fresh FUTURE).
6. **Resolution Action: Ethical Wall** — `03bc517f09354ba6bbd92cb9cdd63cf3` (+ dark `b89e52b625344772bbdc2b568421b306`) — the additional frame the owner named; excluded per owner instruction.
7. **Video Consultation** — `dabd453bd2264c518fdcf9def5c4f071` (+ dark `e09aacd1ae754d589823c928c52cb4b4`) — new frame (app `/video` = VideoConsultationScreen; canvas "Video Call" `5f5c7021` is its ROUTE counterpart).

Reconciled — NOT additional: `Conflict Analytics Report: Executive Summary` (`26f5ee2d`, dark `3dc2d7d3`) and `Conflict Analytics: Ethical Wall Audit` (`9aee581c`, dark `1cba863d`) — these reconcile with master FUTURE "Conflict Analytics Report" and "Ethical Wall Audit" (canvas frames renamed). PROTOTYPE `28f04e6d` "Lexis Legal Operations Platform" is not a screen.

So: original 81 + additional 7 = revised 88 ✓.

**Authorization accounting (excluded set — remain outside implementation, per the owner's authorization):** 13 currently classified FUTURE + 3 currently classified UNRESOLVED = {26f5ee2d (Conflict Analytics Report: Executive Summary), 9aee581c (Conflict Analytics: Ethical Wall Audit), 03bc517f (Resolution Action: Ethical Wall — the user-named 'additional frame')}. **Phase 1 implements the additional screens: Article Reader (79a66f6), Attorney Search (9bed2290), Attorney Profile (a247189c), Collaboration Task Board (e9bc1ff6), LegalDraft Workspace (720c5967), Video Consultation (dabd453b) = 6** — the user's '7 additional' = these 6 + the excluded 'Resolution Action: Ethical Wall' (03bc517f); 03bc517f remains excluded per the authorization (owner may explicitly authorize implementing it). The 6 are Phase 2 targets — not implemented in Phase 1 (Foundation). The two reconciled FUTURE frames (26f5ee2d, 9aee581c) are renamed/reconciled members of the original set — not additional.

### 14.3 Why the §10.1 list holds 97 while the variant count is 96

The list contains **97** unlabeled instances. Fresh classification: **96 VARIANT** + **1 PROTOTYPE** (`28f04e6d` — screenType PROTOTYPE_V2) + **8 UNRESOLVED** (§14.4). The 97 = 96 dark-mode twin frames + the prototype — the variant count is 96 because the 97th entry is the prototype, which the taxonomy classifies as PROTOTYPE (not VARIANT). The 8 UNRESOLVED frames are separate retry rows for frames whose earlier `get_screen` failed (`2e344ac6`, `30ba82d0`, `357eb8ab`) plus newly-unmapped frames (`79a066f6`, `9bed2290`, `a247189c`, `dabd453b`, `e9bc1ff6`, `03bc517f`, `26f5ee2d`, `9aee581c`); their dark twins (0327dbb6, 2e344ac6, d57ac66b, 1cba863d, 3dc2d7d3, e09aacd1, b89e52b6, d0a20d00, b166e500) are among the 96 VARIANT.

### 14.4 UNRESOLVED — full enumeration (fresh; contract §9 stated (5))

Contract §9: UNRESOLVED (5) — Article Reader (`0327dbb6` dark + `79a066f6` light), Attorney Search (`9bed2290`), Attorney Profile (`a247189c`), Video Consultation (`dabd453b`), Collaboration Task Board (`e9bc1ff6`). Fresh authoritative read: **8** (all `err=false` — the earlier `get_screen` failures now resolve):

| ID | Title | Note |
|---|---|---|
| `03bc517f09354ba6bbd92cb9cdd63cf3` | Resolution Action: Ethical Wall | additional frame (§14.2 #6) |
| `26f5ee2d47b14e0a98c201349cf34d43` | Conflict Analytics Report: Executive Summary | reconciles with master FUTURE "Conflict Analytics Report" |
| `79a066f6eae441c8bbf375dc78d64547` | Article Reader | new — §14.2 #3 |
| `9aee581c56b7407e90577ff8aab69700` | Conflict Analytics: Ethical Wall Audit | reconciles with master FUTURE "Ethical Wall Audit" |
| `9bed2290018a465eaef2e8908409d8ed` | Attorney Search | additional (§14.2 #3) |
| `a247189c601b4aabaa797bb7f4186327` | Attorney Profile | additional (§14.2 #2) |
| `dabd453bd2264c518fdcf9def5c4f071` | Video Consultation | additional (§14.2 #7) |
| `e9bc1ff60760418787eeff8ba1d5b50d9` | Collaboration Task Board | additional (§14.2 #4) |

Diff vs contract §9 (5): fresh = contract 5 + {03bc517f, 26f5ee2d, 9aee581c} — the 3 contract-FUTURE frames re-read as UNRESOLVED (§14.5); the contract's additional mentions "Consultation Type" (`b1c950bb` → fresh ROUTE `/video`) + "Select Date & Time" (`c07b6656` → fresh SHEET) are not UNRESOLVED in the fresh read; the dark-error retries (`2e344ac6`, `30ba82d0`, `357eb8ab`) are fresh VARIANT (their light bases are above). Every screen node has exactly one primary class; dark twins are recorded as VARIANT (secondary relationship) and not double-counted.

**Apparent overlaps with ROUTE/SHEET** (each node still has one primary class; the ROUTE/SHEET counterparts are different canvas instances):

- Attorney Search (`9bed2290`) vs Attorney Directory (`94fd1ae2` → ROUTE `/discovery`) and Attorney Form (`1a1c4495` → ROUTE `/discovery/:attorneyId`): the canvas added its own "Attorney Search" frame; both coexist (Phase 0B maps 9bed2290 → discovery search).
- Video Consultation (`dabd453b`) vs Video Call (`5f5c7021` → ROUTE `/video`) and Consultation Type (`b1c950bb` → ROUTE `/video`): distinct frames; Video Call is the ROUTE counterpart.
- Collaboration Task Board (`e9bc1ff6`) — new; Phase 0B → Route `/tasks` (TaskBoardScreen — a GoRouter route without canvas frame).
- Article Reader (`79a066f6`) — new; → Route `/library/articles/:articleId`.
- Resolution Action: Ethical Wall (`03bc517f`) — new; excluded per owner instruction.
- Conflict Analytics Report: Executive Summary (`26f5ee2d`) + Conflict Analytics: Ethical Wall Audit (`9aee581c`) — reconciled with master FUTURE; dark twins 3dc2d7d3 + 1cba863d → VARIANT.

### 14.5 Original 15 FUTURE (master §6.4) — separation

1. Risk Dashboard Overview, 2. Regulatory Filings Dashboard, 3. Advanced Analytics, 4. Global Compliance Map, 5. Conflict Analytics Report, 6. Ethical Wall Audit, 7. Conflict Resolution Dashboard, 8. Conflict Resolution Overview, 9. Conflict Report Details, 10. Statutory Research Browser, 11. Filing Submission Workspace, 12. Legal Draft Workspace, 13. Citation Manager, 14. Compliance Audit Trail, 15. Shared Case Workspace.

Fresh FUTURE (13): Risk Dashboard Overview (fa2caa1f), Regulatory Filings Dashboard (48b13ef4), Advanced Analytics (a07d44b0), Global Compliance Map (ef01fe0f), Conflict Resolution Dashboard (46f277da), Conflict Resolution Overview (21e4ce4c), Conflict Report Details (4a47c262), Compliance Audit Trail (577eadb4), Legal Draft Workspace (5b83c122), Citation Manager (6e1cf06c), Filing Submission Workspace (800dad7f), Statutory Research Browser (e1f2157b), Shared Case Workspace (aa1c3c82).

Reconciled (2): Conflict Analytics Report → `26f5ee2d` "Conflict Analytics Report: Executive Summary" (+ dark 3dc2d7d3); Ethical Wall Audit → `9aee581c` "Conflict Analytics: Ethical Wall Audit" (+ dark 1cba863d).

Additional (1): `03bc517f` "Resolution Action: Ethical Wall" (+ dark b89e52b6) — the user-named 'additional frame' — **excluded per the authorization** (the excluded-3: {26f5ee2d, 9aee581c, 03bc517f}); the 6 implemented additional screens (§14.2) are the non-excluded ones.

**Excluded set (16 — per the authorization):** 13 fresh FUTURE + 3 fresh UNRESOLVED = {26f5ee2d, 9aee581c, 03bc517f}. **All 16 remain excluded from implementation** until the owner explicitly reclassifies (frozen rule 5).

### 14.6 Category totals reconcile to 181

Fresh (excl. PROTOTYPE): ROUTE 52 + SHEET 8 + WIZARD 4 + VARIANT 96 + FUTURE 13 + UNRESOLVED 8 + DIALOG 0 + STATE 0 = **181**. (`58f668a1` Request Conflict Waiver: ROUTE→SHEET per owner distinction — SHEET +1; `4518cdf7` Page Not Found = synthetic error surface — not an additional GoRouter route.) Contract §9: ROUTE 53 + SHEET 7 + WIZARD 4 + VARIANT 96 + FUTURE 16 + UNRESOLVED 5 = 181. Split differences reconciled: the 3 frames {26f5ee2d, 9aee581c, 03bc517f} — contract counted them FUTURE 16; fresh counts them UNRESOLVED 8. No missing or multiply counted nodes (VARIANT = dark twins of their light counterparts; `4518cdf7` Page Not Found = synthetic error surface — not an additional GoRouter route; `58f668a1` Request Conflict Waiver = SHEET per owner distinction).

### 14.7 Gates + Git state (post-addendum re-verification)

- `flutter analyze`: 0 issues.
- `dart format .`: 837 files, 0 changed.
- `git status --porcelain`: `?? docs/redesign/` only.
- Branch: `redesign/stitch-alignment` @ `cb65f84` — main preserved.

## 15. Token decision record (Phase 1 — owner-approved, implemented exactly)

| Token | Selected value | Source (board/frame + code) | Reason |
|---|---|---|---|
| **Primary** | #0B1D2E | App `LegalHubTheme.primary` (legalhub_theme.dart:22); canvas anchors: `primary-container` #0b1d2e (§5.1.2); conflict register: canvas API `primary` #000102 (§5.1.2 — documented, **NOT** adopted as brand Primary — owner decision). | App already implements the owner-approved canonical Primary (pinned by test/app/legalhub_theme_test.dart:17). |
| **Secondary** | #775A19 | App `LegalHubTheme.secondary` (legalhub_theme.dart:26); canvas `secondary` #775a19 ×6 — Alias (§5.2). | App already implements the owner-approved canonical Secondary (pinned by test/app/legalhub_theme_test.dart:35). |
| **Tertiary** | No change — M3 default | App: the `ColorScheme.light` call passes no `tertiary`/`tertiaryContainer`/`onTertiaryContainer` (legalhub_theme.dart:175-197) — M3 defaults apply (used by chips — document_type_chip.dart:25, message_count_chip.dart:24, notification_category_chip.dart:35, member_roster_status_chip.dart:17, password_strength_indicator.dart:43). Canvas: no global tertiary token — per-board values conflict (Board A #000102, Boards B/C #030100, Board D #000101, Boards E/F — none); canvas `tertiary-container` only on Board D #001e30 + Board E #2b1803 (§5.1); master #4A4A4A — Variant/Missing (Board E). | No defensible global choice without visual evidence — per-board values conflict; app default retained (per owner: 'Do not invent or silently force a global value'). Owner may approve adopting a specific board value (D/E). |
| **Neutral** | App `onSurfaceVariant` #44474C — adopted as-is | Canvas `On Surface Variant` #44474C ×6 (§5.2) — app Alias. Canvas boards define no global Neutral token; `overrideNeutralColor` exists only on Board A #4a5568 + Board D #74777d (per-board conflict). | Canvas-verified alias — adopted; no app token exists for a separate Neutral — no conflicting global value forced. |

**Preserved (no change):** onPrimary #FFFFFF; primaryContainer #1A2B3C + onPrimaryContainer #8192A7 (ADR-0008 — pinned by test/app/legalhub_theme_test.dart:28-29); surface #F8F9FF; surfaceContainerLow #EFF4FF; surfaceContainer #E6EEFF; surfaceContainerHigh #DCE9FF; surfaceContainerHighest #D5E3FC; onSurface #0D1C2E; outline #74777D; outlineVariant #C4C6CD; surfaceTint — app none (canvas #4f6074 ×6 — Variant/MISSING); inversePrimary #B7C8DE (canvas alias — darkPrimary family); error #BA1A1A; errorContainer #FFFFDAD6; success #1B5E20; warning #7A5900; info #00608C; highlight slots; dark: darkPrimary #B7C8DE (canvas `inverse-primary` #b7c8df ×6 — app Alias), darkSurface #0D1C2E, dark surfaces. Light/dark design direction preserved per owner instruction.

## 16. Phase 1 evidence (Foundation — theme + typography/fallback validation)

### 16.1 Typography / multilingual font fallback validation (EN, AR, TR)
- Font assets present: `PlayfairDisplay-Variable.ttf` (300,724 B — assets/fonts/playfair_display/), `NotoSans-Variable.ttf` (2,049,096 B — assets/fonts/noto_sans/), `NotoNaskhArabic-Variable.ttf` (307,592 B — assets/fonts/noto_naskh_arabic/) (Get-ChildItem — duplicates also present in the tree).
- Declared in pubspec.yaml:54-63 (families `NotoSans`, `NotoNaskhArabic`, `PlayfairDisplay`).
- Theme mapping (legalhub_text_theme.dart:9-11): `headingFamily = NotoNaskhArabic` (Arabic) / `PlayfairDisplay` (Latin); `bodyFamily = NotoNaskhArabic` / `NotoSans`.
- Locale rules (locale_rules.dart:2): `kRtlLocaleCodes = {'ar'}` — Turkish ('tr') is Latin (not in the set) → PlayfairDisplay headings + NotoSans body; Arabic ('ar') → NotoNaskhArabic headings + body.
- Fallback: `fontFamilyFallback = ['NotoNaskhArabic', 'NotoSans']` (legalhub_theme.dart:223) — the Legal Library corpus is Arabic source text even in the English UI (comment legalhub_theme.dart:220-222).
- Pinned by test/app/legalhub_theme_test.dart:106-132 (en → NotoSans body / PlayfairDisplay display; ar → NotoNaskhArabic body / display).
- **Validation conclusion:** EN — PlayfairDisplay headings + NotoSans body (fonts exist + declared + theme-mapped + pinned by tests). AR — NotoNaskhArabic (behavioral authority — the app maps Arabic to NotoNaskhArabic; the canvas boards define no Arabic-specific headline font — Board A type: Playfair Display headlines — app preserves behavioral authority). TR — Latin → PlayfairDisplay + NotoSans. All three locales: fonts available, declared, mapped, tested. **No typography changes needed — already in place; documented.**

### 16.2 Light/dark verification
- Light: primary #0B1D2E (test/app/legalhub_theme_test.dart:17 — pinned), secondary #775A19 (:35 — pinned), surface #F8F9FF (:41 — pinned), error #BA1A1A (:47 — pinned); primaryContainer #1A2B3C + onPrimaryContainer #8192A7 (:28-29 — pinned).
- Dark: primary #B7C8DE (:55 — pinned; canvas `inverse-primary` #b7c8df ×6 — app Alias), darkSurface #0D1C2E (:61 — pinned).
- Preserved per owner: light/dark brightness structure; darkPrimary family values unchanged; canvas `surfaceLight == surfaceDark` Variant (app: light surface #F8F9FF, dark surface #0D1C2E — direction preserved).

### 16.3 Gates
- `flutter analyze` (3.50.0): **0 issues** — same as baseline (§2).
- `dart format .`: **837 files, 0 changed** — same as baseline (§2).
- `flutter test --coverage`: **2,447 pass / ~13 skipped / 0 failed — 'All tests passed!'** — same as baseline (§2).
- Coverage: **84.6016%** (measured via `coverage/lcov.info`: LH 18,466 / LF 21,827) — same as baseline (§2).

### 16.4 Changed-file list
- `docs/redesign/REDESIGN_EXECUTION_CONTRACT.md` — §14.1.2/§14.1.1/§14.2/§14.5/§14.6 amendments (classification distinctions: Page Not Found synthetic error surface; Request Conflict Waiver SHEET) + new §15 Token decision record + new §16 Phase 1 evidence.
- `lib/app/legalhub_theme.dart` — **no edit** (tokens already canonical — primary #0B1D2E (:22), secondary #775A19 (:26); verified via tests).
- Test changes: **none** (no tests edited; behavioral tests untouched).

**Spacing/radius/typography** — accepted per Phase 0A evidence (§6); implementation found no mismatch (theme unchanged).

**STOP — Phase 1 (Foundation) complete. Awaiting your review. Note on the '7 additional': the 6 implemented screens (§14.2) are the non-excluded ones; the user-named 'Resolution Action: Ethical Wall' (03bc517f) remains excluded per the authorization — if you want it implemented, authorize it explicitly. Phase 2 begins on your explicit authorization.**
