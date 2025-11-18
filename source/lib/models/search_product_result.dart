class SearchProductResult {
  final String productName;
  final String producerName;
  final String barcode;
  final String? imageUrl;

  SearchProductResult({
    required this.productName,
    required this.producerName,
    required this.barcode,
    this.imageUrl,
  });

  factory SearchProductResult.fromJson(Map<String, dynamic> json) {
    return SearchProductResult(
        productName: json['productName'],
        producerName: json['producerName'],
        barcode: json['barcode'],
        imageUrl: json['imageUrl']);
  }
}
