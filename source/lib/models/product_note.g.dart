// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductNoteModel _$ProductNoteModelFromJson(Map<String, dynamic> json) =>
    ProductNoteModel(
      id: json['id'] as String,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
