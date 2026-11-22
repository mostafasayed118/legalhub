# Phase 3 — Authentication + Account — implementation and evidence report

Status: **Phase 3 wave complete — awaiting owner review.** Phase 4 has **not** been started.

Branch: `redesign/stitch-alignment`. Starting checkpoint: `f80c9c3b2f07263d8bc094ede0e4c4b57bd1fbcb`. Local checkpoint commit is recorded in the closeout message / `git log -1`. Nothing pushed.

---

## 1. Scope delivered

Presentation-only changes across the eight accepted surfaces: Sign In, Sign Up (incl. check-inbox success state), Forgot Password email/OTP/reset, Onboarding, Onboarding Success, and Account + delete-account sheet. No routes, Cubits, gateways, capabilities, ARB keys, tests, or configuration were changed.

The Phase 3 change itself is deliberately small because the Phase 1 foundation and Phase 2 work had already aligned most layout/typography: the approved auth frames call for a **gold primary action treatment** (gold label on navy in light, gold fill with dark label in dark), which was missing. That treatment is now applied consistently through a local auth helper.

---

## 2. Changed source files (exactly nine)

| File | Change |
|---|---|
| `lib/features/auth/presentation/widgets/auth_buttons.dart` | Added `authPrimaryButtonStyle(BuildContext)` — gold CTA treatment from the approved frames; appearance only |
| `lib/features/auth/presentation/widgets/loading_elevated_button.dart` | Added optional `style` passthrough to the existing `ElevatedButton` |
| `lib/features/auth/presentation/sign_in_screen.dart` | Primary CTA uses the new style |
| `lib/features/auth/presentation/sign_up_screen.dart` | Primary CTA uses the new style |
| `lib/features/auth/presentation/forgot_password/forgot_password_email_screen.dart` | Send-code CTA uses the new style |
| `lib/features/auth/presentation/forgot_password/forgot_password_otp_screen.dart` | Verify CTA uses the new style |
| `lib/features/auth/presentation/forgot_password/forgot_password_reset_screen.dart` | Reset CTA uses the new style |
| `lib/features/onboarding/presentation/onboarding_screen.dart` | Continue / Get Started CTA uses the new style |
| `lib/features/onboarding/presentation/onboarding_success_screen.dart` | Success CTA uses the new style |

No other source file changed. `lib/app/legalhub_theme.dart` remains untouched as the sole token source; no new tokens were introduced.

---

## 3. Behavior preservation

- All routes (`/sign-in`, `/sign-up`, `/forgot-password*`, `/onboarding*`, `/settings/account`) and redirect rules unchanged.
- All Cubits, states, gateways, validation, SnackBar/inline error handling, resend/verify/reset flows, typed `DELETE` confirmation, and both deletion paths unchanged and separate. The legacy `/profile` deletion path remains excluded.
- Owner rulings honored: pinned copy, LegalHub brand (no Lexis), disabled Apple button + disclosure, demo-session affordance, forced-LTR OTP under Arabic RTL. No behavior or test change was made for these rulings.
- D12 (global button radius) remains deferred; LH-REL-001 remains separate and release-blocking. The AR/TR captures used the same temporary startup delegate injection as Phase 2, reverted before the checkpoint and gates — a verification limitation, not a localization change. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.

---

## 4. Evidence inventory

