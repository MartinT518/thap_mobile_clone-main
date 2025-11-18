import 'package:thap/features/auth/domain/entities/user.dart';

/// Authentication repository interface (domain layer)
abstract class AuthRepository {
  /// Sign in with Google OAuth
  Future<User> signInWithGoogle();

  /// Sign out the current user
  Future<void> signOut();

  /// Get the current authenticated user
  Future<User?> getCurrentUser();

  /// Restore session from stored token
  Future<bool> tryRestoreSession();

  /// Authenticate with backend using access token
  Future<String?> authenticate(String accessToken, String provider);

  /// Register new user
  Future<String?> register({
    required String email,
    required String name,
    required String language,
    required String country,
  });

  /// Check if user is registered
  Future<bool> isRegistered(String email);

  /// Get user profile data
  Future<UserProfileData> getProfileData();

  /// Update user profile
  Future<void> updateProfile({
    String? countryCode,
    String? languageCode,
  });
}

/// User profile data
class UserProfileData {
  final String? countryCode;
  final String? languageCode;

  const UserProfileData({
    this.countryCode,
    this.languageCode,
  });
}

