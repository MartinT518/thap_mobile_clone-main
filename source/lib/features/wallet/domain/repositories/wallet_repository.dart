import 'package:thap/features/wallet/domain/entities/wallet_product.dart';

/// Wallet repository interface (domain layer)
abstract class WalletRepository {
  /// Get all products in wallet
  Future<List<WalletProduct>> getWalletProducts();

  /// Add product to wallet
  /// Returns the instance ID of the created wallet product
  Future<String> addProductToWallet(String productId);

  /// Remove product from wallet
  Future<void> removeProductFromWallet(String instanceId);

  /// Update product nickname
  Future<void> updateNickname(String instanceId, String? nickname);

  /// Add tag to product
  Future<void> addTag(String instanceId, String tagId);

  /// Remove tag from product
  Future<void> removeTag(String instanceId, String tagId);
}

