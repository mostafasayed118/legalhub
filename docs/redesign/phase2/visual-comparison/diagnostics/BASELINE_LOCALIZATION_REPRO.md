# Baseline reproduction of the AR/TR localization crash

Purpose: prove the `No MaterialLocalizations found` failure is **pre-existing**,
not introduced by the Phase 2 presentation work.

## Method (fresh, untouched baseline)

- Baseline ref: `main` / `cb65f84ecc4bb09d8db08d5b9278f4a44edb6f6a`, checked out
  in a temporary git worktree outside the repository
  (`C:\Users\ASUS\AppData\Local\Temp\opencode\baseline_main`).
- No Phase 2 file, test, ARB, `l10n.yaml` or `main.dart` edit was present in that
  worktree. `git status --porcelain` there showed only the build-generated
  `lib/l10n/app_localizations.dart` rewrite.
- Toolchain: Flutter 3.50.0, JDK 21, `ALLOW_DEBUG_SIGNING=true`.
- Build: `flutter pub get` then
  `flutter build apk --debug --flavor production -t lib/main_production.dart
  --target-platform android-x64` → exit 0, 127,698,240-byte APK.
- Device: emulator `emulator-5554` (API 36, x86_64), APK installed as
  `com.legalhub.app`, locale/theme prefs seeded through `run-as`, then
  `uiautomator dump` + `screencap` after 14 s.

## Result — reproduces on baseline for both locales

| Locale | Visible UI nodes after launch | logcat (verbatim excerpts) |
|---|---|---|
| `tr` / light | `Tekrar Hoş Geldiniz`, subtitle, `E-POSTA ADRESİ` only — no demo button, red error screen | `Warning: This application's locale, tr, is not supported by all of its localization delegates.` / `Another exception was thrown: No MaterialLocalizations found.` |
| `ar` / light | `مرحبًا بعودتك`, subtitle, `عنوان البريد الإلكتروني` only — no demo button, red error screen | `Warning: This application's locale, ar, is not supported by all of its localization delegates.` / `Another exception was thrown: No MaterialLocalizations found.` |

Evidence files (this directory):
`baseline_main_tr_light.png`, `baseline_main_tr_light.xml`,
`baseline_main_ar_light.png`, `baseline_main_ar_light.xml`.

The temporary worktree was removed after capture; the Phase 2 tree was never
built from or merged with it.

## Disposition

- **Status:** known, pre-existing, **release-blocking** for every non-English
  locale. Not caused by Phase 2 and not fixed in Phase 2.
- **Separate remediation task:** `LH-REL-001 — keep material_ui/cupertino_ui
  localization delegates through APK builds` (to be registered in the owner's
  tracker; no external tracker was touched here).
- **Owner:** Project Owner (github.com/mostafasayed118), per the repository's
  `> **Owner:**` convention. Implementation should be assigned by that owner to
  the app/platform maintainer; it needs its own branch, gates and approval.
- **Phase 2 workaround used only for capture:** a local, uncommitted delegate
  injection in `main.dart` (one import plus explicit
  `GlobalMaterialLocalizations.delegate` / `GlobalCupertinoLocalizations.delegate`
  entries) was applied to the **capture APK only** and reverted before the
  checkpoint commit and all gates. All AR/TR screenshots under `rendered/` and
  the AR strips under `comparison/` therefore used a **temporary startup
  workaround**; they document the intended UI, not a shippable APK.
