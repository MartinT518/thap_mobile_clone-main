/// Tag entity (domain layer)
class Tag {
  final String id;
  final String title;
  final int itemCount;

  const Tag({
    required this.id,
    required this.title,
    required this.itemCount,
  });

  Tag copyWith({
    String? id,
    String? title,
    int? itemCount,
  }) {
    return Tag(
      id: id ?? this.id,
      title: title ?? this.title,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}

