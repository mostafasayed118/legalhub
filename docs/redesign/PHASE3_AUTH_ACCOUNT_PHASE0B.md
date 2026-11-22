# Phase 3 — Authentication + Account — Phase 0B Design-to-Implementation Traceability Matrix & Behavior Preservation Contract

Written: 2026-11-20 (Phase 0B — pre-implementation). Approve before Phase 3 begins.

> **Status:** Phase 0B mapping submitted for review. **STOP — Phase 3 implementation begins only after the owner explicitly approves this document.** No application code, tests, routes, theme implementation, Cubits, gateways, localization or project configuration may be touched during Phase 0B. This document is the only artifact added.

Predecessor state: Phase 2 accepted at local checkpoint `f80c9c3b2f07263d8bc094ede0e4c4b57bd1fbcb`, branch `redesign/stitch-alignment`, clean tree, 1 commit ahead of `main`, nothing pushed. `LH-REL-001` (AR/TR localization crash) remains a separate release-blocking issue and is **not** resolved by this wave. D12 (global button radius) is deferred to later-wave planning and is **not** part of Phase 3. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.

---

## 1. Authorities, frozen rules, and source limits

- **Authorities:** Stitch is the visual authority; the existing application is the behavioral authority. On conflict → STOP and ask for the owner's explicit decision (frozen rule 1, `docs/redesign/REDESIGN_EXECUTION_CONTRACT.md:11,28`).
- **12 frozen rules** are recorded at `REDESIGN_EXECUTION_CONTRACT.md:26-39`; the sole theme-token source is `lib/app/legalhub_theme.dart` (rule 2).
- **Rule 8:** tests are the contract — never edit/delete/skip/weaken to make green. Behavioral tests never change under the visual-value exception (`:35`).
- **Rule 6:** visual comparisons are human-reviewed wave artifacts, never CI golden/screenshot tests (`:33`).
- **Canvas sources (final closeout):** the Stitch MCP tool was unavailable to this agent, but the owner completed a live canvas investigation and supplied the four previously outstanding dispositions, cross-checked using the preview node-id method against the existing Sign Up frame record. Those owner-verified references are now recorded in §3; **no UNKNOWN frame references remain**. Other IDs below are taken verbatim from the committed Phase 0A contract (`REDESIGN_EXECUTION_CONTRACT.md:10`, §10) and the accepted Phase 2 0B doc (`PHASE2_SHELL_SETTINGS_PHASE0B.md:29-40`). Frame *content* was not re-read by this agent, so visual notes describe the existing app only; confirmed canvas absence (Check Inbox) is distinguished from unknown information.

---

## 2. Phase 3 scope (in / out)

**In scope — presentation only:**

| # | Surface | Route | Existing class |
|---|---|---|---|
| 1 | Sign In | `/sign-in` | `SignInScreen` (`lib/features/auth/presentation/sign_in_screen.dart:22`) |
| 2 | Sign Up (+ Check Inbox success state) | `/sign-up` | `SignUpScreen` + `_CheckInboxSuccess` (`sign_up_screen.dart:40`, `sign_up_check_inbox_success.dart:20`) |
| 3 | Forgot Password — email | `/forgot-password` | `ForgotPasswordEmailScreen` (`forgot_password/forgot_password_email_screen.dart:23`) |
| 4 | Forgot Password — OTP | `/forgot-password/otp` | `ForgotPasswordOtpScreen` (`forgot_password_otp_screen.dart:32`) |
| 5 | Forgot Password — reset | `/forgot-password/reset` | `ForgotPasswordResetScreen` (`forgot_password_reset_screen.dart:36`) |
| 6 | Onboarding (3 pages) | `/onboarding` | `OnboardingScreen` (`lib/features/onboarding/presentation/onboarding_screen.dart:20`) |
| 7 | Onboarding Success | `/onboarding/success` | `OnboardingSuccessScreen` (`onboarding_success_screen.dart:14`) |
| 8 | Account + delete-account sheet | `/settings/account` | `AccountScreen` (`lib/features/profile/presentation/account_screen.dart:25`) + `showDeleteAccountSheet` (`delete_account_sheet.dart:18`) |

