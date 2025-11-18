import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:thap/data/repository/tags_repository.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/my_tings_store.dart';

part 'product_tags_store.g.dart';

class ProductTagsStore = _ProductTagsStore with _$ProductTagsStore;

abstract class _ProductTagsStore with Store {
  final tagsRepository = locator<TagsRepository>();
  final myTingsStore = locator<MyTingsStore>();

  @observable
  ObservableList<TagResult> tags = ObservableList.of([]);

  @computed
  ObservableList<TagResult> get tagsWithTings =>
      ObservableList.of(tags.where((t) => t.itemCount > 0));

  @observable
  bool isLoading = false;

  @computed
  bool get hasAny => tags.isNotEmpty;

  @action
  Future<void> load() async {
    isLoading = true;

    final result = await tagsRepository.getTags();
    tags = ObservableList.of(result);

    isLoading = false;
  }

  @action
  Future<TagResult> add(String name) async {
    final tagId = await tagsRepository.add(name);
    final tag = TagResult(id: tagId, title: name, itemCount: 0);

    tags.add(tag);

    return tag;
  }

  @action
  Future<void> rename(String tagId, String newName) async {
    final existing = tags.firstWhereOrNull((t) => t.id == tagId);

    if (existing == null) return;

    final tag = existing.copyWith(title: newName);
    final oldIndex = tags.indexOf(existing);

    tags.remove(existing);
    tags.insert(oldIndex, tag);

    await tagsRepository.rename(tagId, newName);
  }

  @action
  Future<void> updateItemCount(String tagId, int value) async {
    final tag = tags.firstWhereOrNull((t) => t.id == tagId);
    if (tag == null) return;

    final oldIndex = tags.indexOf(tag);
    final newCount = tag.itemCount + value;
    tags.remove(tag);
    tags.insert(oldIndex, tag.copyWith(itemCount: newCount));

    // Clear active filter in my tings list when tag was active and there are no more items
    if (newCount == 0 && myTingsStore.filterTagId == tag.id) {
      await myTingsStore.setFilterTag(null);
    }
  }

  @action
  Future<void> remove(TagResult tag) async {
    await tagsRepository.delete(tag.id);

    tags.remove(tag);

    // If it was an active filter, reset it
    if (myTingsStore.filterTagId == tag.id) {
      await myTingsStore.setFilterTag(null);
    }
  }

  @action
  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final tag = tags.removeAt(oldIndex);
    tags.insert(newIndex, tag);

    final tagIds = tags.map((t) => t.id).toList();

    await tagsRepository.reorder(tagIds);
  }
}
