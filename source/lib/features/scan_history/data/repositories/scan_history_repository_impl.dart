import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/products/data/models/product_model.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/scan_history/data/datasources/scan_history_remote_datasource.dart';
import 'package:thap/features/scan_history/domain/entities/scan_history_item.dart';
import 'package:thap/features/scan_history/domain/repositories/scan_history_repository.dart';

/// Scan history repository implementation
class ScanHistoryRepositoryImpl implements ScanHistoryRepository {
  final ScanHistoryRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  ScanHistoryRepositoryImpl(this._remoteDataSource, this._prefs);

  static const String _historyKey = 'scan_history_local';
  static const int _maxHistoryItems = 100;

  @override
  Future<List<ScanHistoryItem>> getScanHistory() async {
    if (Env.isDemoMode) {
      return _getLocalHistory();
    }

    try {
      final data = await _remoteDataSource.getScanHistory();
      return data.map((json) {
        final productModel = ProductModel.fromJson(json);
        return ScanHistoryItem(
          scanHistoryId: json['scanHistoryId'] ?? '',
          product: productModel.toEntity(),
          scannedAt: DateTime.parse(json['scannedAt'] ?? DateTime.now().toIso8601String()),
        );
      }).toList();
    } catch (e) {
      return _getLocalHistory();
    }
  }

  @override
  Future<void> addToHistory(String productId) async {
    if (Env.isDemoMode) {
      await _addToLocalHistory(productId);
      return;
    }

    try {
      await _remoteDataSource.addToHistory(productId);
    } catch (e) {
      await _addToLocalHistory(productId);
    }
  }

  @override
  Future<void> removeFromHistory(String scanHistoryId) async {
    if (Env.isDemoMode) {
      await _removeFromLocalHistory(scanHistoryId);
      return;
    }

    try {
      await _remoteDataSource.removeFromHistory(scanHistoryId);
    } catch (e) {
      await _removeFromLocalHistory(scanHistoryId);
    }
  }

  @override
  Future<void> clearHistory() async {
    if (Env.isDemoMode) {
      await _prefs.remove(_historyKey);
      return;
    }

    try {
      await _remoteDataSource.clearHistory();
    } catch (e) {
      await _prefs.remove(_historyKey);
    }
  }

  List<ScanHistoryItem> _getLocalHistory() {
    final historyJson = _prefs.getStringList(_historyKey) ?? [];
    // Simplified local storage - in real implementation would store full product data
    return [];
  }

  Future<void> _addToLocalHistory(String productId) async {
    final history = _prefs.getStringList(_historyKey) ?? [];
    if (history.length >= _maxHistoryItems) {
      history.removeLast();
    }
    history.insert(0, productId);
    await _prefs.setStringList(_historyKey, history);
  }

  Future<void> _removeFromLocalHistory(String scanHistoryId) async {
    final history = _prefs.getStringList(_historyKey) ?? [];
    history.remove(scanHistoryId);
    await _prefs.setStringList(_historyKey, history);
  }
}

