import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/app_data.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/ting_checkbox.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';

class SettingsPage extends HookWidget {
  SettingsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appRepository = locator<AppRepository>();
    final userRepository = locator<UserRepository>();
    final navigationService = locator<NavigationService>();
    final appData = useState<AppDataModel?>(null);
    final userData = useState<UserDataResult?>(null);
    final userProfileStore = locator<UserProfileStore>();
    final postalCodeController = useTextEditingController();

    useEffect(() {
      Future.microtask(
        () async => appData.value = await appRepository.getData(),
      );
      Future.microtask(
        () async => userData.value = await userRepository.getProfileData(),
      );
      return null;
    }, []);

    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: tr('profile.settings')),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child:
              appData.value == null
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TingsDropdownButtonFormField<String>(
                          label: tr('profile.language'),
                          value: userData.value?.languageCode,
                          items:
                              appData.value!.languages
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e.code,
                                      child: ContentBig(e.displayName),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (String? language) async {
                            if (language.isNotBlank) {
                              userData.value?.languageCode = language!;
                              context.setLocale(Locale(language!));
                              await userRepository.updateProfileData(
                                languageCode: language,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TingsDropdownButtonFormField<String>(
                          label: tr('profile.country'),
                          value: userData.value?.countryCode,
                          items:
                              appData.value?.countries
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e.code,
                                      child: ContentBig(e.displayName),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (String? country) async {
                            if (country.isNotBlank) {
                              userData.value?.countryCode = country!;
                              await userRepository.updateProfileData(
                                countryCode: country,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TingsTextField(
                          controller: postalCodeController,
                          label: tr('profile.postal_code'),
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 24),
                        TingCheckbox(
                          label: tr('profile.allow_feedback'),
                          checked: false,
                          onChange: (checked) {},
                        ),
                        const SizedBox(height: 24),
                        TingCheckbox(
                          label: tr('profile.consent_marketing'),
                          checked: false,
                          onChange: (checked) {},
                        ),
                        const SizedBox(height: 34),
                        const Spacer(),
                        MainButton(
                          onTap: () => navigationService.pop(),
                          text: tr('common.done'),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
