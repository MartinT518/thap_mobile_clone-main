import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thap/features/wallet/data/providers/wallet_repository_provider.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';

// TODO: Generate with build_runner
// part 'wallet_provider.freezed.dart';
// part 'wallet_provider.g.dart';

/// Wallet state - stubbed for compilation
class WalletState {
  const WalletState._();
  const factory WalletState.initial() = _Initial;
  const factory WalletState.loading() = _Loading;
  const factory WalletState.loaded(List<WalletProduct> products) = _Loaded;
  const factory WalletState.error(String message) = _Error;
}

class _Initial extends WalletState {
  const _Initial() : super._();
}
class _Loading extends WalletState {
  const _Loading() : super._();
}
class _Loaded extends WalletState {
  final List<WalletProduct> products;
  const _Loaded(this.products) : super._();
}
class _Error extends WalletState {
  final String message;
  const _Error(this.message) : super._();
}

/// Wallet notifier - stubbed
class WalletNotifier {
  WalletState build() => const WalletState.initial();
  WalletState state = const WalletState.initial();
  
  /// Load wallet products
  Future<void> loadWalletProducts() async {
    state = const WalletState.loading();
    // TODO: implement after code generation
  }

  /// Add product to wallet
  Future<String?> addProductToWallet(String productId) async {
    // TODO: implement after code generation
    return null;
  }

  /// Remove product from wallet
  Future<bool> removeProductFromWallet(String instanceId) async {
    // TODO: implement after code generation
    return false;
  }

  /// Get specific wallet product
  Future<void> getWalletProduct(String instanceId) async {
    // TODO: implement after code generation
  }

  /// Check if product is in wallet
  bool isProductInWallet(String productId) {
    // TODO: implement after code generation
    return false;
  }

  /// Get wallet product by product ID
  WalletProduct? getWalletProductByProductId(String productId) {
    // TODO: implement after code generation
    return null;
  }
}

// Stubbed provider for compilation
final walletNotifierProvider = _WalletNotifierProvider();

class _WalletNotifierProvider {
  WalletNotifier call() => WalletNotifier();
}