**Out of scope (preserved as-is):**

- `/profile` (`ProfileScreen` + `profile_body.dart`) and its **legacy** `AuthCubit.deleteAccount` / `OrganizationGateway.deleteMyAccount` path (`profile_body.dart:19-62`; `auth_cubit.dart:207-217`). It is a separate deletion surface; see conflict C3 — it is not changed without an owner decision.
- Shell chrome, Home, Settings, legal documents, and every other shell route — unchanged after Phase 2 (`PHASE2_SHELL_SETTINGS_PHASE0B.md:44-58`).
- All FUTURE (13) and UNRESOLVED (8) frames listed at `PHASE2_SHELL_SETTINGS_PHASE0B.md:20-23`.
- LH-REL-001, D12, new routes, Cubits, gateway operations, capabilities, ARB keys, or refactors outside the eight surfaces above. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.

---

## 3. Exact Stitch frame references ↔ GoRouter mapping (DITM)

Canvas dimensions are 390×884 for the auth/onboarding frames (Phase 0A contract §10). `VARIANT` = dark twin, not a separate logical screen.

| # | Route | Existing class / state | Light frame ID | Dark frame ID (VARIANT) | Canvas class |
|---|---|---|---|---|---|
| 1 | `/sign-in` | `SignInScreen` | `54416f7ad13f4b009ffe50b69f97c0ff` | `6d476f197d98420fa2af90cf57a32403` | ROUTE |
| 2 | `/sign-up` | `SignUpScreen` (form) | `a0f76486f67e4c77a5ff624624eed19d` — Sign Up | `651c6c1ca3eb4036b2186a8731a3cdd1` — **Sign Up (Dark Mode)**, VARIANT of Sign Up (owner-verified via live canvas preview, cross-checked against the light Sign Up record) | ROUTE — logical screen Sign Up, route `/sign-up` |
| 2a | `/sign-up` success state | `_CheckInboxSuccess` | **NONE — confirmed absent from the live canvas** (not UNKNOWN). App-side STATE under the existing Sign Up logical screen / route `/sign-up`; parent frame `a0f76486f67e4c77a5ff624624eed19d` | N/A — same confirmed absence | STATE (app-side) under Sign Up — **design gap**: no separate Check Inbox frame exists, so no frame-to-render comparison is possible. Verify the existing success state through app rendering only. No new route, screen, or behavior is introduced |
| 3 | `/forgot-password` | `ForgotPasswordEmailScreen` | `5390dcea729443bda5d65876d526e060` | `636ad7a20bba46c0858c50871cb86f8a` | ROUTE |
| 4 | `/forgot-password/otp` | `ForgotPasswordOtpScreen` | `9f8c7a9a2ab243f994b69124c7555cb1` | `81a56588d703491897b01505576ab079` | ROUTE |
| 5 | `/forgot-password/reset` | `ForgotPasswordResetScreen` | `f79552e15f104e98adf1a3aa80bc733d` | `cad6cccc1a354874b9fc45833e1f0e95` | ROUTE |
| 6 | `/onboarding` | `OnboardingScreen` (3 pages) | `4ced08c665944138b4e08c5f4d10bca1` — Onboarding | `c806f8b038174736a4f007a4fad88677` — **Onboarding (Dark Mode)**, VARIANT of Onboarding (owner-verified via live canvas preview) | ROUTE — logical screen Onboarding, route `/onboarding` |
| 7 | `/onboarding/success` | `OnboardingSuccessScreen` | `0b4e281855a84188804fc306f7fca0e3` | `68844660ea2e4449b1ff381498b91e98` | ROUTE |
| 8 | `/settings/account` | `AccountScreen` | `9d1be566e6a44c91b03c02fa748c9261` | `36818a8c8db44d39a6a1ad8e6cf0c161` | ROUTE |
| 8a | `/settings/account` (existing sheet/dialog surface — **no new route**) | `showDeleteAccountSheet` | `9a52c7a5570143989da097c5cd5eb5fe` — **Delete Account** | `46bf58e2d83f45f39ef4532e9df92ee6` — **Delete Account (Dark Mode)** | VARIANT pair of the same logical **Delete Account** surface (owner-verified). **Representation distinction:** Stitch supplies standalone full-height design frames; the app uses its existing sheet (`showAppSheet`) + `showConfirmDialog`. Both design variants map to that existing surface — preserve sheet/dialog behavior, typed `DELETE`, and confirmation; do not create a full-screen route or change the interaction to imitate frame geometry |

