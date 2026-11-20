# Phase 2 — Shell + Settings — Phase 0B Design-to-Implementation Traceability Matrix & Behavior Preservation Contract

Written: 2026-11-19 (Phase 0B — pre-implementation). Approve before Phase 2 begins.

> **Status:** Phase 0B mapping submitted for review. **STOP — Phase 2 implementation begins only after the owner explicitly approves this document.** No application code, tests, routes, theme implementation, or project configuration may be touched during Phase 0B.

---

## 1. Phase 2 scope (in / out)

**In scope (Phase 2 — "Settings first, then shell/navigation chrome"):**

1. **Shell/navigation chrome** — `lib/app/router_app_shell.dart` (`_AppShell`) + `lib/app/router_shell_routes.dart` shell routes: the two-destination navigation (Home, Settings), bottom `NavigationBar` (compact widths) / leading `NavigationRail` (wide), `ResponsiveContent`, `FocusTraversalGroup` + `ReadingOrderTraversalPolicy`, tab-switch stack resets.
2. **Settings** — `SettingsScreen` (`lib/features/home/presentation/settings_screen.dart`, route `/settings`).
3. **Settings surface** — `AccountScreen` (`lib/features/profile/presentation/account_screen.dart`, route `/settings/account`) + its delete-account sheet (`lib/features/profile/presentation/delete_account_sheet.dart` with `AccountDeletionCubit`/`AccountDeletionState`).
4. **Home (shell destination)** — `HomeScreen` (`lib/features/home/presentation/home_screen.dart`, route `/home`).

**Out of scope (preserved as-is):**

- **Home boundary — Home dashboard content redesign remains Phase 4:** Phase 2 = the Home shell destination (`/home` — shell + navigation chrome only). Excluded — canvas FUTURE frames: Risk Dashboard Overview (`fa2caa1f` light, `4fff5d0e` dark), Regulatory Filings Dashboard (`48b13ef4`/`45478abd`), Advanced Analytics (`a07d44b0`/`c030e8f7`), Global Compliance Map (`ef01fe0f`/`f86c1432`).
- **All FUTURE screens (13)** — Risk Dashboard Overview (`fa2caa1f`), Regulatory Filings Dashboard (`48b13ef4`), Advanced Analytics (`a07d44b0`), Global Compliance Map (`ef01fe0f`), Conflict Resolution Dashboard (`46f277da`), Conflict Resolution Overview (`21e4ce4c`), Conflict Report Details (`4a47c262`), Compliance Audit Trail (`577eadb4`), Legal Draft Workspace (`5b83c122`), Citation Manager (`6e1cf06c`), Filing Submission Workspace (`800dad7f`), Statutory Research Browser (`e1f2157b`), Shared Case Workspace (`aa1c3c82`).
- **All UNRESOLVED screens (8) — corrected classification (per owner corrections):** five additional-screen frames — Article Reader (`79a066f6eae441c8bbf375dc78d64547`), Attorney Search (`9bed2290018a465eaef2e8908409d8ed`), Attorney Profile (`a247189c601b4aabaa797bb7f4186327`), Collaboration Task Board (`e9bc1ff60760418787eeff8ba1d5b50d`), Video Consultation (`dabd453bd2264c518fdcf9def5c4f071`) — plus three other frames — Conflict Analytics Report: Executive Summary (`26f5ee2d47b14e0a98c201349cf34d43`), Conflict Analytics: Ethical Wall Audit (`9aee581c56b7407e90577ff8aab69700`), Resolution Action: Ethical Wall (`03bc517f09354ba6bbd92cb9cdd63cf3`).
- **Phase 5 logical screens (NOT UNRESOLVED — per owner correction):** LegalDraft Workspace (`720c5967`) — moved out of the UNRESOLVED/additional lists (owner: "LegalDraft Workspace (720c5967) is a Phase 5 logical screen, NOT UNRESOLVED").
- New routes, Cubits, gateway operations, business capabilities, unrelated refactors.
- Settings-surface siblings reached from SettingsScreen (Profile, Notifications, Organizations, OrgAudit, AcceptInvitation, PlatformAdmin, Privacy, Terms) — destinations preserved; behavior unchanged.

