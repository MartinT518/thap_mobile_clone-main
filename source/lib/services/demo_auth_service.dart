import 'package:thap/features/auth/domain/entities/user.dart'; // AuthMethod
import 'package:thap/models/user_profile.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';

class DemoAuthService extends AuthService {
  @override
  Future<String?> socialSignIn(AuthMethod authMethod) async {
    _setDemoUser();
    return 'demo@thap.app';
  }

  @override
  Future<bool> authenticate() async {
    return true;
  }

  @override
  Future<void> signOut() async {
    locator<UserProfileStore>().remove();
  }

  @override
  Future<bool> tryRestoreSession() async {
    _setDemoUser();
    return true;
  }

  @override
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
