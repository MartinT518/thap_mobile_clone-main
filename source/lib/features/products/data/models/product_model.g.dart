// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      instanceId: json['instanceId'] as String?,
      name: json['name'] as String,
      nickname: json['nickname'] as String?,
      brand: json['brand'] as String,
      barcode: json['barcode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      brandLogoUrl: json['brandLogoUrl'] as String?,
      code: json['code'] as String?,
      qrCode: json['qrCode'] as String?,
      qrCodes:
          (json['qrCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shareLink: json['shareLink'] as String?,
      description: json['description'] as String?,
      isOwner: json['isOwner'] as bool? ?? false,
      externalProductType: $enumDecodeNullable(
        _$ExternalProductTypeEnumMap,
        json['externalProductType'],
      ),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'instanceId': instance.instanceId,
      'name': instance.name,
      'nickname': instance.nickname,
      'brand': instance.brand,
      'barcode': instance.barcode,
      'imageUrl': instance.imageUrl,
      'brandLogoUrl': instance.brandLogoUrl,
      'code': instance.code,
      'qrCode': instance.qrCode,
      'qrCodes': instance.qrCodes,
      'shareLink': instance.shareLink,
      'description': instance.description,
      'isOwner': instance.isOwner,
      'externalProductType':
          _$ExternalProductTypeEnumMap[instance.externalProductType],
      'tags': instance.tags,
    };

const _$ExternalProductTypeEnumMap = {
  ExternalProductType.barcodeLookup: 'barcodeLookup',
  ExternalProductType.upcItemDbLookup: 'upcItemDbLookup',
  ExternalProductType.notFoundProduct: 'notFoundProduct',
};
