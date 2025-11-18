import 'package:dio/dio.dart';
import 'package:thap/data/network/api/api_client.dart';

class AppApi {
  final ApiClient _apiClient;

  AppApi(this._apiClient);

  Future<Response> getData() async {
    return await _apiClient.get('/v2/app');
  }
}
