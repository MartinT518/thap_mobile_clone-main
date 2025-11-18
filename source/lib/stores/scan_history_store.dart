import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/extensions/future_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';

part 'scan_history_store.g.dart';

class ScanHistoryStore = _ScanHistoryStore with _$ScanHistoryStore;

abstract class _ScanHistoryStore with Store {
  final _userRepository = locator<UserRepository>();
  // final _myTingsStore = locator<MyTingsStore>();
  final _toastService = locator<ToastService>();

  @observable
  ObservableList<ProductItem> scanHistory = ObservableList.of([]);

  @computed
  bool get hasAny => scanHistory.isNotEmpty;

  @observable
  bool isLoading = true;

  @action
  Future<void> load() async {
    isLoading = true;

    try {
      final products = await _userRepository.getScanHistory().withMinDuration();
      scanHistory = ObservableList.of(products);
    } catch (e) {
      _toastService.error('Could not load scan history');
    }

    isLoading = false;
  }

  @action
  void add(ProductItem productItem) {
    final existing =
        scanHistory.firstWhereOrNull((element) => element.id == productItem.id);

    if (existing != null) {
      scanHistory.remove(existing);
    }

    scanHistory.insert(0, productItem);
  }

  @action
  Future<void> remove(ProductItem productItem,
      [bool removeFromApi = true]) async {
    if (removeFromApi) {
      await _userRepository.deleteScanHistory(productItem.id);
    }

    scanHistory.remove(productItem);
  }
}
