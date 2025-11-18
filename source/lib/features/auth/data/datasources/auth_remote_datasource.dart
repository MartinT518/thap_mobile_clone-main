import 'package:dio/dio.dart';
import 'package:thap/core/config/constants.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Remote data source for authentication API calls
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  /// Authenticate with backend
  Future<String?> authenticate(String accessToken, String provider) async {
    try {
      final response = await _dio.post(
        '/v2/user/authenticate',
        data: {
          'accessToken': accessToken,
          'provider': provider,
        },
      );

      if (response.statusCode == 200) {
        return response.data as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if user is registered
  Future<bool> isRegistered(String email) async {
    try {
      final response = await _dio.get('/v2/user/is_registered/$email');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Register new user
  Future<String?> register({
    required String email,
    required String name,
    required String language,
    required String country,
  }) async {
    try {
      final response = await _dio.post(
        '/v2/user/register',
        data: {
          'email': email,
          'name': name,
          'language': language,
          'country': country,
        },
      );

      if (response.statusCode == 200) {
        return response.data as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get user profile data
  Future<Map<String, dynamic>?> getProfileData() async {
    try {
      final response = await _dio.get('/v2/user/profile');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    String? countryCode,
    String? languageCode,
  }) async {
    try {
      final response = await _dio.patch(
        '/v2/user/profile',
        data: {
          if (countryCode != null) 'countryCode': countryCode,
          if (languageCode != null) 'languageCode': languageCode,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

