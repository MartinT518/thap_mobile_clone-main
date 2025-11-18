import 'package:dio/dio.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Remote data source for products API calls
class ProductsRemoteDataSource {
  final Dio _dio;

  ProductsRemoteDataSource(this._dio);

  /// Get product by ID
  Future<Map<String, dynamic>?> getProduct(String productId) async {
    try {
      final response = await _dio.get('/v2/products/$productId');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Scan QR code
  Future<Map<String, dynamic>?> scanQrCode(String codeData, String codeType) async {
    try {
      final response = await _dio.post(
        '/v2/products/scan',
        data: {
          'codeData': codeData,
          'codeType': codeType,
        },
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Find product by QR URL
  Future<Map<String, dynamic>?> findByQrUrl(String qrUrl) async {
    try {
      final response = await _dio.get('/v2/products/find?qrUrl=$qrUrl');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Find product by EAN
  Future<Map<String, dynamic>?> findByEan(String ean) async {
    try {
      final response = await _dio.get('/v2/products/find/$ean');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get product pages
  Future<List<Map<String, dynamic>>?> getProductPages(
    String productId,
    String language,
  ) async {
    try {
      final response = await _dio.get('/v2/products/pages/$productId/$language');
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Search products
  Future<List<Map<String, dynamic>>?> searchProducts(String keyword) async {
    try {
      final response = await _dio.get('/v2/products/search/$keyword');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

