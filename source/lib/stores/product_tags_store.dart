// Legacy stub - migrating to Riverpod
import 'package:thap/models/tag_result.dart';

class ProductTagsStore {
  List<TagResult> get tags => [];
  List<TagResult> get tagsWithTings => [];
  bool get hasAny => false;
  bool get isLoading => false;
  
  Future<void> load() async {}
  Future<void> remove(TagResult tag) async {}
  Future<void> reorder(int oldIndex, int newIndex) async {}
  Future<void> rename(String tagId, String newName) async {}
  Future<TagResult?> add(String tagName) async => null;
  Future<void> update(TagResult tag, String productId, bool selected) async {}
  Future<void> set(String productId, List<String> tagIds) async {}
}
