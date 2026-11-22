// Host-only capture harness for the 20 stale AR/TR light-CTA renders under
// docs/redesign/phase3/visual-comparison/rendered/.
//
// Gated by CAPTURE_RENDERED_AR_TR=1 (a DISTINCT var: CAPTURE_SCREENSHOTS=1 does
// NOT trigger this file). Skipped in default runs and in CI. Run with:
//
//   $env:LH_STAGING_DIR = '<temp staging dir>'
//   $env:CAPTURE_RENDERED_AR_TR = '1'
//   flutter test test/screenshots/capture_rendered_ar_tr_test.dart --concurrency=1 --update-goldens
//
// Captures are written to LH_STAGING_DIR via a LocalFileComparator whose
// basedir is the staging directory. Promotion into rendered/ is a SEPARATE
// step performed by the owner-side script; this file never writes there.
// Outputs are test-harness renders, NOT release builds and NOT evidence for
// LH-REL-001.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:legalhub/app/localization/locale_cubit.dart';
import 'package:legalhub/app/router.dart';
import 'package:legalhub/app/service_locator.dart';
import 'package:legalhub/app/theme/theme_cubit.dart';
import 'package:legalhub/core/observability/error_reporter.dart';
import 'package:legalhub/data/auth/fake_auth_gateway.dart';
import 'package:legalhub/data/local/in_memory_locale_store.dart';
import 'package:legalhub/data/local/in_memory_theme_mode_store.dart';
import 'package:legalhub/data/orgs/fake_membership_repository.dart';
import 'package:legalhub/data/orgs/fake_organization_gateway.dart';
import 'package:legalhub/features/auth/presentation/auth_cubit.dart';
import 'package:legalhub/l10n/app_localizations.dart';
import 'package:legalhub/main.dart';
import 'package:material_ui/material_ui.dart';

import '../support/render_fonts.dart';

const Key _rootKey = Key('rendered-ar-tr-root');
const String _renderedDir = 'docs/redesign/phase3/visual-comparison/rendered';

class _Spec {
  const _Spec({
    required this.surface,
    required this.locale,
    required this.layout,
    required this.route,
    required this.title,
    required this.cta,
  });

  final String surface;
  final Locale locale;
  final String layout;
  final String route;
  final String Function(AppLocalizations l10n) title;
  final String Function(AppLocalizations l10n) cta;

  String get fileName =>
      '${surface}_light_${layout}_${locale.languageCode}.png';
  Size get physicalSize => layout == 'phone'
      ? const Size(1080, 2400) // 360x800 @3x
      : const Size(2560, 1600); // 1280x800 @2x
  double get dpr => layout == 'phone' ? 3.0 : 2.0;
  int get imageWidth => (physicalSize.width / dpr).toInt();
  int get imageHeight => (physicalSize.height / dpr).toInt();
}

List<_Spec> _specsFor(Locale locale) => <_Spec>[
  _Spec(
    surface: 'sign_in',
    locale: locale,
    layout: 'phone',
    route: AppRoutes.signIn,
    title: (l) => l.signInWelcome,
    cta: (l) => l.signInButton,
  ),
  _Spec(
    surface: 'forgot_email',
    locale: locale,
    layout: 'phone',
    route: AppRoutes.forgotPassword,
    title: (l) => l.recoverPasswordTitle,
    cta: (l) => l.sendCodeButton,
  ),
  _Spec(
    surface: 'reset',
    locale: locale,
    layout: 'phone',
    route: AppRoutes.forgotPasswordReset,
    title: (l) => l.resetPasswordTitle,
    cta: (l) => l.resetPasswordButton,
  ),
  _Spec(
    surface: 'onboarding',
    locale: locale,
    layout: 'phone',
    route: AppRoutes.onboarding,
    title: (l) => l.onboardingTitle1,
    cta: (l) => l.onboardingContinue,
  ),
  _Spec(
    surface: 'onboarding_success',
    locale: locale,
    layout: 'phone',
    route: AppRoutes.onboardingSuccess,
    title: (l) => l.onboardingSuccessTitle,
    cta: (l) => l.onboardingSuccessAction,
  ),
  _Spec(
    surface: 'sign_in',
    locale: locale,
    layout: 'wide',
    route: AppRoutes.signIn,
    title: (l) => l.signInWelcome,
    cta: (l) => l.signInButton,
  ),
  _Spec(
    surface: 'forgot_email',
    locale: locale,
    layout: 'wide',
    route: AppRoutes.forgotPassword,
    title: (l) => l.recoverPasswordTitle,
    cta: (l) => l.sendCodeButton,
  ),
  _Spec(
    surface: 'reset',
    locale: locale,
    layout: 'wide',
    route: AppRoutes.forgotPasswordReset,
    title: (l) => l.resetPasswordTitle,
    cta: (l) => l.resetPasswordButton,
  ),
  _Spec(
    surface: 'onboarding',
    locale: locale,
    layout: 'wide',
    route: AppRoutes.onboarding,
    title: (l) => l.onboardingTitle1,
    cta: (l) => l.onboardingContinue,
  ),
  _Spec(
    surface: 'onboarding_success',
    locale: locale,
    layout: 'wide',
    route: AppRoutes.onboardingSuccess,
    title: (l) => l.onboardingSuccessTitle,
    cta: (l) => l.onboardingSuccessAction,
  ),
];

