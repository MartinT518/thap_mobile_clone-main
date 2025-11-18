class ProductItemResult {
  final String name;
  final String code;
  final String image;
  final String price;

  const ProductItemResult({
    required this.name,
    required this.code,
    required this.image,
    required this.price,
  });

  factory ProductItemResult.fromJson(Map<String, dynamic> json) {
    return ProductItemResult(
      name: json['name'],
      code: json['code'],
      image: json['image'],
      price: json['price'],
    );
  }
}
