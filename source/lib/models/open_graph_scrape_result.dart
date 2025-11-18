class OpenGraphScrapeResult {
  final String? title;
  final String? description;
  final String? imageUrl;
  final List<String>? imageUrls;

  OpenGraphScrapeResult({
    this.title,
    this.description,
    this.imageUrl,
    this.imageUrls,
  });

  factory OpenGraphScrapeResult.fromJson(Map<String, dynamic> json) {
    return OpenGraphScrapeResult(
        title: json['hybridGraph']['title'],
        description: json['hybridGraph']['description'],
        imageUrl: json['hybridGraph']?['image'],
        imageUrls: (json['htmlInferred']['images'] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }
}
