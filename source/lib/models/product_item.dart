import 'package:json_annotation/json_annotation.dart';
import 'package:thap/extensions/string_extensions.dart';

part 'product_item.g.dart';

@JsonSerializable(createToJson: false)
class ProductItem {
  final String id;
  final String? instanceId;
  final String name;
  final String? nickname;
  final String brand;
  final String? barcode;
  final String? imageUrl;
  final String? brandLogoUrl;
  final String? code;
  final String? qrCode;
  final List<String> qrCodes;
  final String? shareLink;
  final String? description;
  final bool isOwner;
  final ExternalProductType? externalProductType;
  final List<String> tags;

  String get displayName {
    return nickname.isNotBlank ? nickname! : name;
  }

  ProductItem(
      {required this.id,
      this.instanceId,
      required this.name,
      this.nickname,
      required this.brand,
      this.barcode,
      this.imageUrl,
      this.brandLogoUrl,
      this.code,
      this.qrCode,
      this.qrCodes = const [],
      this.shareLink,
      this.description,
      required this.isOwner,
      this.externalProductType,
      this.tags = const []});

  ProductItem copyWith({
    String? id,
    String? instanceId,
    String? name,
    String? nickname,
    String? brand,
    String? barcode,
    String? imageUrl,
    String? brandLogoUrl,
    String? code,
    String? qrCode,
    List<String>? qrCodes,
    String? shareLink,
    String? description,
    bool? isOwner,
    ExternalProductType? externalProductType,
    List<String>? tags,
  }) {
    return ProductItem(
      id: id ?? this.id,
      instanceId: instanceId ?? this.instanceId,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      imageUrl: imageUrl ?? this.imageUrl,
      brandLogoUrl: brandLogoUrl ?? this.brandLogoUrl,
      code: code ?? this.code,
      qrCode: qrCode ?? this.qrCode,
      qrCodes: qrCodes ?? this.qrCodes,
      shareLink: shareLink ?? this.shareLink,
      description: description ?? this.description,
      isOwner: isOwner ?? this.isOwner,
      externalProductType: externalProductType ?? this.externalProductType,
      tags: tags ?? this.tags,
    );
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
}

enum ExternalProductType {
  @JsonValue(0)
  barcodeLookup,
  @JsonValue(1)
  upcItemDbLookup,
  @JsonValue(2)
  notFoundProduct
}