**Canvas-cleanup item (not an implementation reference).** The live investigation also exposed a blank duplicate frame `4c3c467f05bd40eeae541da7e04290b0`. It is recorded solely as a **Stitch canvas-cleanup item** for the owner/design team; it is **not** an implementation reference, not a variant, and not a separate logical screen. It must not appear in any DITM implementation row or visual-comparison set.

**Final traceability check.** Every reference in the DITM is either a verified frame ID (rows 1–8, 8a), a confirmed absence (Check Inbox, row 2a), or a documented canvas-cleanup item (blank duplicate above). There are no UNKNOWN frame IDs and no unexplained classification gaps; confirmed absence is distinguished from unknown information.

Route constants: `AppRoutes.signIn … onboardingSuccess` at `lib/app/router.dart:69-75`, `settingsAccount` at `:78`. Builders: `router.dart:195-229`; `settings/account` is a shell route (`PHASE2_SHELL_SETTINGS_PHASE0B.md:50`). Redirect invariants: `router.dart:257-299` (public auth/onboarding/legal routes, `recoveryPending` → reset, authenticated-on-auth-route → home, pending invite resume).

Reference images already on disk for #8: `docs/redesign/phase2/visual-comparison/reference/account_{light,dark}.png` (accepted in Phase 2). Auth/onboarding reference images are **not** yet downloaded; that is implementation-time evidence work.

---

## 4. Behavior preservation contract (existing app is authoritative)

### 4.1 Sign In (`sign_in_screen.dart`)
- `AuthScaffold` + `Form` + `BlocListener<AuthCubit, AuthState>` (`:46-64`); max width `AppBreakpoints.authContentMaxWidth` (`:30,48`).
- Back `IconButton`: `canPop() ? pop : go(onboarding)` (`:106-114`), tooltip `back`.
- Email `LegalHubTextField` with `LegalHubValidators.email` (`:154-163`); password `PasswordField` with `required` (`:165-182`).
- "Forgot Password?" `TextButton` → `context.push(forgotPassword)` with an explicit 48px hit target (`:171-181`, pinned by `sign_in_screen_test.dart:178-184`).
- Submit `LoadingElevatedButton` → `AuthCubit.signIn(email.trim(), password)` behind `Form.validate()` (`:89-98,243-248`).
- Demo `OutlinedButton.icon` → `AuthCubit.startDemoSession()` rendered only when `supportsDemoSession` (`:73,188-230`); notice copy must stay.
- Google `SocialButton` → `signInWithGoogle()`; **Apple is disabled (`onTap: null`) with disclosure copy** (`:280-305`).
- Sign-up `TextButton` → `push(signUp)` (`:324-335`). Error → `SnackBar(signInErrorNotice)` only (`:56-63`). No dialog/sheet anywhere in `lib/features/auth`.

### 4.2 Sign Up (`sign_up_screen.dart`, `sign_up_check_inbox_success.dart`)
- Per-screen `BlocProvider<SignUpCubit>` (`:71-72`); four `TextFormField`s (full name/email/phone/password) — count pinned by `sign_up_screen_test.dart:88-89`.
- Password validator `strongPassword(l10n, email: _email.text)` + live `PasswordStrengthIndicator` (`:153-189`); strength labels are text, never color alone (test `:103-121`).
- Terms row: `MergeSemantics` + `Semantics(checked:)` and two `LegalLink`s to privacy/terms (`:191-236`); submit disabled until `_agreedToTerms && !loading` (`:263-270`).
- Error → inline `ViewStateView` with `Retry` calling `resetToEmpty()` (not resubmit) (`:249-262`); success replaces the form with `_CheckInboxSuccess` → `go(signIn)` (`:98-102`).

