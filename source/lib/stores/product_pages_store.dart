// Legacy stub - migrating to Riverpod
import 'package:thap/models/product_page.dart';

class ProductPagesStore {
  Map<String, ProductPageModel> productPages = {};
  
  ProductPageModel? getStoredPage(String productId, String pageId) => null;
  void storePage(String productId, String pageId, ProductPageModel page) {}
  Future<void> load(String productId, String pageId) async {}
  Future<ProductPageModel?> getPage(String productId, [String? langCode, String? pageId]) async => null;
}
