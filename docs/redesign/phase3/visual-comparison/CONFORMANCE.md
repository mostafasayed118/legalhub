# Phase 3 visual conformance — per-surface record

Evidence: `docs/redesign/phase3/visual-comparison/rendered/` (108 screenshots: 9 surfaces × light/dark × phone/wide × EN/AR/TR), `comparison/` (30 human-reviewed sheets), approved references in `docs/redesign/phase3/reference-frames/`. No CI golden/screenshot tests.

## Inspected sheets (documented subset)

- `sign_in_light__phone_en.png`, `sign_in_dark__phone_en.png`
- `sign_up_dark__phone_en.png`, `forgot_email_*`, `otp_*`, `reset_*` (EN light/dark)
- `otp_locale_phone_light.png` (EN / AR RTL / TR)
- `wide_en_light.png`, `wide_ar_light.png`, `wide_tr_light.png`
- `account_*`, `onboarding_*`, `onboarding_success_*`, `delete_sheet_*`

Claims below come from those rendered images, not from automated theme/responsive tests.

## 1. Sign In

**Matches:** serif display heading + subtitle, gold "Forgot Password?" and "Create an account" links, outlined demo/social buttons, navy primary CTA with a **gold label in light** and **gold fill in dark** (the Phase 3 change), full-width fields with hairline borders, disabled Apple button with disclosure copy, LegalHub brand (not Lexis), pinned welcome copy.

**Differences / deviations:**
- Dark frame uses a photographic hero and a grouped card with uppercase gold labels; the app keeps its existing flat single-column layout. No hero asset exists and the change would restructure the surface beyond presentation-only styling.
- Frame's `256-BIT ENCRYPTED` pill and cropped status treatment are export artifacts, not requirements.
- Demo-session button and Apple disclosure remain (owner RETAIN rulings C4/C2).
- Uppercase field labels vs the light frame's title case — existing shared `LabelledField` is behaviorally pinned.

## 2. Sign Up

**Matches:** serif heading, four fields with icons, strength text, terms checkbox with privacy/terms links, sign-in prompt. Dark CTA uses gold fill when enabled.

**Differences:** the captured dark CTA appears disabled (grey) because the terms checkbox is unchecked — correct app behavior, not a styling miss. Password policy copy is the app's stronger pinned rule (≥12 chars, 3/4 classes) vs the frame's ≥8. Frame checkbox copy/links differ in wording; app copy retained (C1).

## 3. Forgot Password (email / OTP / reset)

**Matches:** serif headings, outlined email field, gold CTA label / gold dark fill, inline error + retry pattern, six-cell OTP, forced-LTR digits under Arabic RTL, resend/help copy, success SnackBar then `go(signIn)`.

**Differences:** app copy is the pinned l10n text; frame spacing differs slightly because exports are scaled. The three dark exports' correctness is verified against the ratified theme tokens, not against the broken dark artifacts (Reset Password dark is explicitly non-authoritative).

## 4. Onboarding + Success

**Matches:** three-page carousel, SKIP, progress dots, serif page titles, Continue/Get Started CTA now with gold label treatment, success badge + serif heading + CTA routing to sign-in.

**Differences:** frames use full-bleed photography; the app uses a tonal icon art block (documented in the source comment: "images in the designs are remote placeholders"). This is retained — adding stock imagery would be a new asset and a misrepresentation.

## 5. Account + Delete Account

**Matches:** Account screen cards and serif titles from Phase 2; danger card uses the dark errorContainer treatment (not the light-card artifact flagged for `36818a8c…`). Delete sheet keeps its typed `DELETE` + confirm-dialog flow and maps the standalone full-height frame onto the existing sheet/dialog surface.

**Differences:** frame-only extras (2FA, hardware devices, version footer, Bar ID, full-height cancel button) are out of scope; no new l10n keys or routes were added.

## Locale / layout observations

- Arabic RTL mirrors headers, back arrows, fields and nav chrome; OTP cells remain LTR as pinned by `otp_field_row_test.dart`.
- Turkish renders with the same Latin typography and gold accents.
- Wide (1280×800dp) uses the leading NavigationRail; its destination labels are not exposed to uiautomator, so capture used the same geometry-based rail tap proven in Phase 2.

## Artifact rulings applied

`46bf58e2…` (Delete Account dark), `cad6cccc…` (Reset Password dark), `36818a8c…` (Account dark Danger Zone) were treated as non-authoritative. Their correct dark treatment uses the ratified tokens and valid light references; no new tokens or behavior changes were introduced.
