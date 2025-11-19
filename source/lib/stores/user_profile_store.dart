// Legacy stub - migrating to Riverpod
class UserProfileStore {
  dynamic get userProfile => null;
  bool get isAuthenticated => false;
  String get userEmail => '';
  String get userName => '';
  
  Future<void> load() async {}
  Future<void> logout() async {}
}
