import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/models/product_item.dart';

/// Stub provider for my tings - to be properly implemented
final myTingsProvider = StateNotifierProvider<MyTingsNotifier, MyTingsState>((ref) {
  return MyTingsNotifier();
});

class MyTingsState {
  final List<ProductItem> myTings;
  final List<ProductItem> sharedTings;
  final bool isLoading;
  final String filterTagId;
  final bool displayGrid;

  const MyTingsState({
    this.myTings = const [],
    this.sharedTings = const [],
    this.isLoading = false,
    this.filterTagId = '',
    this.displayGrid = false,
  });

  MyTingsState copyWith({
    List<ProductItem>? myTings,
    List<ProductItem>? sharedTings,
    bool? isLoading,
    String? filterTagId,
    bool? displayGrid,
  }) {
    return MyTingsState(
      myTings: myTings ?? this.myTings,
      sharedTings: sharedTings ?? this.sharedTings,
      isLoading: isLoading ?? this.isLoading,
      filterTagId: filterTagId ?? this.filterTagId,
      displayGrid: displayGrid ?? this.displayGrid,
    );
  }

  bool get hasAny => myTings.isNotEmpty || sharedTings.isNotEmpty;

  List<ProductItem> get myTingsFiltered {
    // TODO: Implement tag filtering when tag relationships are available
    return myTings;
  }

  List<ProductItem> get sharedTingsFiltered {
    // TODO: Implement tag filtering when tag relationships are available
    return sharedTings;
  }

  ProductItem? getTing(String productId) {
    try {
      return myTings.firstWhere((t) => t.id == productId || t.instanceId == productId);
    } catch (e) {
      return null;
    }
  }
}

class MyTingsNotifier extends StateNotifier<MyTingsState> {
  MyTingsNotifier() : super(const MyTingsState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    // TODO: Implement actual data loading
    await Future.delayed(const Duration(milliseconds: 100));
    state = state.copyWith(isLoading: false);
  }

  Future<void> remove(ProductItem product) async {
    final updated = state.myTings.where((t) => t.id != product.id).toList();
    state = state.copyWith(myTings: updated);
  }

  void setFilterTagId(String tagId) {
    state = state.copyWith(filterTagId: tagId);
  }

  void setDisplayGrid(bool displayGrid) {
    state = state.copyWith(displayGrid: displayGrid);
  }
}
