import 'package:dio/dio.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Remote data source for wallet API calls
class WalletRemoteDataSource {
  final Dio _dio;

  WalletRemoteDataSource(this._dio);

  /// Get all products in wallet
  Future<List<Map<String, dynamic>>> getWalletProducts() async {
    try {
      final response = await _dio.get('/v2/tings/list');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to get wallet products');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Add product to wallet
  Future<String> addProductToWallet(String productId) async {
    try {
      final response = await _dio.post(
        '/v2/tings/add',
        data: {'productId': productId},
      );
      if (response.statusCode == 200) {
        return response.data as String;
      } else if (response.statusCode == 404) {
        throw Exception('Product not found');
      } else {
        throw Exception('Failed to add product to wallet');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Remove product from wallet
  Future<void> removeProductFromWallet(String instanceId) async {
    try {
      final response = await _dio.delete('/v2/tings/$instanceId/remove');
      if (response.statusCode != 200 && response.statusCode != 404) {
        throw Exception('Failed to remove product from wallet');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Update product nickname
  Future<void> updateNickname(String instanceId, String? nickname) async {
    try {
      await _dio.post(
        '/v2/tings/nickname',
        data: {
          'productInstanceId': instanceId,
          'nickname': nickname,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Add tag to product
  Future<void> addTag(String instanceId, String tagId) async {
    try {
      await _dio.post(
        '/v2/tings/$instanceId/tags',
        data: {'tagId': tagId},
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Remove tag from product
  Future<void> removeTag(String instanceId, String tagId) async {
    try {
      await _dio.delete('/v2/tings/$instanceId/tags/$tagId');
    } catch (e) {
      rethrow;
    }
  }
}

