import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thap/ui/pages/product/product_page.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'test_helper.dart';

void main() {
  group('ProductPage Widget Tests', () {
    late ProductItem testProduct;
    late ProductPageModel testPage;

    setUpAll(() async {
      await setupTestEnvironment();
      // Use mock repositories for faster, reliable tests
      TestHelper.setupServiceLocatorForTests(useMockRepositories: true);
    });

    setUp(() {
      // Create test product
      testProduct = ProductItem(
        id: 'test-product-id',
        name: 'Test Product',
        brand: 'Test Brand',
        imageUrl: 'https://example.com/image.jpg',
        barcode: '1234567890',
        qrCodes: [],
        tags: [],
        isOwner: false,
      );

      // Create test page
      testPage = ProductPageModel(
        pageId: 'root',
        title: 'Test Product Page',
        components: [],
      );
    });

    testWidgets('Product page displays correctly', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProductPage(
            product: testProduct,
            page: testPage,
          ),
        ),
      );

      // Wait for async operations with extended timeout
      await waitForAsyncOperations(tester);

      // Verify scaffold structure exists
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Product page has app bar with back button', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProductPage(
            product: testProduct,
            page: testPage,
          ),
        ),
      );

      // Wait for async operations
      await waitForAsyncOperations(tester);

      // The wrapper provides size constraints, so AppHeaderBar can render
      // Use WidgetFinders for consistent widget finding
      expect(WidgetFinders.appHeaderBar(), findsOneWidget);
    });

    testWidgets('Product page structure is correct', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProductPage(
            product: testProduct,
            page: testPage,
          ),
        ),
      );

      // Wait for async operations
      await waitForAsyncOperations(tester);

      // Verify scaffold structure exists
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify AppHeaderBar is present using WidgetFinders
      expect(WidgetFinders.appHeaderBar(), findsOneWidget);
    });
  });
}
