// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdn_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CdnImage _$CdnImageFromJson(Map<String, dynamic> json) => CdnImage(
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String?,
      normal: json['normal'] as String?,
      full: json['full'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CdnImageToJson(CdnImage instance) => <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'normal': instance.normal,
      'full': instance.full,
      'title': instance.title,
    };
