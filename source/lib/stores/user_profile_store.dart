// Legacy stub - migrating to Riverpod
class UserProfileStore {
  dynamic get userProfile => null;
  bool get isAuthenticated => false;
  String get userEmail => '';
  String get userName => '';
  String? get token => null;
  
  Future<void> load() async {}
  Future<void> logout() async {}
  Future<void> remove() async {}
  Future<void> setToken(String? token) async {}
  Future<void> set(dynamic profile) async {}
}
