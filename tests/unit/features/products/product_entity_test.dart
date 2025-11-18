import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/products/domain/entities/product.dart';

void main() {
  group('Product Entity', () {
    test('displayName returns nickname when available', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        nickname: 'My Product',
        brand: 'Brand',
        isOwner: false,
      );
      expect(product.displayName, 'My Product');
    });

    test('displayName returns name when nickname is null', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        brand: 'Brand',
        isOwner: false,
      );
      expect(product.displayName, 'Product Name');
    });

    test('displayName returns name when nickname is empty', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        nickname: '',
        brand: 'Brand',
        isOwner: false,
      );
      expect(product.displayName, 'Product Name');
    });

    test('copyWith creates new instance with updated fields', () {
      final original = Product(
        id: '1',
        name: 'Original Name',
        brand: 'Original Brand',
        isOwner: false,
      );
      final updated = original.copyWith(name: 'Updated Name');
      expect(updated.name, 'Updated Name');
      expect(updated.brand, 'Original Brand');
      expect(updated.id, '1');
    });
  });
}

