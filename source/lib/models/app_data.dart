import 'package:json_annotation/json_annotation.dart';

part 'app_data.g.dart';

@JsonSerializable()
class AppDataModel {
  final List<CountryModel> countries;
  final List<LanguageModel> languages;

  AppDataModel({required this.countries, required this.languages});

  factory AppDataModel.fromJson(Map<String, dynamic> json) =>
      _$AppDataModelFromJson(json);
}

@JsonSerializable()
class CountryModel {
  final String code;
  final String displayName;

  CountryModel({required this.code, required this.displayName});

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
}

@JsonSerializable()
class LanguageModel {
  final String code;
  final String displayName;

  LanguageModel({required this.code, required this.displayName});

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
}
