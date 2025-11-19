import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/models/product_page.dart';

/// Stub provider for product pages - to be properly implemented
final productPagesProvider = StateNotifierProvider<ProductPagesNotifier, ProductPagesState>((ref) {
  return ProductPagesNotifier();
});

class ProductPagesState {
  final Map<String, ProductPageModel> pages;
  final bool isLoading;

  const ProductPagesState({
    this.pages = const {},
    this.isLoading = false,
  });

  ProductPagesState copyWith({
    Map<String, ProductPageModel>? pages,
    bool? isLoading,
  }) {
    return ProductPagesState(
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  ProductPageModel? getStoredPage(String productId, String pageId) {
    final key = '${productId}_$pageId';
    return pages[key];
  }
}

class ProductPagesNotifier extends StateNotifier<ProductPagesState> {
  ProductPagesNotifier() : super(const ProductPagesState());

  void storePage(String productId, String pageId, ProductPageModel page) {
    final key = '${productId}_$pageId';
    final updated = Map<String, ProductPageModel>.from(state.pages);
    updated[key] = page;
    state = state.copyWith(pages: updated);
  }

  ProductPageModel? getStoredPage(String productId, String pageId) {
    return state.getStoredPage(productId, pageId);
  }
}
