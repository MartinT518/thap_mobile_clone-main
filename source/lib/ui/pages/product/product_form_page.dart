import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/app_data.dart';
import 'package:thap/models/product_form.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/utilities/utilities.dart';

class ProductFormPage extends HookWidget {
  ProductFormPage({
    super.key,
    required this.productInstanceId,
    required this.formModel,
  });

  final String productInstanceId;
  final ProductFormModel formModel;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final toastService = locator<ToastService>();
    final appRepository = locator<AppRepository>();
    final myTingsRepository = locator<MyTingsRepository>();
    final navigationService = locator<NavigationService>();

    final countries = useState<List<CountryModel>>([]);

    useEffect(() {
      Future.microtask(
        () async => countries.value = (await appRepository.getData()).countries,
      );
      return null;
    }, []);

    final initialValues = {
      for (var item in formModel.fields.where(
        (element) => element.prefilledValue.isNotBlank,
      ))
        item.label: _getPrefilledValue(item),
    };

    final formFields = <Widget>[];

    for (var field in formModel.fields) {
      final focusNode = FocusNode();
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          _formKey.currentState?.fields[field.label]?.validate();
        }
      });

      final validators = FormBuilderValidators.compose([
        if (field.required)
          FormBuilderValidators.required(
            errorText: tr('product.registration.required'),
          ),
        if (field.dataType == ProductFormFieldType.email)
          FormBuilderValidators.email(
            errorText: tr('product.registration.email_not_valid'),
          ),
      ]);
      final fieldLabel = apiTranslate(field.label);
      switch (field.dataType) {
        case ProductFormFieldType.email:
        case ProductFormFieldType.text:
        case ProductFormFieldType.textarea:
          formFields.add(
            FormBuilderTextField(
              textCapitalization:
                  field.dataType != ProductFormFieldType.email
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
              focusNode: focusNode,
              name: fieldLabel,
              keyboardType:
                  field.dataType == ProductFormFieldType.email
                      ? TextInputType.emailAddress
                      : null,
              maxLines: field.dataType == ProductFormFieldType.textarea ? 4 : 1,
              style: const TextStyle(color: TingsColors.black, fontSize: 14),
              decoration: getTingsFieldDecoration(fieldLabel),
              validator: validators,
            ),
          );
          break;

        case ProductFormFieldType.date:
          formFields.add(
            FormBuilderDateTimePicker(
              name: fieldLabel,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              inputType: InputType.date,
              format: DateFormat('dd.MM.yyyy'),
              style: const TextStyle(color: TingsColors.black, fontSize: 14),
              decoration: getTingsFieldDecoration(fieldLabel),
            ),
          );
          break;
        case ProductFormFieldType.numeric:
          // TODO: Handle this case.
          break;
        case ProductFormFieldType.country:
          if (countries.value.isNotEmpty) {
            formFields.add(
              FormBuilderDropdown(
                name: fieldLabel,
                decoration: getTingsFieldDecoration(fieldLabel),
                borderRadius: BorderRadius.circular(8),
                dropdownColor: TingsColors.white,
                items:
                    countries.value
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.code,
                            child: ContentBig(e.displayName),
                          ),
                        )
                        .toList(),
              ),
            );
          }

          break;
      }
    }

    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: formModel.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: TingsColors.white,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
            top: 16,
          ),
          child: FormBuilder(
            initialValue: initialValues,
            key: _formKey,
            child: Column(
              children: [
                if (formModel.description?.isNotEmpty ?? false)
                  Center(child: ContentBig(formModel.description!)),
                const SizedBox(height: 34),
                ...formFields.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: e,
                  ),
                ),
                const SizedBox(height: 28),
                MainButton(
                  onTap: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      List<KeyValueData> registrationData = [];

                      _formKey.currentState!.value.forEach((key, value) {
                        registrationData.add(
                          KeyValueData(key: key, value: value.toString()),
                        );
                      });

                      final formData = ProductRegistrationData(
                        registrationData: registrationData,
                      );

                      await myTingsRepository.register(
                        productInstanceId,
                        formData.toJson(),
                      );

                      toastService.success(
                        tr('product.registration.registered_message'),
                      );

                      navigationService.pop();
                    }
                  },
                  text: tr('common.save'),
                ),
                const SizedBox(height: 8),
                LightButton(
                  onTap: () {
                    navigationService.pop();
                  },
                  text: tr('common.cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getPrefilledValue(ProductFormFieldModel field) {
    final userProfileStore = locator<UserProfileStore>();

    if (field.prefilledValue == 'fullName') {
      return userProfileStore.userProfile?.name;
    }
    if (field.prefilledValue == 'email') {
      return userProfileStore.userProfile?.email;
    }
    return null;
  }
}
