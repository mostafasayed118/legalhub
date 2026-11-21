/// Barrel for the auth-surface button widgets (one widget per file; this
/// file keeps the historical `auth_buttons.dart` import path working for
/// the sign-in / sign-up / password-recovery screens and their tests).
library;

import 'package:material_ui/material_ui.dart';

export 'editorial_divider.dart';
export 'loading_elevated_button.dart';
export 'social_button.dart';

/// Primary CTA treatment from the approved Stitch auth frames: gold label on
/// the navy button in light, gold fill with dark label in dark. Appearance
/// only — the caller owns the callback and the disabled/loading state.
ButtonStyle authPrimaryButtonStyle(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme.brightness == Brightness.dark
      ? ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
        )
      : ElevatedButton.styleFrom(foregroundColor: theme.colorScheme.secondary);
}
