import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';
import 'package:thap/features/products/data/providers/products_repository_provider.dart';

// TODO: Generate with build_runner
// part 'scan_provider.freezed.dart';
// part 'scan_provider.g.dart';

/// Scan state - stubbed for compilation
class ScanState {
  const ScanState._();
  const factory ScanState.initial() = _Initial;
  const factory ScanState.scanning() = _Scanning;
  const factory ScanState.processing() = _Processing;
  const factory ScanState.success(Product product) = _Success;
  const factory ScanState.notFound() = _NotFound;
  const factory ScanState.error(String message) = _Error;
  
  T maybeWhen<T>({
    T Function()? initial,
    T Function()? scanning,
    T Function()? processing,
    T Function(Product)? success,
    T Function()? notFound,
    T Function(String)? error,
    required T Function() orElse,
  }) => orElse();
}

class _Initial extends ScanState {
  const _Initial() : super._();
}
class _Scanning extends ScanState {
  const _Scanning() : super._();
}
class _Processing extends ScanState {
  const _Processing() : super._();
}
class _Success extends ScanState {
  final Product product;
  const _Success(this.product) : super._();
}
class _NotFound extends ScanState {
  const _NotFound() : super._();
}
class _Error extends ScanState {
  final String message;
  const _Error(this.message) : super._();
}

/// Scan notifier - stubbed
class ScanNotifier {
  ScanState build() => const ScanState.initial();
  ScanState state = const ScanState.initial();
  dynamic ref;

  /// Scan QR code
  Future<void> scanQrCode(String codeData, String codeType) async {
    state = const ScanState.processing();
    // TODO: implement after code generation
  }

  /// Reset scan state
  void reset() {
    state = const ScanState.initial();
  }
}

// Stubbed provider for compilation
final scanNotifierProvider = _ScanNotifierProvider();

class _ScanNotifierProvider {
  ScanNotifier get notifier => ScanNotifier();
  ScanNotifier call() => ScanNotifier();
}

