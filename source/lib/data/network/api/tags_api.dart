import 'package:dio/dio.dart';
import 'package:thap/data/network/api/api_client.dart';

class TagsApi {
  final ApiClient _apiClient;

  TagsApi(this._apiClient);

  Future<Response> getTags() async {
    return await _apiClient.get('/v2/tags/list');
  }

  Future<Response> add(String name) async {
    return await _apiClient.post('/v2/tags/add', data: {'name': name});
  }

  Future<Response> rename(String tagId, String name) async {
    return await _apiClient
        .patch('/v2/tags/rename/$tagId', data: {'name': name});
  }

  Future<Response> reorder(List<String> tagIds) async {
    return await _apiClient.post('/v2/tags/reorder', data: {'tags': tagIds});
  }

  Future<Response> delete(String tagId) async {
    return await _apiClient.delete('/v2/tags/$tagId');
  }
}
