// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  String get id => throw _privateConstructorUsedError;
  String? get instanceId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get brandLogoUrl => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;
  List<String> get qrCodes => throw _privateConstructorUsedError;
  String? get shareLink => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isOwner => throw _privateConstructorUsedError;
  ExternalProductType? get externalProductType =>
      throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
    ProductModel value,
    $Res Function(ProductModel) then,
  ) = _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call({
    String id,
    String? instanceId,
    String name,
    String? nickname,
    String brand,
    String? barcode,
    String? imageUrl,
    String? brandLogoUrl,
    String? code,
    String? qrCode,
    List<String> qrCodes,
    String? shareLink,
    String? description,
    bool isOwner,
    ExternalProductType? externalProductType,
    List<String> tags,
  });
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? instanceId = freezed,
    Object? name = null,
    Object? nickname = freezed,
    Object? brand = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? brandLogoUrl = freezed,
    Object? code = freezed,
    Object? qrCode = freezed,
    Object? qrCodes = null,
    Object? shareLink = freezed,
    Object? description = freezed,
    Object? isOwner = null,
    Object? externalProductType = freezed,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            instanceId: freezed == instanceId
                ? _value.instanceId
                : instanceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String,
            barcode: freezed == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandLogoUrl: freezed == brandLogoUrl
                ? _value.brandLogoUrl
                : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            qrCode: freezed == qrCode
                ? _value.qrCode
                : qrCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            qrCodes: null == qrCodes
                ? _value.qrCodes
                : qrCodes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            shareLink: freezed == shareLink
                ? _value.shareLink
                : shareLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOwner: null == isOwner
                ? _value.isOwner
                : isOwner // ignore: cast_nullable_to_non_nullable
                      as bool,
            externalProductType: freezed == externalProductType
                ? _value.externalProductType
                : externalProductType // ignore: cast_nullable_to_non_nullable
                      as ExternalProductType?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
    _$ProductModelImpl value,
    $Res Function(_$ProductModelImpl) then,
  ) = __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? instanceId,
    String name,
    String? nickname,
    String brand,
    String? barcode,
    String? imageUrl,
    String? brandLogoUrl,
    String? code,
    String? qrCode,
    List<String> qrCodes,
    String? shareLink,
    String? description,
    bool isOwner,
    ExternalProductType? externalProductType,
    List<String> tags,
  });
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
    _$ProductModelImpl _value,
    $Res Function(_$ProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? instanceId = freezed,
    Object? name = null,
    Object? nickname = freezed,
    Object? brand = null,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? brandLogoUrl = freezed,
    Object? code = freezed,
    Object? qrCode = freezed,
    Object? qrCodes = null,
    Object? shareLink = freezed,
    Object? description = freezed,
    Object? isOwner = null,
    Object? externalProductType = freezed,
    Object? tags = null,
  }) {
    return _then(
      _$ProductModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        instanceId: freezed == instanceId
            ? _value.instanceId
            : instanceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String,
        barcode: freezed == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandLogoUrl: freezed == brandLogoUrl
            ? _value.brandLogoUrl
            : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        qrCode: freezed == qrCode
            ? _value.qrCode
            : qrCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        qrCodes: null == qrCodes
            ? _value._qrCodes
            : qrCodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        shareLink: freezed == shareLink
            ? _value.shareLink
            : shareLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOwner: null == isOwner
            ? _value.isOwner
            : isOwner // ignore: cast_nullable_to_non_nullable
                  as bool,
        externalProductType: freezed == externalProductType
            ? _value.externalProductType
            : externalProductType // ignore: cast_nullable_to_non_nullable
                  as ExternalProductType?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl({
    required this.id,
    this.instanceId,
    required this.name,
    this.nickname,
    required this.brand,
    this.barcode,
    this.imageUrl,
    this.brandLogoUrl,
    this.code,
    this.qrCode,
    final List<String> qrCodes = const [],
    this.shareLink,
    this.description,
    this.isOwner = false,
    this.externalProductType,
    final List<String> tags = const [],
  }) : _qrCodes = qrCodes,
       _tags = tags,
       super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? instanceId;
  @override
  final String name;
  @override
  final String? nickname;
  @override
  final String brand;
  @override
  final String? barcode;
  @override
  final String? imageUrl;
  @override
  final String? brandLogoUrl;
  @override
  final String? code;
  @override
  final String? qrCode;
  final List<String> _qrCodes;
  @override
  @JsonKey()
  List<String> get qrCodes {
    if (_qrCodes is EqualUnmodifiableListView) return _qrCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qrCodes);
  }

  @override
  final String? shareLink;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isOwner;
  @override
  final ExternalProductType? externalProductType;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, instanceId: $instanceId, name: $name, nickname: $nickname, brand: $brand, barcode: $barcode, imageUrl: $imageUrl, brandLogoUrl: $brandLogoUrl, code: $code, qrCode: $qrCode, qrCodes: $qrCodes, shareLink: $shareLink, description: $description, isOwner: $isOwner, externalProductType: $externalProductType, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.instanceId, instanceId) ||
                other.instanceId == instanceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.brandLogoUrl, brandLogoUrl) ||
                other.brandLogoUrl == brandLogoUrl) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            const DeepCollectionEquality().equals(other._qrCodes, _qrCodes) &&
            (identical(other.shareLink, shareLink) ||
                other.shareLink == shareLink) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner) &&
            (identical(other.externalProductType, externalProductType) ||
                other.externalProductType == externalProductType) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    instanceId,
    name,
    nickname,
    brand,
    barcode,
    imageUrl,
    brandLogoUrl,
    code,
    qrCode,
    const DeepCollectionEquality().hash(_qrCodes),
    shareLink,
    description,
    isOwner,
    externalProductType,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(this);
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel({
    required final String id,
    final String? instanceId,
    required final String name,
    final String? nickname,
    required final String brand,
    final String? barcode,
    final String? imageUrl,
    final String? brandLogoUrl,
    final String? code,
    final String? qrCode,
    final List<String> qrCodes,
    final String? shareLink,
    final String? description,
    final bool isOwner,
    final ExternalProductType? externalProductType,
    final List<String> tags,
  }) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get instanceId;
  @override
  String get name;
  @override
  String? get nickname;
  @override
  String get brand;
  @override
  String? get barcode;
  @override
  String? get imageUrl;
  @override
  String? get brandLogoUrl;
  @override
  String? get code;
  @override
  String? get qrCode;
  @override
  List<String> get qrCodes;
  @override
  String? get shareLink;
  @override
  String? get description;
  @override
  bool get isOwner;
  @override
  ExternalProductType? get externalProductType;
  @override
  List<String> get tags;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
