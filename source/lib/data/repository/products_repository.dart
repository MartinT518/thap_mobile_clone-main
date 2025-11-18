import 'package:logger/logger.dart';
import 'package:thap/data/network/api/products_api.dart';
import 'package:thap/models/product_form.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/models/search_product_result.dart';

class ProductsRepository {
  final ProductsApi _api;

  ProductsRepository(this._api);

  Future<ProductItem?> getProduct(String productId) async {
    final response = await _api.getProduct(productId);

    if (response.statusCode == 200) {
      return ProductItem.fromJson(response.data);
    } else {
      Logger().e('Failed to get product: $productId');
      return null;
    }
  }

  Future<ProductItem?> findByQrUrl(Uri qrUrl) async {
    final response = await _api.findByQrUrl(qrUrl.toString());

    if (response.statusCode == 200) {
      return ProductItem.fromJson(response.data);
    } else {
      Logger().e('Failed to find product by QR url: $qrUrl');
      return null;
    }
  }

  Future<ProductPagesModel?> pages(String productId, String language) async {
    try {
      final response = await _api.pages(productId, language);

      if (response.statusCode == 200 && response.data != null) {
        return ProductPagesModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      Logger().e('Failed to load product pages', error: e);
      return null;
    }
  }

  Future<ProductItem?> scan(String codeData, String codeType) async {
    final response = await _api.scan(codeData, codeType);

    if (response.statusCode == 200) {
      return ProductItem.fromJson(response.data);
    } else {
      Logger().e('Failed to scan product');
      return null;
    }
  }

  Future<List<SearchProductResult>?> search(String keyword) async {
    final response = await _api.search(keyword);

    if (response.statusCode == 200) {
      return (response.data as List).map((result) => SearchProductResult.fromJson(result)).toList();
    } else {
      Logger().e('Failed to search products: $keyword');
      return null;
    }
  }

  Future<ProductItem?> findByEan(String ean) async {
    try {
      final response = await _api.findByEan(ean);

      if (response.statusCode == 200) {
        return ProductItem.fromJson(response.data);
      } else {
        Logger().e('Failed to find product: $ean');
        return null;
      }
    } catch (e) {
      Logger().e('Failed to find product: $ean', error: e);
      return null;
    }
  }

  Future<ProductFormModel?> registrationForm(String productId) async {
    try {
      final response = await _api.registrationForm(productId);

      if (response.statusCode == 200) {
        if (response.data == null || response.data.length == 0) return null;

        return ProductFormModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      Logger().e('Failed to read product form', error: e);

      return null;
    }
  }

  Future feedback(String productId, String feedback, String? name, String? email) async {
    final response = await _api.feedback(productId, feedback, name, email);

    if (response.statusCode != 200) {
      Logger().e('Failed to send feedback');
    }
  }
}
