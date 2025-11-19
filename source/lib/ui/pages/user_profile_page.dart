import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/models/app_data.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/login/login_page.dart';

class UserProfilePage extends HookWidget {
  UserProfilePage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appRepository = locator<AppRepository>();
    final userRepository = locator<UserRepository>();
    final navigationService = locator<NavigationService>();
    final appData = useState<AppDataModel?>(null);
    final userData = useState<UserDataResult?>(null);
    final userProfileStore = locator<UserProfileStore>();
    final nameController = useTextEditingController(
      text: userProfileStore.userProfile?.name,
    );
    final emailController = useTextEditingController(
      text: userProfileStore.userProfile?.email,
    );
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
      appBar: AppHeaderBar(
        showBackButton: true,
        title: tr('profile.title'),
        rightWidget: TingsKebabMenu<String>(
          items: [
            TingsPopupMenuItem(
              value: 'delete',
              name: tr('profile.delete_all_data'),
            ),
          ],
          onItemSelected: (value) async {
            if (value == 'delete') {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Heading2(tr('common.delete')),
                    content: ContentBig(
                      tr('profile.delete_all_data_confirmation'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await userRepository.deleteAllData();
                          await locator<AuthService>().signOut();
                          navigationService.replaceAll(const LoginPage());

                          locator<ToastService>().success(
                            tr('profile.delete_all_data_message'),
                          );
                        },
                        child: Heading3(tr('common.proceed')),
                      ),
                      TextButton(
                        onPressed: () => navigationService.pop(false),
                        child: ContentBig(tr('common.cancel')),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
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
                        TingsTextField(
                          controller: nameController,
                          label: tr('profile.name'),
                        ),
                        const SizedBox(height: 24),
                        TingsTextField(
                          controller: emailController,
                          label: tr('profile.email'),
                          textInputType: TextInputType.emailAddress,
                          rightIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Material(
                              color: TingsColors.grayLight,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TingsColors.grayMedium,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    widthFactor: 1,
                                    child: Heading4(tr('profile.verify_email')),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
