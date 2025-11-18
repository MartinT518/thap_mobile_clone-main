import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';

/// Wallet repository demo implementation
class WalletRepositoryDemo implements WalletRepository {
  final List<WalletProduct> _demoProducts = [];

  @override
  Future<List<WalletProduct>> getWalletProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_demoProducts);
  }

  @override
  Future<String> addProductToWallet(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final instanceId = 'demo-instance-${DateTime.now().millisecondsSinceEpoch}';
    final product = Product(
      id: productId,
      name: 'Demo Product',
      brand: 'Demo Brand',
      isOwner: true,
    );
    final walletProduct = WalletProduct(
      instanceId: instanceId,
      product: product,
      dateAdded: DateTime.now(),
    );
    _demoProducts.insert(0, walletProduct);
    return instanceId;
  }

  @override
  Future<void> removeProductFromWallet(String instanceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _demoProducts.removeWhere((p) => p.instanceId == instanceId);
  }

  @override
  Future<void> updateNickname(String instanceId, String? nickname) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _demoProducts.indexWhere((p) => p.instanceId == instanceId);
    if (index != -1) {
      _demoProducts[index] = _demoProducts[index].copyWith(nickname: nickname);
    }
  }

  @override
  Future<void> addTag(String instanceId, String tagId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _demoProducts.indexWhere((p) => p.instanceId == instanceId);
    if (index != -1) {
      final tags = List<String>.from(_demoProducts[index].tags)..add(tagId);
      _demoProducts[index] = _demoProducts[index].copyWith(tags: tags);
    }
  }

  @override
  Future<void> removeTag(String instanceId, String tagId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _demoProducts.indexWhere((p) => p.instanceId == instanceId);
    if (index != -1) {
      final tags = List<String>.from(_demoProducts[index].tags)
        ..remove(tagId);
      _demoProducts[index] = _demoProducts[index].copyWith(tags: tags);
    }
  }
}

