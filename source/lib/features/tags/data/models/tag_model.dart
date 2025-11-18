import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thap/features/tags/domain/entities/tag.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required String id,
    required String title,
    @JsonKey(name: 'items') required int itemCount,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  // Convert TagModel to Tag entity
  Tag toEntity() => Tag(
        id: id,
        title: title,
        itemCount: itemCount,
      );
}

