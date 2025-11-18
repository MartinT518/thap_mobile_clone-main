import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';

/// Products repository demo implementation
class ProductsRepositoryDemo implements ProductsRepository {
  @override
  Future<Product?> getProduct(String productId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return Product(
      id: productId,
      name: 'Demo Product',
      brand: 'Demo Brand',
      isOwner: false,
    );
  }

  @override
  Future<Product?> scanQrCode(String codeData, String codeType) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return Product(
      id: 'demo-${DateTime.now().millisecondsSinceEpoch}',
      name: 'Scanned Product',
      brand: 'Scanned Brand',
      barcode: codeData,
      code: codeData,
      qrCode: codeData,
      isOwner: false,
    );
  }

  @override
  Future<Product?> findByQrUrl(Uri qrUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Product(
      id: 'demo-qr-${qrUrl.toString().hashCode}',
      name: 'QR Product',
      brand: 'QR Brand',
      qrCode: qrUrl.toString(),
      isOwner: false,
    );
  }

  @override
  Future<Product?> findByEan(String ean) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Product(
      id: 'demo-ean-$ean',
      name: 'EAN Product',
      brand: 'EAN Brand',
      barcode: ean,
      isOwner: false,
    );
  }

  @override
  Future<ProductPages?> getProductPages(String productId, String language) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ProductPages(
      productId: productId,
      pages: [
        {
          'id': 'page1',
          'title': 'Demo Page',
          'contents': [],
        }
      ],
    );
  }

  @override
  Future<List<ProductSearchResult>> searchProducts(String keyword) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      ProductSearchResult(
        productName: 'Demo Product 1',
        producerName: 'Demo Producer',
        barcode: '1234567890',
      ),
      ProductSearchResult(
        productName: 'Demo Product 2',
        producerName: 'Demo Producer',
        barcode: '0987654321',
      ),
    ];
  }
}

