import 'package:dio/dio.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Remote data source for scan history API calls
class ScanHistoryRemoteDataSource {
  final Dio _dio;

  ScanHistoryRemoteDataSource(this._dio);

  /// Get scan history
  Future<List<Map<String, dynamic>>> getScanHistory() async {
    try {
      final response = await _dio.get('/v2/user/scanHistory');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Add to scan history
  Future<void> addToHistory(String productId) async {
    try {
      await _dio.post('/v2/user/scanHistory', data: {
        'productId': productId,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Remove from scan history
  Future<void> removeFromHistory(String scanHistoryId) async {
    try {
      await _dio.delete('/v2/user/scanHistory/$scanHistoryId');
    } catch (e) {
      rethrow;
    }
  }

  /// Clear scan history
  Future<void> clearHistory() async {
    try {
      await _dio.delete('/v2/user/scanHistory');
    } catch (e) {
      rethrow;
    }
  }
}

