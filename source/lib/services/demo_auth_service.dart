import 'package:thap/features/auth/domain/entities/user.dart'; // AuthMethod
import 'package:thap/models/user_profile.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';

class DemoAuthService {
  Future<String?> socialSignIn(AuthMethod authMethod) async {
    _setDemoUser();
    return 'demo@thap.app';
  }

  Future<bool> authenticate() async {
    return true;
  }

  Future<void> signOut() async {
    locator<UserProfileStore>().remove();
  }

  Future<bool> tryRestoreSession() async {
    _setDemoUser();
    return true;
  }

  Future<bool> register(String language, String country) async {
    return true;
  }

  void _setDemoUser() {
    final userProfile = UserProfileModel(
      email: 'demo@thap.app',
      name: 'Demo User',
      authMethod: AuthMethod.google,
    );
    locator<UserProfileStore>().set(userProfile);
    locator<UserProfileStore>().setToken('demo-token-123');
  }
}
