import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/app_data.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/ting_checkbox.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/ai_settings_page.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/features/auth/presentation/pages/login_page.dart';

class SettingsPage extends HookWidget {
  SettingsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    final appData = useState<AppDataModel?>(null);
    final userData = useState<UserDataResult?>(null);
    final userProfileStore = locator<UserProfileStore>();
    final postalCodeController = useTextEditingController();

    useEffect(() {
      Future.microtask(() async {
        final appRepo = locator<AppRepository>();
        final userRepo = locator<UserRepository>();
        appData.value = await appRepo.getData();
        userData.value = await userRepo.getProfileData();
      });
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
                              (appData.value?.languages ?? [])
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
                              await locator<UserRepository>().updateProfileData(languageCode: language);
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
                              await locator<UserRepository>().updateProfileData(countryCode: country);
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
                          checked: userData.value?.allowFeedback ?? false,
                          onChange: (checked) async {
                            userData.value?.allowFeedback = checked;
                            try {
                              await locator<UserRepository>().updateProfileData(
                                countryCode: userData.value?.countryCode,
                                languageCode: userData.value?.languageCode,
                                allowFeedback: checked,
                              );
                            } catch (e) {
                              // Revert on error
                              userData.value?.allowFeedback = !checked;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update: $e')),
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TingCheckbox(
                          label: tr('profile.consent_marketing'),
                          checked: userData.value?.consentMarketing ?? false,
                          onChange: (checked) async {
                            userData.value?.consentMarketing = checked;
                            try {
                              await locator<UserRepository>().updateProfileData(
                                countryCode: userData.value?.countryCode,
                                languageCode: userData.value?.languageCode,
                                consentMarketing: checked,
                              );
                            } catch (e) {
                              // Revert on error
                              userData.value?.consentMarketing = !checked;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update: $e')),
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(tr('profile.delete_account_title')),
                                content: Text(tr('profile.delete_account_message')),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text(tr('common.cancel')),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: Text(tr('common.delete'), style: const TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true) {
                              try {
                                final success = await locator<UserRepository>().deleteAllData();
                                if (success && context.mounted) {
                                  await locator<AuthService>().signOut();
                                  navigationService.replaceAll(const LoginPage());
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to delete account: $e')),
                                  );
                                }
                              }
                            }
                          },
                          style: DesignSystemComponents.primaryButton(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(tr('profile.delete_account')),
                        ),
                        const SizedBox(height: 24),
                        ProductMenuItem(
                          title: 'AI Assistant Settings',
                          iconName: 'general_settings',
                          onTap: () {
                            navigationService.push(const AISettingsPage());
                          },
                        ),
                        const SizedBox(height: 34),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => navigationService.pop(),
                          style: DesignSystemComponents.primaryButton(),
                          child: Text(tr('common.done')),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
