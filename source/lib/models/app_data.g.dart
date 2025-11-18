// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDataModel _$AppDataModelFromJson(Map<String, dynamic> json) => AppDataModel(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppDataModelToJson(AppDataModel instance) =>
    <String, dynamic>{
      'countries': instance.countries,
      'languages': instance.languages,
    };

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
    };

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'displayName': instance.displayName,
    };
