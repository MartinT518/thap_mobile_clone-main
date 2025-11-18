import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobx/mobx.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';

part 'product_pages_store.g.dart';

class ProductPagesStore = _ProductPagesStore with _$ProductPagesStore;

abstract class _ProductPagesStore with Store {
  @observable
  ObservableList<ProductPagesModel> productPages = ObservableList.of([]);

  @computed
  bool get hasAny => productPages.isNotEmpty;

  Future<ProductPageModel?> getPage(String productId, String language,
      [String pageId = 'root', bool loadFromApi = true]) async {
    if (loadFromApi) {
      await load(productId, language);
    }

    return getStoredPage(productId, pageId);
  }

  ProductPageModel? getStoredPage(String productId, [String pageId = 'root']) {
    final pages = productPages
        .firstWhereOrNull((element) => element.productId == productId)
        ?.pages;

    if (pages == null || pages.isEmpty) return null;
    final productPage =
        pages.firstWhereOrNull((p) => p.pageId == pageId) ?? pages.firstOrNull;

    return productPage;
  }

  @action
  Future<ProductPagesModel?> load(String productId, String language) async {
    final result =
        await locator<ProductsRepository>().pages(productId, language);
    final existing = productPages
        .firstWhereOrNull((element) => element.productId == productId);

    if (existing != null) {
      productPages.remove(existing);
    }

    if (result != null) {
      productPages.add(result);

      return result;
    }
    locator<ToastService>().error(tr('pages.not_found_error'));
    return null;
  }

  @action
  void add(ProductPagesModel model) {
    productPages.add(model);
  }

  @action
  void update(ProductPagesModel model) {
    final existing = productPages
        .firstWhereOrNull((element) => element.productId == model.productId);

    if (existing == null) {
      throw Exception(
          'Could not find existing model for productId: ${model.productId}');
    }

    final oldIndex = productPages.indexOf(existing);
    productPages.remove(existing);
    productPages.insert(oldIndex, model);
  }
}