- Staged approved references: `docs/redesign/phase3/reference-frames/` — 18 verified PNGs + `MANIFEST.md` + `MCP_DIAGNOSIS.md`.
- Raw renders: `docs/redesign/phase3/visual-comparison/rendered/` — **108 screenshots** = 9 surfaces × light/dark × phone/wide × EN/AR/TR (the accepted 96-capture matrix plus delete-sheet and onboarding/success states).
- Comparison sheets: `docs/redesign/phase3/visual-comparison/comparison/` — **30 sheets**: 18 frame-vs-render pairs (EN), 9 locale strips (EN/AR/TR), 3 wide-layout strips.
- Per-surface findings: `docs/redesign/phase3/visual-comparison/CONFORMANCE.md`.
- Agent-inspected, owner review pending; no CI golden/screenshot tests.
- Unproven evidence item (Round 19): dark OTP phone TR after SnackBar dismissal, the surface could not be reached; the TR sign-in screen renders the known `LH-REL-001` `No MaterialLocalizations found` error overlay, so no post-dismissal TR OTP capture exists. Enabled Sign Up CTA is not listed here: it was proven in Round 19 by uncommitted captures outside the repo. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
- Unproven evidence item (light-label verification): the CTA loading state was not observed; three bounded attempts on Sign In captured the filled form and the post-sign-in home shell, but no frame showed the CTA spinner. Code-analysis only, not observed: loading sets `onPressed: null`, resolving to the M3 disabled colors, and the spinner uses `colorScheme.primary`, not `foregroundColor`.
- Note: 10 of the 10 enabled light CTA captures were refreshed — the phone `en` renders on 2026-11-21 and the wide `en` renders on 2026-11-22 (label change in commit `8a07016`). The earlier wide probe ran under swiftshader (software rasteriser) and showed 1-LSB drift; under default GPU the two class-(c) controls (`account_light_wide_en.png`, `delete_sheet_light_wide_en.png`) reproduce clock-only with body diff 0, so all 5 wide `en` captures were refreshed on default GPU. Any capture run must use default GPU; phone results are default-GPU only. The 20 `ar`/`tr` light CTA captures remain stale and unreproduced (`LH-REL-001` blocks AR/TR). No full-matrix refresh or verification is claimed. Disabled CTA fill is `#DCDEE6` (not `#DCDCE4`), label `#8D95A0`. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
- Note: exactly one comparison sheet embeds the 5 refreshed wide captures — `wide_en_light.png`. The generator builds frame/render pairs and locale strips from phone renders; only the `wide_*_light.png` strips consume wide renders.
  - Superseded probe note: the earlier `p4_probe_run1`/`p4_probe_run2` sha256 lists described a swiftshader run and are withdrawn. Default-GPU control captures were kept outside the repo at `C:\Users\ASUS\AppData\Local\Temp\opencode\p4_item2_controls` and `C:\Users\ASUS\AppData\Local\Temp\opencode\p4_wide_refresh`, uncommitted; the class-(c) control sha256 values from the refresh session were `account_light_wide_en.png` `13f6ae49101f33d309a48ad9f1247eea6c08c505c326850b64b5d68d46081bd7` and `delete_sheet_light_wide_en.png` `181b30891b91aded70b3f0e7399459afd1f42cdbc1a122bb6e58091a94adf8e6`.

---

## 5. Deviations / artifact rulings

| # | Item | Disposition |
|---|---|---|
| 1 | Dark Sign In hero/card vs app flat layout | No hero asset exists; retained app layout. Gold CTA applied. |
| 2 | Lexis wordmark in frames | Not app copy authorization; LegalHub retained (owner ruling). |
| 3 | Demo button + Apple disclosure | RETAIN (owner rulings C4/C2). |
| 4 | Uppercase labels vs light frame title case | Shared `LabelledField` retained; behavior pinned. |
| 5 | Onboarding photo hero | Remote placeholder in canvas; tonal art block retained. |
| 6 | Sign-up password policy copy | App's stronger pinned validator retained. |
| 7 | Delete Account dark `46bf58e2…` | Broken light-canvas export — not an implementation target; ratified dark tokens used. |
| 8 | Reset Password dark `cad6cccc…` | Broken pale export — not an implementation target; ratified dark tokens used. |
| 9 | Account dark `36818a8c…` Danger Zone | Light-card section artifact — dark danger card used. |
| 10 | Delete Account full-height frame | Mapped to existing sheet + confirm dialog; no new route/behavior. |
| 11 | Check Inbox | No Stitch frame (confirmed absent); app-render-only STATE under Sign Up. |
| 12 | LH-REL-001 | Separate release-blocking issue; temporary capture-only workaround labeled; not fixed here.  Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved. |
| 13 | Light CTA label contrast vs approved Stitch frame | App label `#775A19` on fill `#0B1D2E` measures **2.65:1**; approved reference label `#FFDEA5` on fill `#041627` measures **14.13:1**. Owner decision (2026-11-21, as relayed): align the light CTA label to the reference `#FFDEA5`. Implemented in commit `8a07016` (option (a), one file `auth_buttons.dart`), contrast **13.2125:1**. Refresh: 10 of 10 enabled light CTA captures (phone `en` on 2026-11-21, wide `en` on 2026-11-22, both default GPU); the 20 `ar`/`tr` light CTA captures remain stale and unreproduced (`LH-REL-001`). Any capture run must use default GPU. Gates analyze 0, format 0, tests 2,447 pass / 13 skip / 0 fail; disabled fill `#DCDEE6` / label `#8D95A0` proves no leak; leading icon changed with the label as authorized.  Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved. |

---

## 6. Gates

Commands run from `C:\flutter_projects\law_app`, Flutter 3.50.0, after the checkpoint (full tails in the closeout message):

