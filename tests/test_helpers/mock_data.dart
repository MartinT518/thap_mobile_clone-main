import 'package:thap/features/auth/domain/entities/user.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/models/auth_method.dart';

/// Mock data for testing
class MockData {
  static User get mockUser => User(
        id: 'user-123',
        email: 'test@example.com',
        name: 'Test User',
        token: 'mock-token-123',
        authMethod: AuthMethod.google,
      );

  static Product get mockProduct => Product(
        id: 'product-123',
        name: 'Test Product',
        brand: 'Test Brand',
        barcode: '1234567890',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test product description',
        isOwner: false,
        tags: ['electronics', 'test'],
      );

  static Product get mockOwnedProduct => Product(
        id: 'product-456',
        name: 'Owned Product',
        brand: 'Owned Brand',
        barcode: '0987654321',
        isOwner: true,
      );

  static WalletProduct get mockWalletProduct => WalletProduct(
        instanceId: 'instance-123',
        product: mockOwnedProduct,
        dateAdded: DateTime(2024, 1, 1),
        nickname: 'My Favorite Product',
        tags: ['favorite'],
      );

  static List<Product> get mockProductList => [
        mockProduct,
        mockOwnedProduct,
        Product(
          id: 'product-789',
          name: 'Another Product',
          brand: 'Another Brand',
          isOwner: false,
        ),
      ];

  static Map<String, dynamic> get mockProductJson => {
        'id': 'product-123',
        'name': 'Test Product',
        'brand': 'Test Brand',
        'barcode': '1234567890',
        'imageUrl': 'https://example.com/image.jpg',
        'description': 'Test product description',
        'isOwner': false,
        'tags': ['electronics', 'test'],
      };

  static Map<String, dynamic> get mockUserJson => {
        'id': 'user-123',
        'email': 'test@example.com',
        'name': 'Test User',
        'token': 'mock-token-123',
        'authMethod': 'google',
      };
}