---

## 2. Exact Stitch frame references (light + dark) for every in-scope screen and state

Canvas read: 2026-11-19 via `tools.stitch.get_project("projects/17670909757013221834").screenInstances` + `tools.stitch.get_screen` per instance (fresh read; dark twins = `(Dark Mode)` title suffix, classified VARIANT in the Phase 0A contract §14.6).

| GoRouter route | App class | Canvas frame — light | Canvas frame — dark |
|---|---|---|---|
| `/home` (Home) | `HomeScreen` | `bbd6d204ee0f48789f939269667b9134` — Home Dashboard | `90f8b78bf0b5447b8b98343dfacb8cd6` — Home Dashboard (Dark Mode) |
| `/settings` (Settings) | `SettingsScreen` | `d1d356aa7a814a4db9ca35938b591f59` — Settings & Localization | `802bbf259357438fbf857d3934b9f56b` — Settings & Localization (Dark Mode) |
| `/settings/account` (Account) | `AccountScreen` | `9d1be566e6a44c91b03c02fa748c9261` — Account Settings | `36818a8c8db44d39a6a1ad8e6cf0c161` — Account Settings (Dark Mode) |
| Shell (no canvas frame — app behavioral authority) | — | — | — |

Settings surface subtree (nested shells, preserved): Profile (`5f682e91` light / `ac45fbfa` dark) — read-only; Notifications (`a2fc5f88` / `5287dc44`); Organizations (`9d041152` / `c8c4c215`); OrgAudit (`f72cdebb`); AcceptInvitation (`5eb03497` / `4add7d49`); PlatformAdmin (`554af7e9` / `688eca3f`).

---

## 3. Existing GoRouter routes ↔ approved designs

| Route | Route builder (lib/app/router.dart + router_shell_routes.dart) | Phase 2 status |
|---|---|---|
| `/home` | ShellRoute → HomeScreen | In scope — shell destination (behavior preserved) |
| `/settings` | ShellRoute → SettingsScreen | In scope |
| `/settings/account` | ShellRoute → AccountScreen(initialDisplayName: session.displayName ?? '') | In scope — Settings surface |
| `/settings/privacy` | ShellRoute → LegalDocumentScreen(privacy) | Out — legal-doc surface (behavior preserved) |
| `/settings/terms` | ShellRoute → LegalDocumentScreen(terms) | Out — legal-doc surface (behavior preserved) |
| `/profile`, `/notifications`, `/organizations`, `/organizations/audit`, `/accept-invitation`, `/platform-admin(+/platform-admin/attorneys)` | ShellRoute → their screens | Out — Settings-surface navigation destinations (behavior preserved) |
| All other shell routes (`/book`, `/discovery`, `/discovery/:attorneyId`, `/matters*`, `/vault*`, `/messages*`, `/search`, `/invoices*`, `/alerts`, `/tasks`, `/video`, `/approvals`, `/research`, `/library*`) | ShellRoute → their screens | Out — unchanged (behavioral authority) |
| `/privacy`, `/terms` (top-level) | LegalDocumentScreen | Out — unchanged |
| All non-shell top-level routes | — | Out — unchanged |

**Shell's exactly two primary destinations: Home and Settings** — no new shell destinations are added in Phase 2.

---

## 4. Shell / navigation chrome — behavior preservation contract

From `lib/app/router_app_shell.dart` (all invariants — must hold during implementation):

