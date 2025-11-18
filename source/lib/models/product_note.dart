import 'package:json_annotation/json_annotation.dart';

part 'product_note.g.dart';

@JsonSerializable(createToJson: false)
class ProductNoteModel {
  final String id;
  final String? content;
  final List<String> attachments;

  ProductNoteModel(
      {required this.id, this.content, this.attachments = const []});

  factory ProductNoteModel.fromJson(Map<String, dynamic> json) =>
      _$ProductNoteModelFromJson(json);
}
