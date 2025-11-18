import 'package:thap/features/tags/data/datasources/tags_remote_datasource.dart';
import 'package:thap/features/tags/domain/entities/tag.dart';
import 'package:thap/features/tags/domain/repositories/tags_repository.dart';

class TagsRepositoryImpl implements TagsRepository {
  final TagsRemoteDataSource _remoteDataSource;

  TagsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Tag>> getTags() async {
    final models = await _remoteDataSource.getTags();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<String> createTag(String name) async {
    return await _remoteDataSource.createTag(name);
  }

  @override
  Future<void> renameTag(String tagId, String newName) async {
    await _remoteDataSource.renameTag(tagId, newName);
  }

  @override
  Future<void> deleteTag(String tagId) async {
    await _remoteDataSource.deleteTag(tagId);
  }

  @override
  Future<void> reorderTags(List<String> tagIds) async {
    await _remoteDataSource.reorderTags(tagIds);
  }

  @override
  Future<void> addTagToProduct(String instanceId, String tagId) async {
    await _remoteDataSource.addTagToProduct(instanceId, tagId);
  }

  @override
  Future<void> removeTagFromProduct(String instanceId, String tagId) async {
    await _remoteDataSource.removeTagFromProduct(instanceId, tagId);
  }
}

