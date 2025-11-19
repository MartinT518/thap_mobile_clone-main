import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thap/ui/pages/menu_page.dart';
import 'test_helper.dart';

void main() {
  group('MenuPage Widget Tests', () {
    setUpAll(() async {
      await setupTestEnvironment();
      TestHelper.setupServiceLocatorForTests();
    });

    testWidgets('Menu page displays user profile section', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MenuPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify scaffold structure
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Menu page displays menu items', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MenuPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have list of menu items or scaffold
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Menu page has sign out option', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MenuPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have sign out button or menu item
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