### 4.3 Forgot password (three screens)
- Email: `sendCode(email.trim())`; success → `SnackBar(codeSentNotice)` + `push(otp, extra: RecoveryRoutingContext(email, ''))` (`forgot_password_email_screen.dart:55-68,196-200`). Email travels in GoRouter **memory extra, never in the URL** (`recovery_routing_context.dart:7-16`).
- OTP: six-digit `OtpFieldRow` forced `Directionality.ltr` even under Arabic RTL (`otp_field_row.dart:136-145`, pinned by `otp_field_row_test.dart:68-86`); verify/resend both use the same email, success on resend stays on screen with a SnackBar (`forgot_password_otp_screen.dart:75-95,225-236`).
- Reset: `strongPassword(l10n, email: routing.email)` + `LegalHubValidators.matches`, `AutovalidateMode.onUserInteraction`; success → `SnackBar(resetSuccessNotice)` + **`go(signIn)`** (`forgot_password_reset_screen.dart:101-104,117-157`).
- All error retries call `resetToEmpty()`; errors localize to one generic notice via `localizeRecoveryError` (`recovery_error_localizer.dart:10-28`).

### 4.4 Onboarding
- 3 pages (`_pageCount = 3`), `PageController`, progress dots animate to page, Continue/Get Started switches at the last page (`onboarding_screen.dart:28-29,124-164,174-183`); Skip and Success complete via `OnboardingCubit.complete()` → `go(signIn)` (`:37-43`, `onboarding_success_screen.dart:17-23`).
- `OnboardingCubit` is a factory in the locator (`service_locator_core.dart:25-29`); first-run gate in `main.dart:122-131`. No dialogs/sheets, no loading/error states.

### 4.5 Account + deletion
- `MultiBlocProvider` creates `ProfileEditCubit` / `PasswordChangeCubit` from `serviceLocator<AccountGateway>()` / `<PasswordGateway>()` (`account_screen.dart:34-43`).
- Display name: `Semantics(accountDisplayNameLabel)`, `nameChanged`/`save`, save disabled when `saving || name.trim().length < 2`, success/error via SnackBar (`:124-173`).
- Password: strong-password + match + `PasswordStrengthIndicator`; `needsReauth` maps to `accountPasswordReauth`; submit clears fields on success (`:175-274`, `password_change_state.dart:23`).
- Delete sheet: typed **`DELETE`** (case-sensitive, trimmed, UI-enforced) → `showConfirmDialog` → `AccountDeletionCubit.delete()` → `pop(true)` → `AuthCubit.signOut()` + success SnackBar + `go(signIn)` (`delete_account_sheet.dart:46-61,108-149`; `account_screen.dart:105-121`).
- Typed guard is **UI-only** — `AccountDeletionState.canSubmit` accepts any non-empty string (`account_deletion_state.dart:20-21`). Do not change this inside Phase 3.
- `showAppSheet` uses a centered dialog on wide (≥840dp) and a bottom sheet on compact (`app_modal_sheet.dart:26-54`).

### 4.6 Cubit / gateway / route invariants
No changes to: `AuthCubit` (`auth_cubit.dart:16`), `SignUpCubit` (`sign_up_cubit.dart:20`), `PasswordRecoveryCubit` (`password_recovery_cubit.dart:19`), all `ViewState` types, `SignUpGateway`/`PasswordRecoveryGateway`/`AccountGateway`/`PasswordGateway`/`AuthGateway` interfaces and their fake/Supabase implementations, DI seams (`service_locator_auth.dart:12-93`, `service_locator_features.dart:378-391`), or the router table/redirect rules. No new ARB keys — existing keys inventoried (131 auth/account/onboarding keys plus recovery keys `codeSentNotice`, `otpIncompleteHint`, `resendCode`, `resendHelp`, `resetPasswordButton`, `resetPasswordTitle`, `resetSuccessNotice`, `sendCodeButton`, `recoverPasswordTitle/Body`, `recoveryErrorNotice`).

---

## 5. Existing states, dialogs, sheets, and interactions (inventory)