- **Two destinations, fixed order:** `destinations = [(AppRoutes.home, NavigationDestination(Icons.home_outlined/home, l10n.homeNavigation)), (AppRoutes.settings, NavigationDestination(Icons.settings_outlined/settings, l10n.settingsNavigation))]` — "Destinations are rendered from capabilities in a fixed order (home, then settings)."
- **Capability-gated:** `canViewHome` / `canViewSettings` via `capabilityForRole(capabilitiesForRole, role)` (RoleCapability projection — navigation hint only, never authorization).
- **Graceful no-bar:** Material 3 NavigationBar requires ≥2 destinations; <2 rendered → no bar (no framework assert).
- **Tab-switch stack resets:** `selectDestination`: `while (router.canPop()) { router.pop(); } context.go(destinations[value].$1)`.
- **Settings-surface highlight:** `onSettingsSurface = location == settings || == settingsAccount || == profile || == organizations || == orgAudit || == acceptInvitation || onPlatformAdminSurface` → targetRoute = settings (highlight stays on the settings destination).
- **Responsive:** `useRail = width >= AppBreakpoints.expanded` (840 — `lib/shared/responsive/breakpoints.dart:16`); rail (`NavigationRail`, `labelType: all`, `minWidth: 72 * railTextScale`, SafeArea, VerticalDivider(width: 1)) when wide; `NavigationBar` when compact; bar hidden when `useRail || !showNavigation`; content capped by `ResponsiveContent` (840px, `responsive_content.dart`).
- **Rail text scale:** `railTextScale = textScaler.scale(14)/14 clamped [1.0, 3.0]` (at 2.0 the label must not overflow).
- **Deterministic desktop order:** `FocusTraversalGroup(ReadingOrderTraversalPolicy())` around body (rail leading pane, then content column).
- **SafeArea** around both rail and bar.
- **Scaffold** — no other chrome (no app bar — the shell has none; each destination screen provides its own AppBar).

---

## 5. SettingsScreen — existing interactions, dialogs, sheets, loading/error states, navigation

From `lib/features/home/presentation/settings_screen.dart` (197 lines — read 2026-11-19):

- **Scaffold** — `AppBar(title: Text(l10n.settingsTitle))`; `ListView(padding: EdgeInsetsDirectional.all(LegalHubTheme.marginMobile))` (RTL-safe padding).
- **Language section:** headlineMedium `Text(l10n.languageLabel)` + `SizedBox(spaceSm)` + `DropdownButtonFormField<Locale>` — items: `supportedLocaleCodes.map((code) => Locale(code)).map((locale) => DropdownMenuItem<Locale>(value: locale, child: Text(locale.languageCode.toUpperCase())))`; onChanged → `context.read<LocaleCubit>().setLocale(value)` (LocaleCubit validates against `supportedLocaleCodes`, persists via LocaleStore).
- **Theme section:** headlineMedium `Text(l10n.themeLabel)` + `DropdownButtonFormField<ThemeMode>` — `isExpanded: true`, items [system, light, dark] with `overflow: ellipsis` labels via `_themeModeLabel` (`l10n.themeModeSystem/Light/Dark`); onChanged → `context.read<ThemeCubit>().setThemeMode(value)`.
- **Role section (read-only):** ListTile — leading `Icon(Icons.person_outline)`; `title: RoleLabel(role)`; subtitle `localOnly ? l10n.demoSessionNotice : l10n.sessionNoticeConfigured` (`localOnly = backendIsLocalOnly`); reads `context.select<AuthCubit, UserRole?>((c) => c.state.session?.primaryRole)` (island rebuild — role row alone).
- **Navigation tiles (context.push → GoRouter):**
  - Profile — `Icons.person_outline`, `l10n.profileNavigation` → `AppRoutes.profile`;
  - Notifications — `Icons.notifications_outlined`, `l10n.notificationsTitle` → `AppRoutes.notifications`;
  - Organizations — `Icons.domain_outlined`, `l10n.orgTitle` → `AppRoutes.organizations`;
  - Accept invitation — `Icons.how_to_reg_outlined`, `l10n.acceptInvitationTitle` → `AppRoutes.acceptInvitation`;
  - Platform admin — `Icons.admin_panel_settings_outlined`, `l10n.platformAdminTitle` → `AppRoutes.platformAdmin`;
  - Account — `Icons.manage_accounts_outlined`, `l10n.accountTitle` → `AppRoutes.settingsAccount`;
  - Privacy — `Icons.privacy_tip_outlined`, `l10n.legalPrivacyTitle` → `AppRoutes.privacy`;
  - Terms — `Icons.description_outlined`, `l10n.legalTermsTitle` → `AppRoutes.terms`.
  (Spacings: `SizedBox(height: spaceSm/spaceXl)` between sections.)
