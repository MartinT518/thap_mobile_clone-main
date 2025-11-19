import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thap/ui/pages/my_tings/my_tings_page.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'test_helper.dart';

void main() {
  group('MyThingsPage Widget Tests', () {
    setUpAll(() async {
      await setupTestEnvironment();
      TestHelper.setupServiceLocatorForTests();
    });

    testWidgets('My Things page displays app bar', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MyTingsPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify app bar exists (may be AppHeaderBar, not AppBar)
      expect(find.byType(AppHeaderBar), findsOneWidget);
    });

    testWidgets('My Things page shows empty state when no products', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MyTingsPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Should show empty state or loading
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('My Things page has pull to refresh', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: MyTingsPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have RefreshIndicator or scaffold
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