| Surface | States | Dialog/sheet | Navigation out |
|---|---|---|---|
| Sign In | initial/restoring/loading/authenticated/error (`AuthStatus`) → spinner + disabled controls; error SnackBar | none | `push(forgot)`, `push(signUp)`, `go(onboarding)`, shell via auth redirect |
| Sign Up | `ViewEmpty/ViewLoading/ViewError/ViewSuccess` → form / spinner / inline retry / check-inbox state | none | `go(signIn)`, `push(privacy/terms)` |
| Forgot email | `ViewLoading` spinner, `ViewError` inline retry, success SnackBar | none | `push(otp)` |
| Forgot OTP | complete/incomplete OTP, loading, error, resend vs verify success | none | `push(reset)` |
| Forgot reset | loading, inline error + retry, success SnackBar | none | `go(signIn)` |
| Onboarding | local page index only | none | `go(onboardingSuccess)` / `go(signIn)` |
| Onboarding success | none | none | `go(signIn)` |
| Account | saving/saved/lastError/needsReauth; buttons disabled or SnackBar | delete sheet + confirm dialog | `go(signIn)` after deletion |

No `showAppSheet`, `showConfirmDialog`, `showDialog` or `showModalBottomSheet` in `lib/features/auth` (grep-verified). Shared `showConfirmDialog` resolves cancel/dismiss/back to `false` (`confirm_dialog.dart:14-47`).

---

## 6. Explicit exclusions and boundaries

1. **No behavior change, no test change** (frozen rules 8, 12). Tests may not be edited to accommodate a redesign; if a frame conflicts with a pinned string/widget, escalate under §9.
2. **No ARB/config/gateway/cubit/route changes** — presentation-only styling inside the eight surfaces.
3. **`/profile` + legacy deletion path excluded** — owner ruling C3: both deletion paths stay unchanged and separate; no unification, redirect or refactor, and the legacy path remains outside Phase 3.
4. **LH-REL-001 excluded** — separate release-blocking issue. The AR/TR temporary startup workaround is a **verification limitation only**, not permission to change localization behavior; no fix in this wave. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
5. **D12 excluded** — global button radius stays deferred to a later wave; outside Phase 3 (see C6 disposition in §9).
6. **FUTURE/UNRESOLVED excluded** — per `PHASE2_SHELL_SETTINGS_PHASE0B.md:20-23`.
7. **No CI golden/screenshot tests** (frozen rule 6).
8. **No push/PR/merge**; one branch, clean checkpoint per wave (frozen rule 9).

---

## 7. Test baseline (frozen for this wave)

- Full suite: **2,447 passed / 13 skipped / 0 failed** (`docs/redesign/REDESIGN_EXECUTION_CONTRACT.md:21`; Phase 2 post-checkpoint tail `docs/redesign/phase2/PHASE2_EVIDENCE_REPORT.md:344`).
- Coverage baseline **84.6016%** (LH 18,466 / LF 21,827, contract `:22`); post-Phase-2 **84.6934%** (LH 18,619 / LF 21,984, evidence report `:200-201`). No test file changed in Phase 2 (`:202`).
- `flutter analyze` 0 issues; `dart format --output=none --set-exit-if-changed .` 837 files / 0 changed (contract `:19-20`; evidence report `:334-341`).

Auth/account pins that constrain presentation (no edits permitted):

- `test/features/auth/sign_in_screen_test.dart` (9 cases) — `'Welcome Back'` :61; no `'Lexis'`/`'LegalHub'` :63-64; demo labels :94-95; 48px forgot-link target :178-184; icons :220,:238-243; Google failure SnackBar string :283-288.
- `test/features/auth/sign_up_screen_test.dart` (7) — `'Create Account'`, 4 `TextFormField` :88-89; strength tiers :99-121; checkbox gate :130-142; check-inbox state :204-210.
- `test/features/auth/forgot_password_steps_test.dart` (7), `forgot_password_threading_test.dart` (3), `otp_field_row_test.dart` (7), `forgot_password_reset_screen_test.dart` (4), `forgot_password_reset_viewstate_test.dart` (1).
- `test/features/onboarding/onboarding_screen_test.dart` (7), `onboarding_success_screen_test.dart` (3), `onboarding_cubit_test.dart` (1).
- `test/features/profile/profile_screen_test.dart` (9), `test/features/coverage/high_risk_sheets_test.dart` (4 — typed `DELETE` gate :151-175), `test/features/profile/account_cubits_test.dart` (5+4), `test/shared/widgets/confirm_dialog_test.dart` (4).
- Router: `test/app/router_test.dart` (71), `router_unmatched_deep_link_test.dart` (5). Cubits/data: `auth_cubit_test.dart` (9+24), `password_recovery_cubit_test.dart` (1+9), `sign_up_cubit_test.dart` (1+5), gateway tests.
- A11y/responsive: `test/accessibility/guideline_test.dart:78-104` (12 screens, 48×48 targets), `theme_contrast_test.dart` (14 token pairs), `test/responsive/responsive_matrix_test.dart:132-140,174-324,342-372` (2.0/3.0, RTL), `responsive_smoke_test.dart:192-216`.

