import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/core/theme/app_theme.dart';

/// Helper class for creating test widgets with proper setup
class TestWidgetHelper {
  /// Create a test MaterialApp with proper setup
  static Widget createTestApp({
    required Widget home,
    bool useEasyLocalization = false,
  }) {
    Widget app = MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
      home: MediaQuery(
        data: const MediaQueryData(
          size: Size(800, 600),
          textScaleFactor: 1.0,
        ),
        child: SizedBox(
          width: 800,
          height: 600,
          child: home,
        ),
      ),
    );

    if (useEasyLocalization) {
      app = EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: app,
      );
    }

    return ProviderScope(child: app);
  }

  /// Create a test widget with size constraints
  static Widget createSizedTestWidget(Widget child, {Size? size}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: MediaQuery(
        data: MediaQueryData(size: size ?? const Size(800, 600)),
        child: Scaffold(
          body: SizedBox(
            width: size?.width ?? 800,
            height: size?.height ?? 600,
            child: child,
          ),
        ),
      ),
    );
  }
}
