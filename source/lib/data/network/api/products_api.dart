import 'package:dio/dio.dart';
import 'package:thap/data/network/api/api_client.dart';

class ProductsApi {
  final ApiClient _apiClient;

  ProductsApi(this._apiClient);

  Future<Response> getProduct(String productId) async {
    return await _apiClient.get('/v2/products/$productId');
  }

  Future<Response> findByQrUrl(String qrUrl) async {
    return await _apiClient.get('/v2/products/find?qrUrl=$qrUrl');
  }

  Future<Response> scan(String codeData, String codeType) async {
    return await _apiClient.post('/v2/products/scan', data: {
      'codeData': codeData,
      'codeType': codeType,
    });
  }

  Future<Response> pages(String productId, String language) async {
    return await _apiClient.get('/v2/products/pages/$productId/$language');
  }

  Future<Response> search(String keyword) async {
    return await _apiClient.get('/v2/products/search/$keyword');
  }

  Future<Response> findByEan(String ean) async {
    return await _apiClient.get('/v2/products/find/$ean');
  }

  Future<Response> registrationForm(String productId) async {
    return await _apiClient.get('/v2/products/registration_form/$productId');
  }

  Future<Response> feedback(
      String productId, String feedback, String? name, String? email) async {
    return await _apiClient.post('/v2/products/feedback/$productId', data: {
      'feedback': feedback,
      'name': name,
      'email': email,
    });
  }
}