The `/settings/account` screen has **no dedicated widget test**; it is pinned only by accessibility/responsive matrices (`guideline_test.dart:87`, `responsive_matrix_test.dart:121`).

---

## 8. Proposed visual verification matrix (implementation time; human-reviewed)

- **Frames:** §3 IDs — all references now resolved (owner-verified); download and store the verified frames under `docs/redesign/phase3/visual-comparison/reference/` when implementation starts. Check Inbox has **no frame** (confirmed canvas absence): verify that app-side state by rendering only, with a design-gap note instead of a frame-to-render sheet. The blank duplicate `4c3c467f…` is a canvas-cleanup item and must not be captured as evidence.
- **Configurations:** 8 surfaces × 2 themes (light/dark) × 2 layouts (phone 411×914dp; wide 1280×800dp via `wm size 2560x1600` + `wm density 320`, rail breakpoint 840dp) × 3 locales (EN, AR RTL, TR) = **96 captures**. **Additional captures are required where applicable** for every relevant distinct state — loading, empty, error (with retry), success, check-inbox, OTP incomplete, resend, delete sheet, confirm dialog, and the 3-page onboarding sequence. The 96 is a baseline count, not a cap.
- **Comparison sheets:** frame-vs-render pairs per surface/theme (including both Delete Account variants mapped to the existing sheet/dialog surface — no full-screen route), locale strips (EN/AR/TR), wide-layout strips, and a state sheet for OTP incomplete / resend / error / success / delete-sheet / confirm-dialog. Check Inbox appears only as an app-rendered state sheet with an explicit "no frame — confirmed design gap" label; no frame-to-render comparison is possible. Store under `docs/redesign/phase3/visual-comparison/{rendered,comparison}/` with a per-surface `CONFORMANCE.md`.
- **Accessibility probes:** textScale 2.0 (and 3.0 where the responsive matrix pins it), 48×48 targets, WCAG pairs, RTL mirroring, OTP forced-LTR, focus order, sheet→dialog→back dismissal.
- **Capture caveat:** AR/TR captures will require the Phase 2 **temporary startup delegate workaround** until LH-REL-001 is fixed. Label those captures explicitly; do not fold the workaround into Phase 3 code. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
- **No CI golden/screenshot tests.** Evidence is for owner spot-check only.

---

## 9. Design-versus-behavior conflicts requiring owner decisions

