import 'package:thap/core/config/env.dart';
import 'package:thap/features/products/data/datasources/products_remote_datasource.dart';
import 'package:thap/features/products/data/models/product_model.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';

/// Products repository implementation (API)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Product?> getProduct(String productId) async {
    final data = await _remoteDataSource.getProduct(productId);
    if (data == null) return null;
    try {
      final model = ProductModel.fromJson(data);
      return model.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> scanQrCode(String codeData, String codeType) async {
    final data = await _remoteDataSource.scanQrCode(codeData, codeType);
    if (data == null) return null;
    try {
      final model = ProductModel.fromJson(data);
      return model.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> findByQrUrl(Uri qrUrl) async {
    final data = await _remoteDataSource.findByQrUrl(qrUrl.toString());
    if (data == null) return null;
    try {
      final model = ProductModel.fromJson(data);
      return model.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> findByEan(String ean) async {
    final data = await _remoteDataSource.findByEan(ean);
    if (data == null) return null;
    try {
      final model = ProductModel.fromJson(data);
      return model.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProductPages?> getProductPages(String productId, String language) async {
    final data = await _remoteDataSource.getProductPages(productId, language);
    if (data == null) return null;
    return ProductPages(productId: productId, pages: data);
  }

  @override
  Future<List<ProductSearchResult>> searchProducts(String keyword) async {
    final data = await _remoteDataSource.searchProducts(keyword);
    if (data == null) return [];
    return data.map((json) {
      return ProductSearchResult(
        productName: json['productName'] ?? '',
        producerName: json['producerName'] ?? '',
        barcode: json['barcode'] ?? '',
        imageUrl: json['imageUrl'],
      );
    }).toList();
  }
}

