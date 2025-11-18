// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feed_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeedMessageModel _$UserFeedMessageModelFromJson(
  Map<String, dynamic> json,
) => UserFeedMessageModel(
  brandName: json['brandName'] as String,
  productNames:
      (json['productNames'] as List<dynamic>).map((e) => e as String).toList(),
  text: json['text'] as String,
  url: json['url'] as String?,
  imageUrl: json['imageUrl'] as String?,
);
