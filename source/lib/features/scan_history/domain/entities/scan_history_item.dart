import 'package:thap/features/products/domain/entities/product.dart';

/// Scan history item entity
class ScanHistoryItem {
  final String scanHistoryId;
  final Product product;
  final DateTime scannedAt;

  const ScanHistoryItem({
    required this.scanHistoryId,
    required this.product,
    required this.scannedAt,
  });
}

