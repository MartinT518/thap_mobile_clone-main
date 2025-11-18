import 'package:thap/data/network/api/tags_api.dart';
import 'package:thap/models/tag_result.dart';

class TagsRepository {
  final TagsApi _api;

  TagsRepository(this._api);

  Future<List<TagResult>> getTags() async {
    final response = await _api.getTags();

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((tag) => TagResult.fromJson(tag))
          .toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to get tags');
    }
  }

  Future<String> add(String name) async {
    final response = await _api.add(name);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to add a tag');
    }
  }

  Future<void> rename(String tagId, String name) async {
    final response = await _api.rename(tagId, name);

    if (response.statusCode != 200) {
      throw Exception('Failed to rename tag');
    }
  }

  Future<void> reorder(List<String> tagIds) async {
    final response = await _api.reorder(tagIds);

    if (response.statusCode != 200) {
      throw Exception('Failed to reorder tags');
    }
  }

  Future<void> delete(String tagId) async {
    final response = await _api.delete(tagId);

    if (response.statusCode != 200) {
      throw Exception('Failed to add delete tag');
    }
  }
}
