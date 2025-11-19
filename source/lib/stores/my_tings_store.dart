// Legacy stub - migrating to Riverpod
import 'package:thap/models/product_item.dart';

class MyTingsStore {
  List<ProductItem> get myTings => [];
  List<ProductItem> get myTingsFiltered => [];
  List<ProductItem> get sharedTingsFiltered => [];
  bool get hasAny => false;
  bool get isLoading => false;
  bool get displayGrid => false;
  String get filterTagId => '';
  
  ProductItem? getTing(String productId) => null;
  Future<void> load() async {}
  Future<void> remove(ProductItem product) async {}
  void setFilterTagId(String tagId) {}
  void setFilterTag(String? tagId) {}
  void toggleDisplayGrid() {}
  Future<void> setDisplayMode({bool? displayGrid}) async {}
  Future<void> update(dynamic ting) async {}
  Future<dynamic> add(dynamic ting) async => ting;
}
