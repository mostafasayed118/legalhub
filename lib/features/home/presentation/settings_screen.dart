import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:legalhub/app/legalhub_theme.dart';
import 'package:legalhub/app/localization/locale_cubit.dart';
import 'package:legalhub/app/router.dart';
import 'package:legalhub/app/service_locator.dart';
import 'package:legalhub/app/theme/theme_cubit.dart';
import 'package:legalhub/core/roles/user_role.dart';
import 'package:legalhub/data/local/locale_store.dart';
import 'package:legalhub/features/auth/presentation/auth_cubit.dart';
import 'package:legalhub/l10n/app_localizations.dart';
import 'package:legalhub/shared/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static final List<Locale> _locales = <Locale>[
    for (final String code in supportedLocaleCodes) Locale(code),
  ];

  static const List<ThemeMode> _themeModes = <ThemeMode>[
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark,
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    // Island rebuilds: each row selects only the slice it renders — a locale
    // change doesn't rebuild the theme or role rows and vice versa.
    final Locale locale = context.select<LocaleCubit, Locale>(
      (LocaleCubit cubit) => cubit.state.locale,
    );
    // The identity card reads just the projected role and name, not the whole
    // auth state: a status/error change that leaves them alone must not
    // rebuild it.
    final UserRole? role = context.select<AuthCubit, UserRole?>(
      (AuthCubit cubit) => cubit.state.session?.primaryRole,
    );
    final String? displayName = context.select<AuthCubit, String?>(
      (AuthCubit cubit) => cubit.state.session?.displayName,
    );
    final ThemeMode themeMode = context.select<ThemeCubit, ThemeMode>(
      (ThemeCubit cubit) => cubit.state,
    );
    // The identity card and the sign-out label describe the SESSION: a demo
    // session is not a real account, so the copy follows the backend posture
    // instead of calling a configured account a demo.
    final bool localOnly = backendIsLocalOnly;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        // Serif title: the canvas chrome sets every screen heading in the
        // display face, and AppBar's default titleLarge is the body face.
        title: Text(
          l10n.settingsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          LegalHubTheme.marginMobile,
          LegalHubTheme.spaceMd,
          LegalHubTheme.marginMobile,
          LegalHubTheme.marginMobile,
        ),
        children: <Widget>[
          _IdentityHeader(
            displayName: displayName,
            role: role,
            notice: localOnly
                ? l10n.demoSessionNotice
                : l10n.sessionNoticeConfigured,
          ),
          const SizedBox(height: LegalHubTheme.spaceSm),
          // Preferences: the two persisted choices, grouped in one card the
          // way the canvas groups Language and Theme.
          _SettingsCard(
            children: <Widget>[
              _PreferenceRow<Locale>(
                icon: Icons.translate,
                label: l10n.languageLabel,
                value: locale,
                items: _locales
                    .map(
                      (Locale value) => DropdownMenuItem<Locale>(
                        value: value,
                        child: Text(value.languageCode.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (Locale? value) {
                  if (value != null) {
                    context.read<LocaleCubit>().setLocale(value);
                  }
                },
              ),
              _GroupDivider(indent: 52),
              _PreferenceRow<ThemeMode>(
                icon: Icons.brightness_6_outlined,
                label: l10n.themeLabel,
                value: themeMode,
                items: _themeModes
                    .map(
                      (ThemeMode mode) => DropdownMenuItem<ThemeMode>(
                        value: mode,
                        child: Text(
                          _themeModeLabel(context, mode),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    context.read<ThemeCubit>().setThemeMode(value);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: LegalHubTheme.spaceSm),
          // Destinations reached from Settings. Order is unchanged from the
          // pre-redesign list; only the chrome around the rows is new.
          _SettingsCard(
            children: _separated(<Widget>[
              _SettingsTile(
                icon: Icons.person_outline,
                title: l10n.profileNavigation,
                onTap: () => context.push(AppRoutes.profile),
              ),
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: l10n.notificationsTitle,
                onTap: () => context.push(AppRoutes.notifications),
              ),
              _SettingsTile(
                icon: Icons.domain_outlined,
                title: l10n.orgTitle,
                onTap: () => context.push(AppRoutes.organizations),
              ),
              _SettingsTile(
                icon: Icons.how_to_reg_outlined,
                title: l10n.acceptInvitationTitle,
                onTap: () => context.push(AppRoutes.acceptInvitation),
              ),
              // Platform-admin entry (P3.5): a navigation hint for any
              // authenticated user — the owner-only RPCs gate server-side, and
              // a non-owner sees the distinct denied state, never empty
              // success.
              _SettingsTile(
                icon: Icons.admin_panel_settings_outlined,
                title: l10n.platformAdminTitle,
                onTap: () => context.push(AppRoutes.platformAdmin),
              ),
              _SettingsTile(
                icon: Icons.manage_accounts_outlined,
                title: l10n.accountTitle,
                onTap: () => context.push(AppRoutes.settingsAccount),
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: l10n.legalPrivacyTitle,
                onTap: () => context.push(AppRoutes.privacy),
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: l10n.legalTermsTitle,
                onTap: () => context.push(AppRoutes.terms),
              ),
            ], indent: 52),
          ),
          const SizedBox(height: LegalHubTheme.spaceMd),
          // Destructive action: error-coloured outline, as in the canvas.
          OutlinedButton.icon(
            onPressed: () => context.read<AuthCubit>().signOut(),
            icon: const Icon(Icons.logout),
            label: Text(localOnly ? l10n.signOut : l10n.signOutConfigured),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.error,
              side: BorderSide(color: colors.error.withValues(alpha: 0.55)),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LegalHubTheme.radiusXl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _themeModeLabel(BuildContext context, ThemeMode mode) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return switch (mode) {
      ThemeMode.system => l10n.themeModeSystem,
      ThemeMode.light => l10n.themeModeLight,
      ThemeMode.dark => l10n.themeModeDark,
    };
  }
}

/// Card surface shared by the settings groups: 1px outline, 12px radius, the
/// raised surface colour for the active brightness.
class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final BorderRadius radius = BorderRadius.circular(LegalHubTheme.radiusXl);
    // Material (not DecoratedBox) so ListTile ink splashes paint on the card
    // surface instead of being hidden behind an opaque decoration.
    return Material(
      color: colors.brightness == Brightness.dark
          ? colors.surfaceContainerLow
          : colors.surfaceContainerLowest,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

/// One preference row inside a [_SettingsCard]: leading glyph, row label, and
/// the selected value as a compact dropdown on the trailing edge — the shape
/// the canvas gives Language and Theme. The dropdown is [Flexible] and
/// expanded so a long value ellipsizes instead of overflowing at narrow
/// widths or text scale 2.0.
class _PreferenceRow<T> extends StatelessWidget {
  const _PreferenceRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: LegalHubTheme.spaceMd,
        vertical: LegalHubTheme.spaceXs,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: colors.onSurfaceVariant),
          const SizedBox(width: LegalHubTheme.spaceMd),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: LegalHubTheme.spaceSm),
          Flexible(
            child: DropdownButtonFormField<T>(
              initialValue: value,
              isExpanded: true,
              isDense: true,
              // Borderless + 48dp minimum: the row reads as a label with a
              // trailing value, and the field still meets the Android 48dp
              // tap-target guideline (the bare DropdownButton is only 24dp).
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: LegalHubTheme.spaceSm,
                ),
                constraints: BoxConstraints(minHeight: 48),
              ),
              borderRadius: BorderRadius.circular(LegalHubTheme.radiusXl),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation row: leading glyph, title, and a direction-aware chevron.
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return ListTile(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: LegalHubTheme.spaceMd,
      ),
      // 48dp rows keep the whole destination list above the fold on a 600dp
      // tall viewport while staying at the Material minimum tap target.
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, color: colors.onSurfaceVariant),
      title: Text(title),
      trailing: Icon(
        isRtl ? Icons.chevron_left : Icons.chevron_right,
        size: 20,
        color: colors.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}

/// Identity header: avatar monogram, session display name, projected role and
/// the session notice. Borderless, as in the canvas — it reads as a header
/// above the grouped cards rather than as another settings group. Read-only:
/// the profile route owns identity editing.
class _IdentityHeader extends StatelessWidget {
  const _IdentityHeader({
    required this.displayName,
    required this.role,
    required this.notice,
  });

  final String? displayName;
  final UserRole? role;
  final String notice;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    final String name = displayName?.trim() ?? '';
    final bool hasName = name.isNotEmpty;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: LegalHubTheme.spaceXs,
        vertical: LegalHubTheme.spaceSm,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 22,
            backgroundColor: colors.primary,
            child: hasName
                ? Text(
                    _initials(name),
                    style: text.titleMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Icon(Icons.person_outline, color: colors.onPrimary),
          ),
          const SizedBox(width: LegalHubTheme.spaceMd),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (hasName)
                  Text(
                    name,
                    style: text.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                RoleLabel(
                  role: role,
                  style: text.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: LegalHubTheme.spaceXs),
                Text(
                  notice,
                  style: text.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final List<String> parts = name
        .split(RegExp(r'\s+'))
        .where((String part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '';
    }
    final String first = parts.first.substring(0, 1);
    final String second = parts.length > 1 ? parts.last.substring(0, 1) : '';
    return (first + second).toUpperCase();
  }
}

/// Inserts a 1px divider between consecutive rows of a group.
///
/// [indent] starts the rule after the leading glyph column, as the canvas
/// does. `Divider.indent` is physical-left, so the inset is applied to the
/// leading edge for the active text direction.
List<Widget> _separated(List<Widget> items, {double indent = 0}) {
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    if (i > 0) {
      out.add(_GroupDivider(indent: indent));
    }
    out.add(items[i]);
  }
  return out;
}

class _GroupDivider extends StatelessWidget {
  const _GroupDivider({required this.indent});

  final double indent;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return Divider(
      height: 1,
      thickness: 1,
      indent: isRtl ? 0 : indent,
      endIndent: isRtl ? indent : 0,
    );
  }
}
