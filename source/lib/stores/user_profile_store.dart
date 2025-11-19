import 'package:thap/models/user_profile.dart';

// Legacy stub - migrating to Riverpod
class UserProfileStore {
  UserProfileModel? _userProfile;
  String? _token;

  UserProfileModel? get userProfile => _userProfile;
  bool get isAuthenticated => _token != null;
  String get userEmail => _userProfile?.email ?? '';
  String get userName => _userProfile?.name ?? '';
  String? get token => _token;
  
  Future<void> load() async {}
  
  Future<void> logout() async {
    await remove();
  }
  
  Future<void> remove() async {
    _userProfile = null;
    _token = null;
  }
  
  Future<void> setToken(String? token) async {
    _token = token;
  }
  
  Future<void> set(UserProfileModel profile) async {
    _userProfile = profile;
  }
}
