// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      token: json['token'] as String?,
      authMethod:
          $enumDecodeNullable(_$AuthMethodEnumMap, json['authMethod']) ??
          AuthMethod.google,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'token': instance.token,
      'authMethod': _$AuthMethodEnumMap[instance.authMethod]!,
    };

const _$AuthMethodEnumMap = {
  AuthMethod.google: 'google',
  AuthMethod.facebook: 'facebook',
};