| # | Conflict | App authority (pinned) | Owner ruling |
|---|---|---|---|
| C1 | Canvas Sign In / Sign Up headings vs pinned copy | `'Welcome Back'` (`sign_in_screen_test.dart:61`), `'Create Account'` (`sign_up_screen_test.dart:88`), and explicit absence of `'Lexis'`/`'LegalHub'` (`sign_in_screen_test.dart:63-64`) | **RETAIN** pinned copy and the existing absence of a brand name. No behavior or test change. |
| C2 | Frame social affordances vs disabled Apple | Apple `onTap: null` + disclosure copy (`sign_in_screen.dart:289-305`), pinned icons/disabled state (`sign_in_screen_test.dart:227-264`) | **RETAIN** the disabled Apple button and its disclosure copy. No behavior or test change. |
| C3 | Two account-deletion paths | Typed `DELETE` + dialog + `AccountGateway` (account screen) vs dialog-only + `AuthCubit.deleteAccount`/`OrganizationGateway` (`profile_body.dart:19-52`) | **KEEP BOTH UNCHANGED AND SEPARATE.** No unification, redirect, or refactor. The legacy `/profile` deletion path remains excluded from Phase 3; any future unification needs separate owner authorization. |
| C4 | Demo-session button on Sign In | Rendered only when `supportsDemoSession`; labels pinned (`sign_in_screen_test.dart:94-95`) | **RETAIN** the demo-session affordance. No behavior or test change. |
| C5 | OTP directionality under RTL | Forced LTR (`otp_field_row.dart:142-145`), pinned by `otp_field_row_test.dart:68-86` | **RETAIN** forced-LTR OTP behavior under Arabic RTL. Restyle around it only; no behavior or test change. |
| C6 | Global button radius (D12) | M3 stadium / app token | **DEFERRED** to a later wave; outside Phase 3. No change in this wave. |
| C7 | AR/TR visual evidence vs LH-REL-001 | Unmodified APK crashes for AR/TR | **RETAIN** the temporary startup workaround as a *verification limitation only* — it is not permission to change localization behavior. No localization fix or test change in Phase 3.  Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved. |

**C6 numbering disposition — explicit.** C6 was **not resolved by a design change and was not removed**. It appeared in the conflict register from the first submission (global button radius / D12) and remains present above as a documented, deferred item. The gap existed only in the parenthetical prose "C1–C5/C7" (previously in this section and in §11), where C6 was omitted by a numbering/transcription error in the summary, not from the register. The final register is continuous **C1–C7** with no conflict disappearing; C6's disposition is *deferred, outside Phase 3*.

**Rulings summary.** C1–C5 and C7: **RETAIN existing app behavior** — preserve pinned copy, the absence of a brand name, the disabled Apple button, the demo-session affordance, and forced-LTR OTP under Arabic RTL; the AR/TR workaround is a verification limitation, not authorization to change localization. C3: both deletion paths unchanged and separate; legacy `/profile` path excluded. C6: deferred (D12). These rulings authorize **no** behavior change and **no** test change.

---

## 10. DoD proposed for Phase 3 (to be approved with this package)

1. Eight in-scope surfaces implemented presentation-only; Settings/shell untouched.
2. No new routes/Cubits/gateways/capabilities/ARB keys; no behavior change.
3. All behavioral tests green; none weakened, deleted, skipped or modified.
4. Light/dark + EN/AR RTL/TR + phone/wide visual evidence produced and human-reviewed against §3 frames.
5. States verified: loading, error+retry, empty/success, check-inbox, OTP incomplete, delete sheet + confirm dialog.
6. Accessibility: 48×48 targets, textScale 2.0, WCAG pairs, RTL, OTP LTR, focus/dismissal.
7. Gates: `flutter analyze` 0, `dart format` 0 changed, full suite green, coverage reviewed against the baselines in §7.
8. Changed-file list, evidence, conformance report, deviations, gate outputs and DoD submitted.
9. Clean local Git checkpoint on `redesign/stitch-alignment`; no push/PR/merge.
10. Any unresolved conflict from §9 or gate failure → STOP and escalate.

---

## 11. Approval gate

> **STOP — final corrected Phase 0B (this document) resubmitted for review.** No application code, tests, routes, Cubits, gateways, localization or configuration were modified; no commit, push, PR or merge. All four previously outstanding Stitch references are resolved with owner-verified dispositions in §3 (Sign Up dark, Onboarding dark, Check Inbox confirmed-absent app STATE, Delete Account light/dark); no UNKNOWN frame references remain. Conflict register C1–C7 is continuous and retains the owner's rulings. Phase 3 implementation begins only after explicit owner acceptance and implementation authorization. D12 (C6) and LH-REL-001 (C7) remain separate. Phase C status (2026-11-22): fix committed locally as `b8a37fe` on `redesign/stitch-alignment` (parent `6bffe17`), one file `lib/main.dart`, unpushed, under an explicit owner waiver naming five unverified items: EN pixel comparison, real-tree AR/TR run, Cupertino rendering, per-delegate load results, preservation control. Fix verified in probe builds, gates green, real-tree AR/TR unproven; LH-REL-001 is not resolved.
