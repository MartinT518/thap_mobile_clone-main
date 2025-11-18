import 'package:dio/dio.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Remote data source for settings API calls
class SettingsRemoteDataSource {
  final Dio _dio;

  SettingsRemoteDataSource(this._dio);

  /// Get user settings
  Future<Map<String, dynamic>> getSettings() async {
    try {
      final response = await _dio.get('/v2/user/settings');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      rethrow;
    }
  }

  /// Update settings
  Future<void> updateSettings(Map<String, dynamic> settings) async {
    try {
      await _dio.put('/v2/user/settings', data: settings);
    } catch (e) {
      rethrow;
    }
  }
}

