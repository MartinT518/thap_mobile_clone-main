import 'package:json_annotation/json_annotation.dart';
import 'package:thap/utilities/utilities.dart';

part 'product_form.g.dart';

@JsonSerializable()
class ProductFormModel {
  final String title;
  final String? description;
  @JsonKey(name: 'formFields')
  final List<ProductFormFieldModel> fields;

  ProductFormModel(
      {required this.title, required this.description, required this.fields});

  factory ProductFormModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFormModelToJson(this);
}

@JsonSerializable()
class ProductFormFieldModel {
  final String label;
  final String? prefilledValue;
  final ProductFormFieldType dataType;
  @JsonKey(fromJson: boolFromString)
  final bool required;

  ProductFormFieldModel(
      {required this.label,
      required this.dataType,
      required this.required,
      this.prefilledValue});

  factory ProductFormFieldModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFormFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFormFieldModelToJson(this);
}

enum ProductFormFieldType { text, email, date, textarea, numeric, country }

@JsonSerializable(explicitToJson: true)
class ProductRegistrationData {
  final List<KeyValueData> registrationData;

  ProductRegistrationData({required this.registrationData});

  factory ProductRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$ProductRegistrationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRegistrationDataToJson(this);
}

@JsonSerializable()
class KeyValueData {
  final String key;
  final String? value;

  KeyValueData({required this.key, this.value});

  factory KeyValueData.fromJson(Map<String, dynamic> json) =>
      _$KeyValueDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueDataToJson(this);
}
