import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/data_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/html_page.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/common/user_info.dart';
import 'package:thap/ui/pages/login/login_page.dart';
import 'package:thap/ui/pages/settings_page.dart';
import 'package:thap/ui/pages/user_profile_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileStore = locator<UserProfileStore>();
    final navigationService = locator<NavigationService>();

    return Container(
      color: TingsColors.grayLight,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserInfo(
              name: userProfileStore.userProfile!.name,
              email: userProfileStore.userProfile!.email,
              photoUrl: userProfileStore.userProfile!.photoUrl,
              backgroundColor: TingsColors.grayLight,
            ),
            ProductMenuItem(
              title: tr('profile.title'),
              iconName: 'general_person-people-profile-user',
              onTap: () {
                navigationService.push(UserProfilePage());
              },
            ),
            ProductMenuItem(
              title: tr('profile.settings'),
              iconName: 'general_settings',
              onTap: () {
                navigationService.push(SettingsPage());
              },
            ),
            ProductMenuItem(
              title: tr('menu.legal.title'),
              onTap: () async {
                await navigationService.push(const _LegalMenuPage());
              },
            ),
            ProductMenuItem(
              title: tr('menu.help'),
              onTap: () async {
                await navigationService.push(const _HelpMenuPage());
              },
            ),
            ProductMenuItem(
              title: tr('menu.sign_out'),
              onTap: () async {
                await locator<AuthService>().signOut();
                locator<NavigationService>().replaceAll(const LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalMenuPage extends StatelessWidget {
  const _LegalMenuPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: tr('menu.legal.title')),
      body: Container(
        color: TingsColors.grayLight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ProductMenuItem(
                title: tr('menu.legal.terms'),
                onTap:
                    () async => await _showContent(
                      context,
                      'terms',
                      tr('menu.legal.terms'),
                    ),
              ),
              ProductMenuItem(
                title: tr('menu.legal.privacy'),
                onTap:
                    () async => await _showContent(
                      context,
                      'policy',
                      tr('menu.legal.privacy'),
                    ),
              ),
              ProductMenuItem(
                title: tr('menu.legal.cookie'),
                onTap:
                    () async => await _showContent(
                      context,
                      'cookie',
                      tr('menu.legal.cookie'),
                    ),
              ),
              ProductMenuItem(
                title: tr('menu.legal.aup'),
                onTap:
                    () async => await _showContent(
                      context,
                      'aup',
                      tr('menu.legal.aup'),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpMenuPage extends StatelessWidget {
  const _HelpMenuPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: tr('menu.help')),
      body: Container(
        color: TingsColors.grayLight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ProductMenuItem(
                title: 'FAQ',
                onTap: () async => await _showContent(context, 'help', 'FAQ'),
              ),
              SizedBox(height: 600),
              Padding(
                padding: const EdgeInsets.all(44.0),
                child: ContentBig('For support please contact help@thap.io'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showContent(
  BuildContext context,
  String key,
  String title,
) async {
  final dataService = locator<DataService>();
  final navigationService = locator<NavigationService>();

  final locale = context.locale.toString().split('_').first;
  final content = await dataService.getContent(key, locale);

  if (content == null || content.isEmpty) return;

  await navigationService.push(HtmlPage(title: title, content: content));
}
