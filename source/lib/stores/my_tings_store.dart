import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/extensions/future_extensions.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/stores/scan_history_store.dart';

part 'my_tings_store.g.dart';

class MyTingsStore = _MyTingsStore with _$MyTingsStore;

abstract class _MyTingsStore with Store {
  final _myTingsRepository = locator<MyTingsRepository>();
  final _toastService = locator<ToastService>();
  final _scanHistoryStore = locator<ScanHistoryStore>();

  @observable
  ObservableList<ProductItem> myTings = ObservableList.of([]);

  @computed
  ObservableList<ProductItem> get myTingsFiltered {
    return ObservableList.of(myTings.where(
        (ting) => filterTagId.isBlank || ting.tags.contains(filterTagId)));
  }

  @computed
  bool get hasAny => myTings.isNotEmpty;

  ProductItem? getTing(String productId) =>
      myTings.firstWhereOrNull((element) => element.id == productId);

  @observable
  bool isLoading = true;

  @observable
  bool displayGrid = true;

  @observable
  String? filterTagId;

  @action
  Future<void> load() async {
    isLoading = true;

    final prefs = await SharedPreferences.getInstance();
    displayGrid = prefs.getBool('displayGrid') ?? true;
    filterTagId = prefs.getString('filterTagId');

    try {
      final tings = await _myTingsRepository.list().withMinDuration();

      myTings = ObservableList.of(tings);
    } catch (e) {
      _toastService.error('Could not load your tings');
    }

    isLoading = false;
  }

  @action
  Future<ProductItem> add(ProductItem product) async {
    final instanceId = await _myTingsRepository.add(product.id);
    final ting = product.copyWith(instanceId: instanceId);

    myTings.insert(0, ting);

    final scanHistoryProduct = _scanHistoryStore.scanHistory
        .firstWhereOrNull((p) => p.id == product.id);
    // Remove from scan history if it exists
    if (scanHistoryProduct != null) {
      await _scanHistoryStore.remove(scanHistoryProduct, false);
    }

    return ting;
  }

  @action
  Future<void> remove(ProductItem product) async {
    await _myTingsRepository.delete(product.instanceId!);
    await _scanHistoryStore.load(); // Reload scan history

    if (product.tags.isNotEmpty) {
      final productTagsStore = locator<ProductTagsStore>();

      for (final tagId in product.tags) {
        await productTagsStore.updateItemCount(tagId, -1);
      }
    }

    myTings.remove(product);
  }

  @action
  Future<void> update(ProductItem product) async {
    var current = myTings.singleWhere((element) => element.id == product.id);
    var index = myTings.indexOf(current);
    myTings.insert(index, product);
    myTings.remove(current);
  }

  @action
  Future<void> setDisplayMode({required bool displayGrid}) async {
    // Save state to device
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('displayGrid', displayGrid);

    this.displayGrid = displayGrid;
  }

  @action
  Future<void> setFilterTag(String? tagId) async {
    // Save state to device
    final prefs = await SharedPreferences.getInstance();
    const key = 'filterTagId';

    if (tagId.isBlank) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, tagId!);
    }

    filterTagId = tagId;
  }
}
