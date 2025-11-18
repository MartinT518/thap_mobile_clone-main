import 'package:thap/features/products/domain/entities/product.dart';

/// Products repository interface (domain layer)
abstract class ProductsRepository {
  /// Get product by ID
  Future<Product?> getProduct(String productId);

  /// Scan QR code and get product
  Future<Product?> scanQrCode(String codeData, String codeType);

  /// Find product by QR URL
  Future<Product?> findByQrUrl(Uri qrUrl);

  /// Find product by EAN
  Future<Product?> findByEan(String ean);

  /// Get product pages/documentation
  Future<ProductPages?> getProductPages(String productId, String language);

  /// Search products
  Future<List<ProductSearchResult>> searchProducts(String keyword);
}

/// Product pages/documentation (simplified for now)
class ProductPages {
  final String productId;
  final List<Map<String, dynamic>> pages;

  const ProductPages({
    required this.productId,
    required this.pages,
  });
}

/// Product search result
class ProductSearchResult {
  final String productName;
  final String producerName;
  final String barcode;
  final String? imageUrl;

  const ProductSearchResult({
    required this.productName,
    required this.producerName,
    required this.barcode,
    this.imageUrl,
  });
}

