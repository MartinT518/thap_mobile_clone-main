// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/features/auth/domain/entities/user.dart'; // AuthMethod
import 'package:thap/models/user_profile.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';

class AuthService {
  final _userProfileStore = locator<UserProfileStore>();
  final _userRepository = locator<UserRepository>();
  GoogleSignIn? _googleSignIn;
  
  GoogleSignIn get googleSignIn {
    _googleSignIn ??= GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    );
    return _googleSignIn!;
  }

  Future<String?> socialSignIn(AuthMethod authMethod) async {
    switch (authMethod) {
      case AuthMethod.google:
        final user = await googleSignIn.signIn();

        if (user != null) {
          _setUserProfileGoogle(user);
          return user.email;
        }
        break;
      case AuthMethod.facebook:
        // final result = await FacebookAuth.instance.login();
        //
        // if (result.status == LoginStatus.success) {
        //   final user = await FacebookAuth.instance.getUserData();
        //
        //   _setUserProfileFacebook(user);
        //   return user['email'];
        // }
        break;
    }

    return null;
  }

  Future<bool> authenticate() async {
    final user = _userProfileStore.userProfile;

    if (user == null) return false;

    switch (user.authMethod) {
      case AuthMethod.google:
        return await _authenticate(user.email, 'google');
      case AuthMethod.facebook:
        return await _authenticate(user.email, 'facebook');
    }
  }

  Future<void> signOut() async {
    final userProfile = _userProfileStore.userProfile;

    if (userProfile == null) return;

    if (userProfile.authMethod == AuthMethod.google) {
      await googleSignIn.disconnect();
    } else if (userProfile.authMethod == AuthMethod.facebook) {
      // await FacebookAuth.instance.logOut();
    }

    _userProfileStore.remove();
    await _removeSavedToken();
  }

  Future<bool> tryRestoreSession() async {
    // Check google session
    var isSignedIn = await _tryRestoreSessionGoogle();

    // Check facebook session
    if (!isSignedIn) {
      isSignedIn = await _tryRestoreSessionFacebook();
    }

    // Verify our token
    if (isSignedIn) {
      isSignedIn = await _restoreToken();
    }

    return isSignedIn;
  }

  Future<bool> register(String language, String country) async {
    final userProfile = _userProfileStore.userProfile;

    if (userProfile == null) return false;

    final token = await _userRepository.register(
      userProfile.email,
      userProfile.name,
      language,
      country,
    );

    if (token.isBlank) return false;

    await _saveToken(token!);

    _userProfileStore.setToken(token);

    return true;
  }

  Future<bool> _tryRestoreSessionGoogle() async {
    final isSignedIn = await googleSignIn.isSignedIn();

    if (!isSignedIn) return false;

    final user = await googleSignIn.signInSilently();

    if (user == null) return false;

    _setUserProfileGoogle(user);
    return true;
  }

  Future<bool> _tryRestoreSessionFacebook() async {
    return false;
    // final isSignedIn = (await FacebookAuth.instance.accessToken) != null;
    //
    // if (!isSignedIn) return false;
    //
    // final user = await FacebookAuth.instance.getUserData();
    //
    // if (user['name'] == null) return false;
    //
    // _setUserProfileFacebook(user);
    // return true;
  }

  void _setUserProfileGoogle(GoogleSignInAccount user) {
    _userProfileStore.set(
      UserProfileModel(
        name: user.displayName ?? 'Unknown',
        email: user.email,
        photoUrl: user.photoUrl,
        authMethod: AuthMethod.google,
      ),
    );
  }

  void _setUserProfileFacebook(Map<String, dynamic> user) {
    _userProfileStore.set(
      UserProfileModel(
        name: user['name'],
        email: user['email'],
        photoUrl: user['picture']['data']['url'],
        authMethod: AuthMethod.facebook,
      ),
    );
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return token;
  }

  Future<void> _removeSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<bool> _restoreToken() async {
    final token = await _getSavedToken();

    if (token.isBlank) return false;

    _userProfileStore.setToken(token!);

    // TODO read profile data
    // TODO check token expiry
    var isValid = true;

    return isValid;
  }

  Future<bool> _authenticate(String accessToken, String provider) async {
    final token = await _userRepository.authenticate(accessToken, provider);

    if (token.isBlank) return false;

    await _saveToken(token!);

    _userProfileStore.setToken(token);

    return true;
  }
}
