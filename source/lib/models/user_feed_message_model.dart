import 'package:json_annotation/json_annotation.dart';

part 'user_feed_message_model.g.dart';

@JsonSerializable(createToJson: false)
class UserFeedMessageModel {
  final String brandName;
  final List<String> productNames;
  final String text;
  final String? url;
  final String? imageUrl;

  UserFeedMessageModel({
    required this.brandName,
    required this.productNames,
    required this.text,
    this.url,
    this.imageUrl,
  });

  factory UserFeedMessageModel.fromJson(Map<String, dynamic> json) =>
      _$UserFeedMessageModelFromJson(json);
}
