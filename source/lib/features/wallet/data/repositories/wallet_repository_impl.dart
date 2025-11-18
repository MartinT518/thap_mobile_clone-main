import 'package:thap/core/config/env.dart';
import 'package:thap/features/products/data/models/product_model.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';

/// Wallet repository implementation (API)
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;

  WalletRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<WalletProduct>> getWalletProducts() async {
    final data = await _remoteDataSource.getWalletProducts();
    return data.map((json) {
      // Convert ProductItem JSON to Product entity
      final productModel = ProductModel.fromJson(json);
      final product = productModel.toEntity();

      return WalletProduct(
        instanceId: json['instanceId'] ?? '',
        product: product.copyWith(isOwner: true),
        nickname: json['nickname'],
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );
    }).toList();
  }

  @override
  Future<String> addProductToWallet(String productId) async {
    return await _remoteDataSource.addProductToWallet(productId);
  }

  @override
  Future<void> removeProductFromWallet(String instanceId) async {
    await _remoteDataSource.removeProductFromWallet(instanceId);
  }

  @override
  Future<void> updateNickname(String instanceId, String? nickname) async {
    await _remoteDataSource.updateNickname(instanceId, nickname);
  }

  @override
  Future<void> addTag(String instanceId, String tagId) async {
    await _remoteDataSource.addTag(instanceId, tagId);
  }

  @override
  Future<void> removeTag(String instanceId, String tagId) async {
    await _remoteDataSource.removeTag(instanceId, tagId);
  }
}

