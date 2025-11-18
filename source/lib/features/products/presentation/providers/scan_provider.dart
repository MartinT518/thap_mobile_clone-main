import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';
import 'package:thap/features/products/data/providers/products_repository_provider.dart';

part 'scan_provider.freezed.dart';
part 'scan_provider.g.dart';

/// Scan state
@freezed
class ScanState with _$ScanState {
  const factory ScanState.initial() = _Initial;
  const factory ScanState.scanning() = _Scanning;
  const factory ScanState.processing() = _Processing;
  const factory ScanState.success(Product product) = _Success;
  const factory ScanState.notFound() = _NotFound;
  const factory ScanState.error(String message) = _Error;
}

/// Scan notifier
@riverpod
class ScanNotifier extends _$ScanNotifier {
  @override
  ScanState build() => const ScanState.initial();

  ProductsRepository get _repository => ref.read(productsRepositoryProvider);

  /// Scan QR code
  Future<void> scanQrCode(String codeData, String codeType) async {
    state = const ScanState.processing();
    try {
      final product = await _repository.scanQrCode(codeData, codeType);
      if (product != null) {
        state = ScanState.success(product);
      } else {
        state = const ScanState.notFound();
      }
    } catch (e) {
      state = ScanState.error(e.toString());
    }
  }

  /// Reset scan state
  void reset() {
    state = const ScanState.initial();
  }
}