- **Sign-out:** `OutlinedButton.icon(icon: Icon(Icons.logout), label: Text(localOnly ? l10n.signOut : l10n.signOutConfigured), onPressed: () => context.read<AuthCubit>().signOut())`.
- **No dialogs or sheets** on SettingsScreen itself. **No loading/error states** on SettingsScreen itself (fire-and-forget interactions — error handling lives in the Account cubits below).
- **RTL/localization:** all text via `AppLocalizations.of(context)`; `EdgeInsetsDirectional` for padding; ListView scrolling on narrow screens.

---

## 6. AccountScreen + delete-account sheet — existing interactions

From `lib/features/profile/presentation/account_screen.dart` (274 lines) + `delete_account_sheet.dart` + `account_deletion_cubit.dart`:

- **Scaffold** — `AppBar(title: Text(l10n.accountTitle))`; ListView (padding `EdgeInsetsDirectional.all(LegalHubTheme.marginMobile)`).
- **MultiBlocProvider:** `ProfileEditCubit(serviceLocator<AccountGateway>(), initialName: session.displayName)` + `PasswordChangeCubit(serviceLocator<PasswordGateway>())`.
- **Profile edit** (`_ProfileEdit`): `Text(l10n.accountProfileTitle, style: titleLarge)` + `LegalHubTextField` (controller seeded with `ProfileEditCubit.state.name`; Semantics label `l10n.accountDisplayNameLabel`) + `FilledButton` (`l10n.accountSave`; disabled when `state.saving || state.name.trim().length < 2`) + BlocConsumer: error → `_showError` SnackBar (`state.lastError.userMessage`); `saved` → SnackBar `l10n.accountSaved`.
- **Password change** (`_PasswordChange`): `Text(l10n.accountPasswordTitle, style: titleLarge)` + `LegalHubTextField` (new password — `obscureText`, Semantics `l10n.accountNewPasswordLabel`, validator `LegalHubValidators.strongPassword`) + `PasswordStrengthIndicator` (when text non-empty) + `LegalHubTextField` (confirmation — `obscureText`, Semantics `l10n.accountConfirmPasswordLabel`) + `FilledButton` (`l10n.accountChangePassword`; disabled when saving/empty/mismatch/invalid) + error listener → SnackBar (`state.needsReauth ? l10n.accountPasswordReauth : state.lastError!.userMessage`).
- **Danger zone:** `Text(l10n.accountDangerTitle, style: titleLarge.copyWith(color: error))` + `ListTile` (error-colored `Icons.delete_forever_outlined` + error-colored title `l10n.accountDeleteAction`; `onTap` → `_openDeleteSheet`).
- **`showDeleteAccountSheet`:** `showAppSheet<bool>` → `_DeleteAccountSheet` — facts (`l10n.accountDeleteRemovesTitle`: identity/library/files; `l10n.accountDeleteKeepsTitle`: others/storage/audit) + typed confirmation `TextField` (Semantics `l10n.accountDeleteConfirmLabel`; must type `'DELETE'`; `onChanged` → `AccountDeletionCubit.confirmationChanged`) + `FilledButton` (error colors; `CircularProgressIndicator` while `AccountDeletionStage.deleting`; `l10n.accountDeleteSubmit` / `l10n.accountDeleteInProgress`) → `showConfirmDialog(l10n.accountDeleteTitle, l10n.accountDeleteIntro, confirmLabel: l10n.accountDeleteSubmit)` → `AccountDeletionCubit.delete()` → done → `pop(true)`.
- **Post-sheet:** `AuthCubit.signOut()` → SnackBar `l10n.accountDeleteSuccess` → `context.go(AppRoutes.signIn)`.

---

## 7. Existing Cubit / gateway / dependency contracts that must remain unchanged

