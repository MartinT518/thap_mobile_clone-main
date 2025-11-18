import 'package:thap/features/scan_history/domain/entities/scan_history_item.dart';

/// Scan history repository interface
abstract class ScanHistoryRepository {
  /// Get scan history (max 100 items)
  Future<List<ScanHistoryItem>> getScanHistory();

  /// Add product to scan history
  Future<void> addToHistory(String productId);

  /// Remove product from scan history
  Future<void> removeFromHistory(String scanHistoryId);

  /// Clear all scan history
  Future<void> clearHistory();
}

