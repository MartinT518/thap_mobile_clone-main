import 'package:thap/core/config/env.dart';
import 'package:thap/features/auth/domain/entities/user.dart';
import 'package:thap/features/auth/domain/repositories/auth_repository.dart';

/// Demo authentication repository (for testing without real API)
class AuthRepositoryDemo implements AuthRepository {
  @override
  Future<User> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return const User(
      id: 'demo-user-id',
      email: 'demo@example.com',
      name: 'Demo User',
      photoUrl: null,
      token: 'demo-token-123',
      authMethod: AuthMethod.google,
    );
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<User?> getCurrentUser() async {
    // In demo mode, always return demo user if token exists
    return const User(
      id: 'demo-user-id',
      email: 'demo@example.com',
      name: 'Demo User',
      photoUrl: null,
      token: 'demo-token-123',
      authMethod: AuthMethod.google,
    );
  }

  @override
  Future<bool> tryRestoreSession() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In demo mode, require manual button click (don't auto-restore)
    return false;
  }

  @override
  Future<String?> authenticate(String accessToken, String provider) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'demo-token-123';
  }

  @override
  Future<String?> register({
    required String email,
    required String name,
    required String language,
    required String country,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'demo-token-123';
  }

  @override
  Future<bool> isRegistered(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In demo mode, always return false (new user)
    return false;
  }

  @override
  Future<UserProfileData> getProfileData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const UserProfileData(
      countryCode: 'US',
      languageCode: 'en',
    );
  }

  @override
  Future<void> updateProfile({
    String? countryCode,
    String? languageCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

