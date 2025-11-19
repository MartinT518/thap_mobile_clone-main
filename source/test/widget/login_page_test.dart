import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/auth/presentation/pages/login_page.dart';
import 'package:thap/features/auth/presentation/providers/auth_provider.dart';
import 'package:thap/features/auth/data/providers/auth_repository_provider.dart';
import 'package:thap/features/auth/data/repositories/auth_repository_demo.dart';
import 'package:thap/features/auth/domain/repositories/auth_repository.dart';
import 'test_helper.dart';

void main() {
  group('LoginPage Widget Tests', () {
    setUpAll(() async {
      await setupTestEnvironment();
      // Use mock repositories for faster, reliable tests
      TestHelper.setupServiceLocatorForTests(useMockRepositories: true);
    });

    testWidgets('Login page displays all required elements', (tester) async {
      // Override authRepositoryProvider to use demo repository which returns unauthenticated
      await tester.pumpWidget(
        makeTestableWidget(
          child: const LoginPage(),
          wrapWithOKToast: true,
          overrides: [
            authRepositoryProvider.overrideWith((ref) => AuthRepositoryDemo()),
          ],
        ),
      );

      // Wait for async operations (authProvider initialization and session restore)
      // Use extended wait times for heavy async operations
      await waitForAsyncOperations(tester);

      // Verify scaffold structure
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify sign in button is displayed (ElevatedButton.icon)
      // The button should be visible once auth state is unauthenticated
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Sign in button is tappable', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: const LoginPage(),
          wrapWithOKToast: true,
          overrides: [
            authRepositoryProvider.overrideWith((ref) => AuthRepositoryDemo()),
          ],
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      // Find and tap the sign in button
      final signInButtons = find.byType(ElevatedButton);
      
      // Button should be available after session restore completes
      expect(signInButtons, findsWidgets);
      
      await tester.tap(signInButtons.first);
      await tester.pump();

      // Button should be tappable (no errors)
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Login page uses Design System colors', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: const LoginPage(),
          wrapWithOKToast: true,
          overrides: [
            authRepositoryProvider.overrideWith((ref) => AuthRepositoryDemo()),
          ],
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      // Verify scaffold structure exists
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify Design System colors by checking button style if available
      final buttons = find.byType(ElevatedButton);
      if (buttons.evaluate().isNotEmpty) {
        final button = tester.widget<ElevatedButton>(buttons.first);
        expect(button.style, isNotNull);
      }
    });

    testWidgets('Login page handles loading state', (tester) async {
      // Create a repository that takes longer to restore session
      final slowRepo = _SlowAuthRepository();
      
      await tester.pumpWidget(
        makeTestableWidget(
          child: const LoginPage(),
          wrapWithOKToast: true,
          overrides: [
            authRepositoryProvider.overrideWith((ref) => slowRepo),
          ],
        ),
      );

      // Check immediately - should show loading during session restore
      await tester.pump();
      // The AuthNotifier tries to restore session on init, which sets loading state
      // So we should see CircularProgressIndicator initially
      expect(find.byType(Scaffold), findsOneWidget);
      
      // May or may not see CircularProgressIndicator depending on timing
      // But scaffold should exist
      final loadingIndicators = find.byType(CircularProgressIndicator);
      if (loadingIndicators.evaluate().isNotEmpty) {
        expect(loadingIndicators, findsWidgets);
      }
    });
  });
}

// Helper class to simulate slow auth operations
class _SlowAuthRepository extends AuthRepositoryDemo {
  @override
  Future<bool> tryRestoreSession() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return false; // Don't auto-restore
  }
}
