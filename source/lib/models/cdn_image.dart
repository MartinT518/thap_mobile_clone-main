import 'package:json_annotation/json_annotation.dart';
import 'package:thap/extensions/string_extensions.dart';

part 'cdn_image.g.dart';

@JsonSerializable()
class CdnImage {
  final String url;
  final String? thumbnail;
  final String? normal;
  final String? full;
  final String? title;

  CdnImage(
      {required this.url, this.thumbnail, this.normal, this.full, this.title});

  String getThumbnail() => thumbnail.isNotBlank ? thumbnail! : url;
  String getNormal() => normal.isNotBlank ? normal! : url;
  String getFull() => full.isNotBlank ? full! : url;

  factory CdnImage.fromJson(Map<String, dynamic> json) =>
      _$CdnImageFromJson(json);
}
