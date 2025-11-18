import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thap/features/wallet/data/providers/wallet_repository_provider.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';

part 'wallet_provider.freezed.dart';
part 'wallet_provider.g.dart';

/// Wallet state
@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.loading() = _Loading;
  const factory WalletState.loaded(List<WalletProduct> products) = _Loaded;
  const factory WalletState.error(String message) = _Error;
}

/// Wallet notifier
@riverpod
class WalletNotifier extends _$WalletNotifier {
  @override
  WalletState build() => const WalletState.initial();

  WalletRepository get _repository => ref.read(walletRepositoryProvider);

  /// Load wallet products
  Future<void> loadWalletProducts() async {
    state = const WalletState.loading();
    try {
      final products = await _repository.getWalletProducts();
      state = WalletState.loaded(products);
    } catch (e) {
      state = WalletState.error(e.toString());
    }
  }

  /// Add product to wallet
  Future<String?> addProductToWallet(String productId) async {
    try {
      final instanceId = await _repository.addProductToWallet(productId);
      // Reload wallet products
      await loadWalletProducts();
      return instanceId;
    } catch (e) {
      state = WalletState.error(e.toString());
      return null;
    }
  }

  /// Remove product from wallet
  Future<bool> removeProductFromWallet(String instanceId) async {
    try {
      await _repository.removeProductFromWallet(instanceId);
      // Reload wallet products
      await loadWalletProducts();
      return true;
    } catch (e) {
      state = WalletState.error(e.toString());
      return false;
    }
  }

  /// Check if product is in wallet
  bool isProductInWallet(String productId) {
    return state.maybeWhen(
      loaded: (products) =>
          products.any((p) => p.product.id == productId),
      orElse: () => false,
    );
  }

  /// Get wallet product by product ID
  WalletProduct? getWalletProductByProductId(String productId) {
    return state.maybeWhen(
      loaded: (products) {
        try {
          return products.firstWhere((p) => p.product.id == productId);
        } catch (e) {
          return null;
        }
      },
      orElse: () => null,
    );
  }
}

