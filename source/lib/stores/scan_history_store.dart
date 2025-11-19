// Legacy stub - migrating to Riverpod
class ScanHistoryStore {
  List<dynamic> get scanHistory => [];
  bool get hasAny => false;
  bool get isLoading => false;
  
  Future<void> load() async {}
  Future<void> add(dynamic item) async {}
  Future<void> remove(dynamic item) async {}
}
