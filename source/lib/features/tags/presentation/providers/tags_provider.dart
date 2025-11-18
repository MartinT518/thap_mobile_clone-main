import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thap/features/tags/data/providers/tags_repository_provider.dart';
import 'package:thap/features/tags/domain/entities/tag.dart';
import 'package:thap/features/tags/domain/repositories/tags_repository.dart';

part 'tags_provider.freezed.dart';

@freezed
class TagsState with _$TagsState {
  const factory TagsState.initial() = _Initial;
  const factory TagsState.loading() = _Loading;
  const factory TagsState.loaded(List<Tag> tags) = _Loaded;
  const factory TagsState.error(String message) = _Error;
}

class TagsNotifier extends StateNotifier<TagsState> {
  final TagsRepository _repository;

  TagsNotifier(this._repository) : super(const TagsState.initial());

  Future<void> loadTags() async {
    state = const TagsState.loading();
    try {
      final tags = await _repository.getTags();
      state = TagsState.loaded(tags);
    } catch (e) {
      state = TagsState.error(e.toString());
    }
  }

  Future<String?> createTag(String name) async {
    try {
      final tagId = await _repository.createTag(name);
      await loadTags(); // Reload to get updated list
      return tagId;
    } catch (e) {
      state = TagsState.error(e.toString());
      return null;
    }
  }

  Future<bool> renameTag(String tagId, String newName) async {
    try {
      await _repository.renameTag(tagId, newName);
      await loadTags(); // Reload to get updated list
      return true;
    } catch (e) {
      state = TagsState.error(e.toString());
      return false;
    }
  }

  Future<bool> deleteTag(String tagId) async {
    try {
      await _repository.deleteTag(tagId);
      await loadTags(); // Reload to get updated list
      return true;
    } catch (e) {
      state = TagsState.error(e.toString());
      return false;
    }
  }

  Future<bool> reorderTags(List<String> tagIds) async {
    try {
      await _repository.reorderTags(tagIds);
      await loadTags(); // Reload to get updated list
      return true;
    } catch (e) {
      state = TagsState.error(e.toString());
      return false;
    }
  }
}

final tagsNotifierProvider =
    StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  final repository = ref.watch(tagsRepositoryProvider);
  return TagsNotifier(repository);
});

