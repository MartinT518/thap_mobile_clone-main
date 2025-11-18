import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/constants.dart';
import 'package:thap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:thap/features/auth/data/models/user_model.dart';
import 'package:thap/features/auth/domain/entities/user.dart';
import 'package:thap/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication repository implementation (API)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._googleSignIn,
    this._secureStorage,
  );

  /// Get SharedPreferences instance (async)
  Future<SharedPreferences> get _sharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Sign in cancelled');
    }

    // Get access token for backend authentication
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;

    if (accessToken == null) {
      throw Exception('Failed to get access token');
    }

    // Authenticate with backend
    final token = await authenticate(accessToken, 'google');
    if (token == null) {
      throw Exception('Backend authentication failed');
    }

    // Create user entity
    return User(
      id: googleUser.id,
      email: googleUser.email,
      name: googleUser.displayName ?? 'Unknown',
      photoUrl: googleUser.photoUrl,
      token: token,
      authMethod: AuthMethod.google,
    );
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: AppConstants.authTokenKey);
    final prefs = await _sharedPreferences;
    await prefs.remove('user_email');
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _secureStorage.read(key: AppConstants.authTokenKey);
    if (token == null) return null;

    final prefs = await _sharedPreferences;
    final email = prefs.getString('user_email');
    if (email == null) return null;

    // Try to restore Google session
    final googleUser = await _googleSignIn.signInSilently();
    if (googleUser == null) return null;

    return User(
      id: googleUser.id,
      email: googleUser.email,
      name: googleUser.displayName ?? 'Unknown',
      photoUrl: googleUser.photoUrl,
      token: token,
      authMethod: AuthMethod.google,
    );
  }

  @override
  Future<bool> tryRestoreSession() async {
    final isSignedIn = await _googleSignIn.isSignedIn();
    if (!isSignedIn) return false;

    final googleUser = await _googleSignIn.signInSilently();
    if (googleUser == null) return false;

    final token = await _secureStorage.read(key: AppConstants.authTokenKey);
    if (token == null) return false;

    // Verify token is still valid by checking profile
    try {
      await getProfileData();
      return true;
    } catch (e) {
      // Token expired or invalid
      await signOut();
      return false;
    }
  }

  @override
  Future<String?> authenticate(String accessToken, String provider) async {
    final token = await _remoteDataSource.authenticate(accessToken, provider);
    if (token != null) {
      await _secureStorage.write(key: AppConstants.authTokenKey, value: token);
    }
    return token;
  }

  @override
  Future<String?> register({
    required String email,
    required String name,
    required String language,
    required String country,
  }) async {
    final token = await _remoteDataSource.register(
      email: email,
      name: name,
      language: language,
      country: country,
    );

    if (token != null) {
      await _secureStorage.write(key: AppConstants.authTokenKey, value: token);
      final prefs = await _sharedPreferences;
      await prefs.setString('user_email', email);
    }

    return token;
  }

  @override
  Future<bool> isRegistered(String email) async {
    return await _remoteDataSource.isRegistered(email);
  }

  @override
  Future<UserProfileData> getProfileData() async {
    final data = await _remoteDataSource.getProfileData();
    if (data == null) {
      throw Exception('Failed to get profile data');
    }

    return UserProfileData(
      countryCode: data['countryCode'] as String?,
      languageCode: data['languageCode'] as String?,
    );
  }

  @override
  Future<void> updateProfile({
    String? countryCode,
    String? languageCode,
  }) async {
    final success = await _remoteDataSource.updateProfile(
      countryCode: countryCode,
      languageCode: languageCode,
    );

    if (!success) {
      throw Exception('Failed to update profile');
    }
  }
}

