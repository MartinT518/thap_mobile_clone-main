import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/products/domain/entities/product.dart';

/// Legacy scan history provider stub for backward compatibility
/// Use scanHistoryProvider from scan_history_provider.dart for new code
final scanHistoryStoreProvider = StateNotifierProvider<ScanHistoryStoreNotifier, ScanHistoryStoreState>((ref) {
  return ScanHistoryStoreNotifier();
});

class ScanHistoryStoreState {
  final List<Product> scanHistory;
  final bool isLoading;

  const ScanHistoryStoreState({
    this.scanHistory = const [],
    this.isLoading = false,
  });

  ScanHistoryStoreState copyWith({
    List<Product>? scanHistory,
    bool? isLoading,
  }) {
    return ScanHistoryStoreState(
      scanHistory: scanHistory ?? this.scanHistory,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get hasAny => scanHistory.isNotEmpty;
}

class ScanHistoryStoreNotifier extends StateNotifier<ScanHistoryStoreState> {
  ScanHistoryStoreNotifier() : super(const ScanHistoryStoreState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    // TODO: Implement actual data loading
    await Future.delayed(const Duration(milliseconds: 100));
    state = state.copyWith(isLoading: false);
  }
}