- **`ThemeCubit`** (`lib/app/theme/theme_cubit.dart`): `Cubit<ThemeMode>`, default `ThemeMode.system`; `load()` reads `ThemeModeStore`; `setThemeMode(mode)` — `ThemeModeStore.write(mode)` + `emit(mode)`. Consumers: `main.dart` (MaterialApp `themeMode` + `BlocProvider.value`), SettingsScreen (select/read).
- **`LocaleCubit`** (`lib/app/localization/locale_cubit.dart`): `Cubit<LocaleState>` (default `Locale('en')`); `load()` reads `LocaleStore`; `setLocale(locale)` — validates `supportedLocaleCodes`; `LocaleStore.write(locale)` + emit. Consumers: `main.dart` (MaterialApp `locale`), SettingsScreen (select/read), `LegalHubTheme.forBrightness(locale)` (font families via `kRtlLocaleCodes`).
- **`AuthCubit`** (`lib/features/auth/presentation/auth_cubit.dart` + `auth_cubit_base.dart` + `auth_cubit_hydration.dart`): `Cubit<AuthState>` (statuses: unauthenticated/restoring/loading/authenticated/reauthRequired/error; `session.primaryRole` projection); `signOut()` — gateway signOut + `_emitIfChanged(const AuthState.unauthenticated())`; consumers: SettingsScreen (role read), `_AppShell` (role read), AccountScreen (signOut after deletion).
- **`ProfileEditCubit` + `ProfileEditState`** (`profile_edit_cubit.dart`/`profile_edit_state.dart`): `nameChanged`, `save` (→ `AccountGateway.updateDisplayName`), `acknowledgeError`; state `{name, saving, saved, lastError}`.
- **`PasswordChangeCubit` + `PasswordChangeState`** (`password_change_cubit.dart`/`password_change_state.dart`): `newPasswordChanged`, `confirmationChanged`, `submit` (→ `PasswordGateway.changePassword`), `acknowledgeError`; state `{newPassword, confirmation, saving, changed, lastError, needsReauth}`.
- **`AccountDeletionCubit` + `AccountDeletionState`** (`account_deletion_cubit.dart`/`account_deletion_state.dart`): `confirmationChanged`, `delete` (→ `AccountGateway.deleteAccount`); stages `{idle, confirming, deleting, done}`; `canSubmit`; `isLastPartner` (`account_deletion_last_partner`); `isPlatformOwner` (`account_deletion_platform_owner`).
- **`AccountGateway`** (`domain/account_gateway.dart`): "Deliberately narrow: display name and account deletion. Avatar upload and email change are out of scope; identity comes from the session."
- **`PasswordGateway`** (`domain/password_gateway.dart`): `changePassword`; `PasswordErrors.reauthRequired` ("Sign in again before changing your password.").
- **`LegalHubValidators.strongPassword`** (`shared/forms/validators.dart`) — screen-side validation (server-side duplicated).
- **Shared widgets** — `LegalHubTextField`, `RoleLabel`, `AppBar`/`Scaffold` pattern, `DropdownButtonFormField`, `ListTile`, `OutlinedButton`/`FilledButton`, `SnackBar` errors, `PasswordStrengthIndicator`, `Divider`, `EdgeInsetsDirectional` throughout.
- **Router contract** (Phase 0A contract §12 frozen rules 1–12) — routes/shell unchanged; the two-destination shell; no new routes.

---

## 8. Responsive, localization, and RTL considerations

