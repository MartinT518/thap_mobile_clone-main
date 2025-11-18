import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';

void main() {
  group('WalletProduct Entity', () {
    test('displayName returns nickname when available', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        brand: 'Brand',
        isOwner: true,
      );
      final walletProduct = WalletProduct(
        instanceId: 'instance-1',
        product: product,
        nickname: 'My Product',
      );
      expect(walletProduct.displayName, 'My Product');
    });

    test('displayName returns product displayName when nickname is null', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        brand: 'Brand',
        isOwner: true,
      );
      final walletProduct = WalletProduct(
        instanceId: 'instance-1',
        product: product,
      );
      expect(walletProduct.displayName, 'Product Name');
    });

    test('copyWith creates new instance with updated fields', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        brand: 'Brand',
        isOwner: true,
      );
      final original = WalletProduct(
        instanceId: 'instance-1',
        product: product,
        nickname: 'Original',
      );
      final updated = original.copyWith(nickname: 'Updated');
      expect(updated.nickname, 'Updated');
      expect(updated.instanceId, 'instance-1');
    });
  });
}

