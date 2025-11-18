import 'package:dio/dio.dart';
import 'package:thap/data/network/api/api_client.dart';

class UserApi {
  final ApiClient _apiClient;

  UserApi(this._apiClient);

  Future<Response> getScanHistory() async {
    return await _apiClient.get('/v2/user/scan_history');
  }

  Future<Response> deleteScanHistory(String productId) async {
    return await _apiClient.delete('/v2/user/scan_history/$productId');
  }

  Future<Response> deleteAllData() async {
    return await _apiClient.delete('/v2/user/delete_all_data');
  }

  Future<Response> getUserFeed(String language) async {
    return await _apiClient.get('/v2/user/feed/$language');
  }

  Future<Response> updateProfileData(
      String? countryCode, String? languageCode) async {
    return await _apiClient.patch('/v2/user/profile',
        data: {'countryCode': countryCode, 'languageCode': languageCode});
  }

  Future<Response> getProfileData() async {
    return await _apiClient.get('/v2/user/profile');
  }

  Future<Response> authenticate(String accessToken, String provider) async {
    return await _apiClient.post('/v2/user/authenticate',
        data: {'accessToken': accessToken, 'provider': provider});
  }

  Future<Response> isRegistered(String email) async {
    return await _apiClient.get('/v2/user/is_registered/$email');
  }

  Future<Response> register(
      String email, String name, String language, String country) async {
    return await _apiClient.post('/v2/user/register', data: {
      'email': email,
      'name': name,
      'language': language,
      'country': country
    });
  }
}
