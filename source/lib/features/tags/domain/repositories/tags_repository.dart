import 'package:thap/features/tags/domain/entities/tag.dart';

/// Abstract repository for tag-related operations
abstract class TagsRepository {
  /// Get all user tags
  Future<List<Tag>> getTags();

  /// Create a new tag
  Future<String> createTag(String name);

  /// Rename a tag
  Future<void> renameTag(String tagId, String newName);

  /// Delete a tag
  Future<void> deleteTag(String tagId);

  /// Reorder tags
  Future<void> reorderTags(List<String> tagIds);

  /// Add tag to product instance
  Future<void> addTagToProduct(String instanceId, String tagId);

  /// Remove tag from product instance
  Future<void> removeTagFromProduct(String instanceId, String tagId);
}

