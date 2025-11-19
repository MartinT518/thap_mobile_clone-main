import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/services/service_locator.dart';

// Legacy stub - migrating to Riverpod
class ProductPagesStore {
  Map<String, ProductPageModel> productPages = {};
  
  ProductPageModel? getStoredPage(String productId, String pageId) {
    return productPages['${productId}_$pageId'];
  }
  
  void storePage(String productId, String pageId, ProductPageModel page) {
    productPages['${productId}_$pageId'] = page;
  }
  
  Future<void> load(String productId, String pageId) async {
    // Implement loading if needed, or rely on getPage
  }
  
  Future<ProductPageModel?> getPage(String productId, [String? langCode, String? pageId]) async {
    final repo = locator<ProductsRepository>();
    final pagesModel = await repo.pages(productId, langCode ?? 'en');
    
    if (pagesModel != null && pagesModel.pages.isNotEmpty) {
      final page = pagesModel.pages.firstWhere(
        (p) => p.pageId == (pageId ?? 'root'),
        orElse: () => pagesModel.pages.first
      );
      return page;
    }
    return null;
  }
}
