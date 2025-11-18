import 'package:dio/dio.dart';
import 'package:thap/features/tags/data/models/tag_model.dart';

class TagsRemoteDataSource {
  final Dio _dio;

  TagsRemoteDataSource(this._dio);

  Future<List<TagModel>> getTags() async {
    final response = await _dio.get('/v2/tags/list');
    return (response.data as List)
        .map((json) => TagModel.fromJson(json))
        .toList();
  }

  Future<String> createTag(String name) async {
    final response = await _dio.post('/v2/tags/add', data: {'name': name});
    return response.data as String;
  }

  Future<void> renameTag(String tagId, String name) async {
    await _dio.patch('/v2/tags/rename/$tagId', data: {'name': name});
  }

  Future<void> deleteTag(String tagId) async {
    await _dio.delete('/v2/tags/$tagId');
  }

  Future<void> reorderTags(List<String> tagIds) async {
    await _dio.post('/v2/tags/reorder', data: {'tags': tagIds});
  }

  Future<void> addTagToProduct(String instanceId, String tagId) async {
    await _dio.post('/v2/tings/$instanceId/set_tag/$tagId');
  }

  Future<void> removeTagFromProduct(String instanceId, String tagId) async {
    await _dio.delete('/v2/tings/$instanceId/remove_tag/$tagId');
  }
}

