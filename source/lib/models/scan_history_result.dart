class ScanHistoryResult {
  final String scanHistoryId;
  final String productId;
  final String? tingId;
  final String? bookmarkId;
  final String displayName;
  final String producerName;
  final String barcode;
  final String imageUrl;
  final String? verifiedProductLogoUrl;
  final String? externalSource;

  const ScanHistoryResult(
      {required this.scanHistoryId,
      required this.productId,
      required this.displayName,
      required this.imageUrl,
      this.verifiedProductLogoUrl,
      this.externalSource,
      required this.producerName,
      required this.barcode,
      this.tingId,
      this.bookmarkId});

  factory ScanHistoryResult.fromJson(Map<String, dynamic> json) {
    return ScanHistoryResult(
      scanHistoryId: json['scanHistoryId'],
      productId: json['productId'],
      tingId: json['tingId'],
      bookmarkId: json['bookmarkId'],
      displayName: json['displayName'],
      producerName: json['producerName'],
      barcode: json['barcode'],
      imageUrl: json['imageUrl'],
      verifiedProductLogoUrl: json['verifiedProductLogoUrl'],
      externalSource: json['externalSource'],
    );
  }
}
