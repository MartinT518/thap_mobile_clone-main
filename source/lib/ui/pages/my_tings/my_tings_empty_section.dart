import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/scan/scan_page.dart';

class MyTingsEmptySection extends StatelessWidget {
  const MyTingsEmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    final userProfileStore = locator<UserProfileStore>();

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: SvgPicture.asset('assets/unbox.svg')),
                Center(
                  child: Heading4(
                    tr(
                      'my_tings.greeting',
                      namedArgs: {
                        'userName': userProfileStore.userProfile?.name ?? '',
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(child: Heading3(tr('my_tings.no_tings_message'))),
                const SizedBox(height: 7),
                Center(child: ContentSmall(tr('my_tings.scan_message'))),
                const SizedBox(height: 9),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: MainButton(
              onTap: () {
                navigationService.push(const ScanPage());
              },
              text: tr('my_tings.scan_button'),
            ),
          ),
        ],
      ),
    );
  }
}
