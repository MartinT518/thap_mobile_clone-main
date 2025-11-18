// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
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
      qrCodes: (json['qrCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shareLink: json['shareLink'] as String?,
      description: json['description'] as String?,
      isOwner: json['isOwner'] as bool,
      externalProductType: $enumDecodeNullable(
          _$ExternalProductTypeEnumMap, json['externalProductType']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

const _$ExternalProductTypeEnumMap = {
  ExternalProductType.barcodeLookup: 0,
  ExternalProductType.upcItemDbLookup: 1,
  ExternalProductType.notFoundProduct: 2,
};