- **Shell:** `ResponsiveContent` caps the content column at 840px beside the rail (compact widths unaffected); rail vs bar swap at `AppBreakpoints.expanded` (840); rail text scale clamped 1.0–3.0 (2.0 accessibility ceiling — "Settings" label must not clip at rail width 72×scale); SafeArea on rail/bar; `FocusTraversalGroup(ReadingOrderTraversalPolicy())` for deterministic desktop order.
- **Settings/Account:** `EdgeInsetsDirectional` everywhere (mirror-aware in Arabic); all strings via `AppLocalizations` (app_en/app_ar/app_tr.arb — EN/AR/TR validated in Phase 2 DoD); `DropdownButtonFormField` with `isExpanded` (theme labels ellipsize in narrow surfaces); ListView scrolling (page heights vary at textScale 2.0/3.0 — responsive matrix tests already cover "key routes survive text scale 3.0"); Semantics labels on fields.
- **DoD (Phase 2 — to complete at Phase 2 closeout):** (1) SettingsScreen + shell implemented, Settings first; (2) exactly two shell destinations preserved (Home + Settings); (3) no new routes/Cubits/gateways/business capabilities/unrelated refactors; (4) behavioral tests green (none weakened/deleted/skipped — test-change approval exception not used unless a design assertion intentionally changes); (5) light, dark, English, Arabic RTL, Turkish verified (§8.1); (6) human-reviewed visual comparisons only (no CI golden/screenshot tests — see §10); (7) CI gates green: `flutter analyze` 0 issues, `dart format` 0 differences, full test suite passing; (8) changed-file list, visual evidence, test results, gate outputs, deviations, DoD checklist submitted; (9) branch + checkpoint/rollback discipline preserved (clean checkpoints per wave); (10) no push/PR/merge without approval; (11) Phase 0A evidence preserved; (12) behavior preservation contract (§4–§7) verified against the baseline before shipping; (13) spacing/radius/typography from Phase 0A §6 accepted — implementation reconciles against actual frames; (14) STOPS: any unresolved token conflict, behavioral change, scope expansion, or gate failure escalates immediately.

### 8.1 English/Arabic/Turkish + RTL validation (Phase 2 DoD item 5)

- All Phase 2 strings come from `AppLocalizations` — EN/AR/TR ARB sets preserved (Phase 0A contract §7 — AR ≡ TR, 0 diffs; EN-only 31 keys).
- Arabic (RTL): headings/body use `NotoNaskhArabic` (`kRtlLocaleCodes = {'ar'}` — `lib/core/localization/locale_rules.dart:2`); Turkish (Latin, not in the set) uses `PlayfairDisplay` + `NotoSans` — no Arabic glyphs in the Arabic UI.
- RTL-safe code: `EdgeInsetsDirectional` everywhere (Settings/Account); `ReadingOrderTraversalPolicy` (shell).
- Validation plan (§10): human-reviewed screenshots of `/home`, `/settings`, `/settings/account` in light + dark × EN/AR/TR; textScale 2.0/3.0 survival ("key routes survive text scale 3.0").

---

## 9. Existing test baseline (Phase 2 — preserved behavior)

Full-suite baseline (Phase 0A gates; §2): **2,447 pass / ~13 skipped / 0 failed — "All tests passed!"** — with `flutter analyze` 0 issues + `dart format` 0 changed (§14.7).

Shell/Settings-relevant tests that must remain green (DoD item 4 — no weaken/delete/skip; the test-change approval exception is not used):

