// Legacy stub - migrating to Riverpod
import 'package:thap/models/tag_result.dart';

class ProductTagsStore {
  List<TagResult> get tags => [];
  List<TagResult> get tagsWithTings => [];
  bool get hasAny => false;
  bool get isLoading => false;
  
  Future<void> load() async {}
}
