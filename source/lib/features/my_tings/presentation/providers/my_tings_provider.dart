import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';

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
    if (filterTagId.isEmpty) {
      return myTings;
    }
    return myTings.where((product) => product.tags.contains(filterTagId)).toList();
  }

  List<ProductItem> get sharedTingsFiltered {
    if (filterTagId.isEmpty) {
      return sharedTings;
    }
    return sharedTings.where((product) => product.tags.contains(filterTagId)).toList();
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
    try {
      final repo = locator<MyTingsRepository>();
      final items = await repo.list();
      final sharedItems = await repo.sharedList();
      state = state.copyWith(
        myTings: items,
        sharedTings: sharedItems,
        isLoading: false,
      );
    } catch (e) {
      print('Error loading my tings provider: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> remove(ProductItem product) async {
    try {
      if (product.instanceId != null) {
        final repo = locator<MyTingsRepository>();
        await repo.delete(product.instanceId!);
      }
      final updated = state.myTings.where((t) => t.id != product.id && t.instanceId != product.instanceId).toList();
      state = state.copyWith(myTings: updated);
    } catch (e) {
      print('Error removing product: $e');
      // Still update UI even if backend call fails
      final updated = state.myTings.where((t) => t.id != product.id && t.instanceId != product.instanceId).toList();
      state = state.copyWith(myTings: updated);
    }
  }

  void setFilterTagId(String tagId) {
    state = state.copyWith(filterTagId: tagId);
  }

  void setDisplayGrid(bool displayGrid) {
    state = state.copyWith(displayGrid: displayGrid);
  }
}