| Gate | Result |
|---|---|
| `flutter analyze` | No issues found (exit 0) |
| `dart format --output=none --set-exit-if-changed .` | 0 changed (exit 0) |
| `flutter test --coverage` | 2,447 passed / 13 skipped / 0 failed (exit 0) |
| Coverage | 84.7018% (LH 18,631 / LF 21,996) vs post-Phase-2 84.6934% (18,619 / 21,984) — **+0.0084 pp**; baseline 84.6016% (18,466 / 21,827) |

No test was weakened, deleted, skipped, or modified.

---

## 7. Definition of Done (14 items)

| # | Item | Status |
|---|---|---|
| 1 | All in-scope frames classified/mapped | Done — §4, accepted Phase 0B DITM |
| 2 | No unauthorized routes added | Verified — no route file changed |
| 3 | Light and dark verified | Done — render pairs + wide strips |
| 4 | EN, AR RTL, TR verified | Done — locale strips + 108 renders |
| 5 | Existing interactions preserved | Verified — §3; full suite green |
| 6 | Cubit/gateway contracts preserved | Verified — no cubit/gateway file changed |
| 7 | Loading/error/empty/populated states verified | Behavioral suite green; state screenshots include check-inbox, OTP-incomplete, disabled CTA, delete sheet |
| 8 | Agent-inspected design comparisons | 30 sheets agent-inspected; owner review pending, no CI goldens |
| 9 | No unapproved test modifications | Verified — `test/` untouched |
| 10 | `flutter analyze` 0 | Verified |
| 11 | `dart format` 0 changed | Verified |
| 12 | Full suite green | Verified |
| 13 | Coverage reviewed vs baseline | Verified — +0.0084 pp vs post-Phase-2 |
| 14 | Change log and evidence documented | This report + CONFORMANCE.md + manifests |

---

## 8. Git

One local checkpoint commit on `redesign/stitch-alignment` containing only the nine presentation files and the Phase 3 documentation/evidence. Nothing pushed, no PR, no merge. Worktrees unchanged; no parallel worktree used for implementation.

## Phase C closeout (2026-11-22)

- Fix: `b8a37fe` on `redesign/stitch-alignment`, parent `6bffe17`, one file `lib/main.dart`, local and unpushed. Owner waiver granted 2026-11-22 naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Status: fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
- EN visual comparison retry (Task 2): attempted once on fresh AVD `LH_Fresh_36` (API 36) with default GPU. UIAutomator confirmed Sign In, Sign Up, Forgot and Onboarding, but all four `screencap` frames were flat black at 15,580 bytes with identical SHA-256 `c35bacdb98b522206335afa5b9baffd2e4e3352a40749bb747e469cd403af514`. No tight pixel comparison was possible; this remains an environmental blocker and no pixel identity is claimed.
- AR/TR screenshot refresh (Task 3): stopped at the read-only inventory. `docs/media/screenshots/` contains 16 tracked files total, of which 3 are AR (`01_home_ar.png`, `07_library_ar.png`, `08_article_reader_ar.png`) and none are TR — not the expected 20. No re-capture was run and no screenshot was hand-edited.
- Gates at the Phase B commit and again at Phase C start: `flutter analyze` 0 issues; `dart format` 837 files, 0 changed; `flutter test` 2,447 passed / 13 skipped / 0 failed.
- AR/TR light-CTA refresh (2026-11-22 follow-up, corrected capture path): one new host-only, env-gated test file `test/screenshots/capture_rendered_ar_tr_test.dart` was added (`CAPTURE_RENDERED_AR_TR=1`, a distinct var — `CAPTURE_SCREENSHOTS=1` alone does not trigger it). Its dual-locale `sign_in` phone probe passed (fork `GlobalMaterialLocalizations` present at the capture context, no LH-REL-001 crash). All 20 stale captures (5 surfaces × AR/TR × phone/wide) were rendered into a temp staging dir, verified non-black with correct locale/screen/light theme, expected title text, and CTA tight-box label `#FFDEA5` on `#0B1D2E` within ±1 — 20/20 PASS — then promoted by temp-name atomic replace. The other 88 PNGs in `rendered/` are byte-identical and `git diff --stat` lists only the 20. These are **test-harness renders, not release builds, not evidence for LH-REL-001**; review status is **agent-inspected, owner review pending**. LH-REL-001 stays OPEN. Caveat: the harness writes logical-size images (360×800 phone / 1280×800 wide) rather than the prior 3×/2× renders, so the 20 refreshed files are lower-resolution.
