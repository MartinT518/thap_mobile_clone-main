import 'package:thap/features/tags/domain/entities/tag.dart';
import 'package:thap/features/tags/domain/repositories/tags_repository.dart';

class TagsRepositoryDemo implements TagsRepository {
  final List<Tag> _tags = [
    const Tag(id: '1', title: 'Electronics', itemCount: 5),
    const Tag(id: '2', title: 'Furniture', itemCount: 3),
    const Tag(id: '3', title: 'Clothing', itemCount: 8),
  ];

  @override
  Future<List<Tag>> getTags() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_tags);
  }

  @override
  Future<String> createTag(String name) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newId = '${_tags.length + 1}';
    _tags.add(Tag(id: newId, title: name, itemCount: 0));
    return newId;
  }

  @override
  Future<void> renameTag(String tagId, String newName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tags.indexWhere((tag) => tag.id == tagId);
    if (index != -1) {
      _tags[index] = _tags[index].copyWith(title: newName);
    }
  }

  @override
  Future<void> deleteTag(String tagId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tags.removeWhere((tag) => tag.id == tagId);
  }

  @override
  Future<void> reorderTags(List<String> tagIds) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Demo: No-op
  }

  @override
  Future<void> addTagToProduct(String instanceId, String tagId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Demo: No-op
  }

  @override
  Future<void> removeTagFromProduct(String instanceId, String tagId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Demo: No-op
  }
}

