import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/auth/domain/entities/user.dart';
import 'package:thap/models/auth_method.dart';

void main() {
  group('User Entity', () {
    test('User entity creation with all fields', () {
      final user = User(
        id: 'user-123',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        token: 'token-123',
        authMethod: AuthMethod.google,
      );
      expect(user.id, 'user-123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
      expect(user.token, 'token-123');
      expect(user.authMethod, AuthMethod.google);
    });

    test('User entity creation with minimal fields', () {
      final user = User(
        id: 'user-123',
        email: 'test@example.com',
        name: 'Test User',
        token: 'token-123',
        authMethod: AuthMethod.google,
      );
      expect(user.id, 'user-123');
      expect(user.photoUrl, isNull);
    });
  });
}

