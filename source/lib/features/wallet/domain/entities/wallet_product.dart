import 'package:thap/features/products/domain/entities/product.dart';

/// Wallet product entity - represents a product instance owned by the user
class WalletProduct {
  final String instanceId;
  final Product product;
  final DateTime? dateAdded;
  final String? nickname;
  final List<String> tags;

  const WalletProduct({
    required this.instanceId,
    required this.product,
    this.dateAdded,
    this.nickname,
    this.tags = const [],
  });

  /// Display name (nickname if available, otherwise product display name)
  String get displayName {
    return nickname?.isNotEmpty == true ? nickname! : product.displayName;
  }

  WalletProduct copyWith({
    String? instanceId,
    Product? product,
    DateTime? dateAdded,
    String? nickname,
    List<String>? tags,
  }) {
    return WalletProduct(
      instanceId: instanceId ?? this.instanceId,
      product: product ?? this.product,
      dateAdded: dateAdded ?? this.dateAdded,
      nickname: nickname ?? this.nickname,
      tags: tags ?? this.tags,
    );
  }
}

