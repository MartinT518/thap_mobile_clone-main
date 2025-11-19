import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/ting_checkbox.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import '../test_helper.dart';

// Re-export main test helper
export '../test_helper.dart';

/// Wrapper to provide Material, Localization, Theme, and Size constraints
/// This is the "Universal Fix" for layout and localization errors in widget tests
/// Also sets up navigation with proper NavigatorKey
Widget makeTestableWidget({
  required Widget child,
  List<Override> overrides = const [],
  bool wrapWithOKToast = false,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  // Ensure SharedPreferences is mocked for tests
  SharedPreferences.setMockInitialValues({});

  // Create navigator key if not provided (needed for NavigationService)
  final navKey = navigatorKey ?? GlobalKey<NavigatorState>();

  Widget app = ProviderScope(
    overrides: overrides,
    child: EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations', // Ensure this path matches your pubspec
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: false,
      useOnlyLangCode: true,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            navigatorKey: navKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.lightTheme,
            home: Material(
              // Fixes "RenderBox was not laid out" by forcing a generic screen size
              child: MediaQuery(
                data: const MediaQueryData(size: Size(800, 800)),
                child: child,
              ),
            ),
          );
        },
      ),
    ),
  );

  // Wrap with OKToast if needed (for pages that use showToast)
  if (wrapWithOKToast) {
    app = OKToast(child: app);
  }

  return app;
}

/// Helper to setup Async/Localization before pumping
Future<void> setupTestEnvironment() async {
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();
}

/// Extended wait times for heavy async operations
/// Use this for tests that involve data loading, network calls, or complex state updates
/// Uses controlled pumping instead of pumpAndSettle to avoid timeout issues
Future<void> waitForAsyncOperations(WidgetTester tester, {Duration? timeout}) async {
  final maxWaitTime = timeout ?? const Duration(seconds: 3);
  final startTime = DateTime.now();
  
  // Initial pump to start async operations
  await tester.pump();
  
  // Wait for initial async operations (repositories loading data)
  await tester.pump(const Duration(milliseconds: 100));
  
  // Wait for state updates and rebuilds
  await tester.pump(const Duration(milliseconds: 300));
  
  // Additional pumps for async data loading (mocks return immediately, but state updates take time)
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 200));
  
  // Try to settle, but with a limit to avoid infinite loops from semantics errors
  // Use pumpFrame with a maximum number of iterations instead of pumpAndSettle
  int pumpCount = 0;
  const maxPumps = 20; // Limit to prevent infinite loops
  
  while (pumpCount < maxPumps && DateTime.now().difference(startTime) < maxWaitTime) {
    await tester.pump(const Duration(milliseconds: 100));
    pumpCount++;
    
    // If no frame is scheduled, we're done
    if (!tester.binding.hasScheduledFrame) {
      break;
    }
  }
  
  // Final pump to ensure everything is rendered
  await tester.pump(const Duration(milliseconds: 100));
}

/// Helper to find widgets by their actual types used in the app
/// Adjusts finders to match custom widget types
class WidgetFinders {
  /// Find TingsDropdownButtonFormField (custom dropdown)
  static Finder dropdownButtonFormField() {
    return find.byType(TingsDropdownButtonFormField);
  }
  
  /// Find TingCheckbox (custom checkbox)
  static Finder checkbox() {
    return find.byType(TingCheckbox);
  }
  
  /// Find TingsTextField (custom text field)
  static Finder textField() {
    return find.byType(TingsTextField);
  }
  
  /// Find AppHeaderBar (custom app bar)
  static Finder appHeaderBar() {
    return find.byType(AppHeaderBar);
  }
}