// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFormModel _$ProductFormModelFromJson(
  Map<String, dynamic> json,
) => ProductFormModel(
  title: json['title'] as String,
  description: json['description'] as String?,
  fields:
      (json['formFields'] as List<dynamic>)
          .map((e) => ProductFormFieldModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductFormModelToJson(ProductFormModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'formFields': instance.fields,
    };

ProductFormFieldModel _$ProductFormFieldModelFromJson(
  Map<String, dynamic> json,
) => ProductFormFieldModel(
  label: json['label'] as String,
  dataType: $enumDecode(_$ProductFormFieldTypeEnumMap, json['dataType']),
  required: boolFromString(json['required'] as String?),
  prefilledValue: json['prefilledValue'] as String?,
);

Map<String, dynamic> _$ProductFormFieldModelToJson(
  ProductFormFieldModel instance,
) => <String, dynamic>{
  'label': instance.label,
  'prefilledValue': instance.prefilledValue,
  'dataType': _$ProductFormFieldTypeEnumMap[instance.dataType]!,
  'required': instance.required,
};

const _$ProductFormFieldTypeEnumMap = {
  ProductFormFieldType.text: 'text',
  ProductFormFieldType.email: 'email',
  ProductFormFieldType.date: 'date',
  ProductFormFieldType.textarea: 'textarea',
  ProductFormFieldType.numeric: 'numeric',
  ProductFormFieldType.country: 'country',
};

ProductRegistrationData _$ProductRegistrationDataFromJson(
  Map<String, dynamic> json,
) => ProductRegistrationData(
  registrationData:
      (json['registrationData'] as List<dynamic>)
          .map((e) => KeyValueData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductRegistrationDataToJson(
  ProductRegistrationData instance,
) => <String, dynamic>{
  'registrationData': instance.registrationData.map((e) => e.toJson()).toList(),
};

KeyValueData _$KeyValueDataFromJson(Map<String, dynamic> json) =>
    KeyValueData(key: json['key'] as String, value: json['value'] as String?);

Map<String, dynamic> _$KeyValueDataToJson(KeyValueData instance) =>
    <String, dynamic>{'key': instance.key, 'value': instance.value};
