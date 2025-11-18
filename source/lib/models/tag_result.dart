import 'package:thap/utilities/utilities.dart';

class TagResult {
  final String id;
  final String title;
  final int itemCount;

  const TagResult(
      {required this.id, required this.title, required this.itemCount});

  factory TagResult.fromJson(Map<String, dynamic> json) {
    return TagResult(
        id: json['id'],
        title: apiTranslate(json['title']),
        itemCount: json['items']);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'items': itemCount};

  TagResult copyWith({
    String? id,
    String? title,
    int? itemCount,
  }) {
    return TagResult(
      id: id ?? this.id,
      title: title ?? this.title,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
