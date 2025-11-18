import 'package:country_code/country_code.dart';
import 'package:device_region/device_region.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/ting_checkbox.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/common/user_info.dart';
import 'package:thap/ui/pages/home_page.dart';
import 'package:thap/ui/pages/login/terms_policy_message.dart';

class RegisterPage extends HookWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProfileStore = locator<UserProfileStore>();
    final navigationService = locator<NavigationService>();
    final appRepository = locator<AppRepository>();
    final authService = locator<AuthService>();
    final toastService = locator<ToastService>();

    final currentLocaleFuture = useMemoized(() => Devicelocale.currentLocale);
    final currentCountryCodeFuture = useMemoized(
      () => DeviceRegion.getSIMCountryCode(),
    );
    final appDataFuture = useMemoized(() => appRepository.getData());
    final currentLocaleSnapshot = useFuture(currentLocaleFuture);
    final currentCountryCodeSnapshot = useFuture(currentCountryCodeFuture);
    final appDataSnapshot = useFuture(appDataFuture);

    final selectedUserCountry = useState<String?>(null);
    final selectedUserLanguage = useState<String?>(null);
    final termsAccepted = useState(false);

    // Try to preselect current country
    useEffect(() {
      if (currentCountryCodeSnapshot.hasData && appDataSnapshot.hasData) {
        final code = CountryCode.tryParse(
          currentCountryCodeSnapshot.data!.toUpperCase(),
        );

        if (code != null) {
          final countrySupported =
              appDataSnapshot.data?.countries.any(
                (c) => c.code == code.alpha3,
              ) ??
              false;
          if (countrySupported) {
            selectedUserCountry.value = code.alpha3;
          }
        }
      }
      return null;
    }, [currentCountryCodeSnapshot, appDataSnapshot]);

    // Try to preselect current language
    useEffect(() {
      if (currentLocaleSnapshot.hasData && appDataSnapshot.hasData) {
        final language = currentLocaleSnapshot.data?.split('-').first;

        if (language.isNotBlank) {
          final languageSupported =
              appDataSnapshot.data?.languages.any((c) => c.code == language) ??
              false;
          if (languageSupported) {
            selectedUserLanguage.value = language;
          } else {
            selectedUserLanguage.value = 'en';
          }
        }
      }
      return null;
    }, [currentLocaleSnapshot, appDataSnapshot]);

    if (selectedUserLanguage.value != null) {
      print(selectedUserLanguage.value);
      context.setLocale(Locale(selectedUserLanguage.value!));
    }

    return WillPopScope(
      onWillPop: () async {
        await authService.signOut();

        return true;
      },
      child: Scaffold(
        appBar: const AppHeaderBar(showBackButton: true),
        body: SafeArea(
          bottom: true,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                UserInfo(
                  name: userProfileStore.userProfile!.name,
                  email: userProfileStore.userProfile!.email,
                  photoUrl: userProfileStore.userProfile!.photoUrl,
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TingsDropdownButtonFormField<String>(
                        label: tr('profile.country'),
                        validator: (value) {
                          if (value.isBlank) {
                            return tr('register.country_validation');
                          }
                          return null;
                        },
                        value: selectedUserCountry.value,
                        items:
                            appDataSnapshot.data?.countries
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.code,
                                    child: ContentBig(e.displayName),
                                  ),
                                )
                                .toList(),
                        onChanged: (String? countryCode) {
                          selectedUserCountry.value = countryCode;
                        },
                      ),
                      const SizedBox(height: 24),
                      TingsDropdownButtonFormField<String>(
                        validator: (value) {
                          if (value.isBlank) {
                            return tr('register.language_validation');
                          }
                          return null;
                        },
                        label: tr('profile.language'),
                        value: selectedUserLanguage.value,
                        items:
                            appDataSnapshot.data?.languages
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.code,
                                    child: ContentBig(e.displayName),
                                  ),
                                )
                                .toList(),
                        onChanged: (String? languageCode) {
                          if (languageCode.isNotBlank) {
                            selectedUserLanguage.value = languageCode;
                          }
                        },
                      ),
                      const SizedBox(height: 29),
                      Row(
                        children: [
                          TingCheckbox(
                            onChange:
                                (checked) => termsAccepted.value = checked,
                          ),
                          const SizedBox(width: 10),
                          ContentBig('${tr('common.accept')} '),
                          TermsPolicyMessage(
                            language: selectedUserLanguage.value,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      MainButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (termsAccepted.value) {
                              final success = await authService.register(
                                selectedUserLanguage.value!,
                                selectedUserCountry.value!,
                              );
                              if (success) {
                                navigationService.replace(HomePage());
                              } else {
                                toastService.error(tr('register.error'));
                              }
                            } else {
                              toastService.error(tr('register.terms_error'));
                            }
                          }
                        },
                        text: tr('register.button'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