- `test/app/router_test.dart` — shell NavigationBar groups: "shell NavigationBar selected index" (line 1286); "renders no NavigationBar when only Home is visible (canViewSettings …)" (line 1397); "renders no NavigationBar when only Settings is visible (canViewHome …)" (line 1452); "renders no NavigationBar when no destination is visible" (line 1524).
- `test/app/widget_test.dart:92` — "target in _AppShell, not a hardcoded index — pinned end-to-end" (the shell's two-destination semantics).
- `test/core/roles/user_role_test.dart:162-179` — "_AppShell renders a bottom-NavigationBar destination for exactly two visible destinations" (graceful no-bar).
- `test/features/home/settings_screen_test.dart` — 12 testWidgets: language dropdown → `LocaleCubit.setLocale(AR)`; sign-out → `AuthCubit.signOut`; role row rescopes to Client after sign-out; theme dropdown → `ThemeCubit.setThemeMode(Dark)`; persisted theme pre-selects; post-navigation reachability ("notifications tile navigates", "organization tile navigates", "accept-invitation tile navigates", "profile tile navigates").
- `test/accessibility/theme_contrast_test.dart` — WCAG 2.2 contrast floors (light + dark) on the theme tokens.
- `test/app/legalhub_theme_test.dart` — theme token pins.

---

## 10. Proposed Phase 2 verification evidence (Phase 2 — human-reviewed; no CI golden/screenshot tests — DoD item 6)

- **Screens + links (§2):** `/home` — Home (light `bbd6d204ee0f48789f939269667b9134` / dark `90f8b78bf0b5447b8b98343dfacb8cd6`); `/settings` — Settings (light `d1d356aa7a814a4db9ca35938b591f59` / dark `802bbf259357438fbf857d3934b9f56b`); `/settings/account` — Account (light `9d1be566e6a44c91b03c02fa748c9261` / dark `36818a8c8db44d39a6a1ad8e6cf0c161`).
- **Layouts:** phone (bottom `NavigationBar`; destinations in fixed order Home, Settings) + expanded width (leading `NavigationRail` — `AppBreakpoints.expanded` = 840 — §4); `SafeArea` on rail/bar; `FocusTraversalGroup(ReadingOrderTraversalPolicy())`.
- **Locales:** English, Arabic (RTL — `NotoNaskhArabic` — §8.1), Turkish (Latin — `PlayfairDisplay` + `NotoSans` — §8.1).
- **Accessibility:** textScale 2.0/3.0 survival ("key routes survive text scale 3.0" — `test/responsive/responsive_matrix_test.dart`); rail text-scale clamp [1.0, 3.0] (§4); WCAG pairs (§9).
- **Visual comparison:** human-reviewed screenshots of `/home`, `/settings`, `/settings/account` (light + dark; EN/AR/TR where relevant) vs the §2 canvas frames — stored with the wave change-log entry at Phase 2 closeout. No CI golden/screenshot tests (contract rule 6).

---

## 11. Unresolved frames or decisions (Phase 0B review)

None identified for the Phase 2 scope — all in-scope frames are canvas-linked (IDs in §2). Recorded for Phase 0B approval:

1. **The shell has no canvas frame** — the canvas defines the Home + Settings shell (behavioral authority: `_AppShell` + Home + Settings destinations); the canvas ROUTE tables for `/home` and `/settings`/`/settings/account` are the links.
2. **AccountScreen (`/settings/account`)** — canvas "Account Settings" frames (`9d1be566` light / `36818a8c` dark) — app renders via `AccountScreen(initialDisplayName: session.displayName)` — behavior preserved.
3. **Excluded screens** — 13 FUTURE + 8 UNRESOLVED (§1) — excluded per the authorization; LegalDraft Workspace (`720c5967`) classified as a Phase 5 logical screen per the owner correction (§1); no other open decisions.
4. **UNRESOLVED dark twins (fresh-read IDs — secondary relationships, recorded not double-counted):** Article Reader `0327dbb667a34310ace8f89d6d2d7315`, Attorney Profile `d57ac66bdffe4c34b73afc84dd3c2bad`, Attorney Search `2e344ac6edc948708eecb61f43761181`, Collaboration Task Board `b166e5005c8c4ab9aeec3faceb735204` + `d0a20d00ef5046829d96822cbc856970`, Conflict Analytics Report: Executive Summary `3dc2d7d3ac5747f4b613d1e4de5e7a38`, Conflict Analytics: Ethical Wall Audit `1cba863d0c8d4d03aab8a6a447a2b844`, Resolution Action: Ethical Wall `b89e52b625344772bbdc2b568421b306`, Video Consultation `e09aacd1ae754d589823c928c52cb4b4` — all classified VARIANT by the fresh read (dark twins of the UNRESOLVED light frames).

---

## 12. Approval gate

> **STOP — Phase 0B (this document) submitted for review.** Once the owner explicitly approves this Phase 0B traceability matrix + behavior preservation contract, Phase 2 begins: **Settings first, then shell/navigation chrome.** Any deviation from §4–§7 requires the owner's explicit call (scope, behavioral change, architectural boundary violation).