void main() {
  final bool enabled = Platform.environment['CAPTURE_RENDERED_AR_TR'] == '1';
  final String stagingPath = Platform.environment['LH_STAGING_DIR'] ?? '';

  if (enabled) {
    if (stagingPath.isEmpty) {
      throw StateError(
        'LH_STAGING_DIR must point at a temp staging directory when '
        'CAPTURE_RENDERED_AR_TR=1',
      );
    }
    final Directory staging = Directory(stagingPath);
    if (!staging.existsSync()) {
      staging.createSync(recursive: true);
    }
    // Golden keys resolve relative to this comparator's basedir, so every
    // capture lands in the staging directory and NEVER in rendered/.
    goldenFileComparator = LocalFileComparator(
      Uri.file('$stagingPath${Platform.pathSeparator}_harness.dart'),
    );
  }

  List<Map<String, dynamic>> manifest = <Map<String, dynamic>>[];

  void writeManifest(String name) {
    // Synchronous I/O: an async dart:io write never completes inside the
    // flutter_test fake-async zone (it needs binding.runAsync), while the
    // golden comparator's writes are already wrapped in runAsync internally.
    final File out = File('$stagingPath${Platform.pathSeparator}$name');
    out.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifest));
  }

  Future<void> pumpSpec(WidgetTester tester, _Spec spec) async {
    await resetServiceLocator();
    configureDependencies();
    final AuthCubit authCubit = AuthCubit(
      FakeAuthGateway(),
      InMemoryErrorReporter(),
      FakeMembershipRepository(),
      FakeOrganizationGateway(),
    );
    final LocaleCubit localeCubit = LocaleCubit(InMemoryLocaleStore());
    await localeCubit.load();
    final ThemeCubit themeCubit = ThemeCubit(InMemoryThemeModeStore());
    await themeCubit.load();
    final GoRouter router = createAppRouter(authCubit);

    await loadRenderFonts();
    // Flush the 3.50 font-change frame before mounting the capture tree.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    tester.view.physicalSize = spec.physicalSize;
    tester.view.devicePixelRatio = spec.dpr;
    tester.view.viewInsets = FakeViewPadding.zero;
    addTearDown(tester.view.reset);
    await localeCubit.setLocale(spec.locale);
    await themeCubit.setThemeMode(ThemeMode.light);
    await tester.pumpWidget(
      RepaintBoundary(
        key: _rootKey,
        child: Directionality(
          textDirection: spec.locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: LegalHubApp(
            router: router,
            authCubit: authCubit,
            localeCubit: localeCubit,
            themeCubit: themeCubit,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    if (spec.route != AppRoutes.signIn) {
      router.go(spec.route);
      await tester.pumpAndSettle();
    }
    addTearDown(() async {
      router.dispose();
      await authCubit.close();
      await localeCubit.close();
      await themeCubit.close();
      await resetServiceLocator();
    });
  }

  Future<Map<String, dynamic>> renderOne(
    WidgetTester tester,
    _Spec spec,
  ) async {
    await pumpSpec(tester, spec);

    // LH-REL-001 assertion: the fork MaterialLocalizations must be present at
    // a context inside the screen that builds the material_ui CTA.
    final Element screen = tester.element(find.byType(Scaffold).first);
    final Object localization = MaterialLocalizations.of(screen);
    expect(
      localization,
      isA<GlobalMaterialLocalizations>(),
      reason:
          'LH-REL-001: fork GlobalMaterialLocalizations must resolve at the '
          'capture context for ${spec.locale.languageCode}',
    );

    final ThemeData theme = Theme.of(screen);
    expect(theme.brightness, Brightness.light, reason: 'capture must be light');

    final AppLocalizations l10n = lookupAppLocalizations(spec.locale);
    final String title = spec.title(l10n);
    final String ctaLabel = spec.cta(l10n);
    expect(
      find.text(title),
      findsWidgets,
      reason:
          'missing title "$title" on ${spec.surface}/${spec.locale.languageCode}',
    );

    final Finder ctaFinder = find.widgetWithText(ElevatedButton, ctaLabel);
    List<double>? ctaRect;
    if (ctaFinder.evaluate().isNotEmpty) {
      final Rect rect = tester.getRect(ctaFinder.first);
      ctaRect = <double>[rect.left, rect.top, rect.width, rect.height];
    }

    await expectLater(find.byKey(_rootKey), matchesGoldenFile(spec.fileName));

    return <String, dynamic>{
      'file': spec.fileName,
      'locale': spec.locale.languageCode,
      'screen': spec.surface,
      'theme': 'light',
      'title': title,
      'cta_label': ctaLabel,
      'dpr': spec.dpr,
      'image_w': spec.imageWidth,
      'image_h': spec.imageHeight,
      'cta_rect_logical': ctaRect,
    };
  }

  testWidgets('allowlist sanity', (WidgetTester tester) async {
    if (!enabled) {
      return;
    }
    final Set<String> allow = <_Spec>[
      ..._specsFor(const Locale('ar')),
      ..._specsFor(const Locale('tr')),
    ].map((s) => s.fileName).toSet();
    expect(allow.length, 20, reason: 'the allowlist must be exactly 20 files');
    final Directory dir = Directory(_renderedDir);
    expect(dir.existsSync(), isTrue, reason: 'rendered/ directory missing');
    final Set<String> onDisk = dir
        .listSync()
        .whereType<File>()
        .map((f) => f.uri.pathSegments.last)
        .where((name) => name.endsWith('.png'))
        .toSet();
    expect(onDisk.length, 108, reason: 'rendered/ must hold 108 PNGs');
    expect(
      allow.every(onDisk.contains),
      isTrue,
      reason: 'every allowlisted file must exist in rendered/',
    );
    final Set<String> others = onDisk.difference(allow);
    expect(others.length, 88, reason: 'the 88 untouched files must remain');
    expect(
      allow.intersection(others).isEmpty,
      isTrue,
      reason: 'no file may be in both the 20-target set and the 88-set',
    );
  }, skip: !enabled);

  testWidgets('probe: sign-in light phone AR and TR', (
    WidgetTester tester,
  ) async {
    if (!enabled) {
      return;
    }
    manifest = <Map<String, dynamic>>[];
    manifest.add(await renderOne(tester, _specsFor(const Locale('ar')).first));
    manifest.add(await renderOne(tester, _specsFor(const Locale('tr')).first));
    writeManifest('probe_manifest.json');
  }, skip: !enabled);

  testWidgets('render 20 AR/TR light-CTA captures', (
    WidgetTester tester,
  ) async {
    if (!enabled) {
      return;
    }
    manifest = <Map<String, dynamic>>[];
    for (final Locale locale in const <Locale>[Locale('ar'), Locale('tr')]) {
      for (final _Spec spec in _specsFor(locale)) {
        manifest.add(await renderOne(tester, spec));
      }
    }
    expect(manifest.length, 20);
    writeManifest('capture_manifest.json');
  }, skip: !enabled);
}
