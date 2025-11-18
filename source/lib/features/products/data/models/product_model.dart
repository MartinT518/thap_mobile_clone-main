import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thap/features/products/domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// Product model (data layer) - extends domain entity
@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    String? instanceId,
    required String name,
    String? nickname,
    required String brand,
    String? barcode,
    String? imageUrl,
    String? brandLogoUrl,
    String? code,
    String? qrCode,
    @Default([]) List<String> qrCodes,
    String? shareLink,
    String? description,
    @Default(false) bool isOwner,
    ExternalProductType? externalProductType,
    @Default([]) List<String> tags,
  }) = _ProductModel;

  const ProductModel._();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Convert to domain entity
  Product toEntity() {
    return Product(
      id: id,
      instanceId: instanceId,
      name: name,
      nickname: nickname,
      brand: brand,
      barcode: barcode,
      imageUrl: imageUrl,
      brandLogoUrl: brandLogoUrl,
      code: code,
      qrCode: qrCode,
      qrCodes: qrCodes,
      shareLink: shareLink,
      description: description,
      isOwner: isOwner,
      externalProductType: externalProductType,
      tags: tags,
    );
  }

  /// Create from domain entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      instanceId: product.instanceId,
      name: product.name,
      nickname: product.nickname,
      brand: product.brand,
      barcode: product.barcode,
      imageUrl: product.imageUrl,
      brandLogoUrl: product.brandLogoUrl,
      code: product.code,
      qrCode: product.qrCode,
      qrCodes: product.qrCodes,
      shareLink: product.shareLink,
      description: product.description,
      isOwner: product.isOwner,
      externalProductType: product.externalProductType,
      tags: product.tags,
    );
  }
}

