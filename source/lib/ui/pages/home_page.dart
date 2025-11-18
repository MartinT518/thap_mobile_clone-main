import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/navigation_bar_item.dart';
import 'package:thap/ui/pages/feed_page.dart';
import 'package:thap/ui/pages/menu_page.dart';
import 'package:thap/ui/pages/my_tings/my_tings_page.dart';
import 'package:thap/ui/pages/scan/scan_page.dart';
import 'package:thap/ui/pages/search_page.dart';

class HomePage extends HookWidget {
  HomePage({super.key});

  final pages = [
    const MyTingsPage(),
    const SearchPage(),
    const ScanPage(),
    const FeedPage(),
    const MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    final pageIndex = useState(0);

    return Builder(
      builder: (context) {
        return WillPopScope(
          // Handle back button on root route
          onWillPop: () async {
            // If current page is  not first then navigate there
            if (pageIndex.value != 0) {
              pageIndex.value = 0;
              return false;
            }
            return true;
          },
          child: Scaffold(
            appBar: AppHeaderBar(
              rightWidget:
                  pageIndex.value == 0 ? const MyTingsMoreMenu() : null,
            ),
            body: LazyLoadIndexedStack(index: pageIndex.value, children: pages),
            backgroundColor: TingsColors.grayLight,
            bottomNavigationBar: SafeArea(
              bottom: true,
              child: Container(
                color: TingsColors.grayLight,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigationBarItem(
                      label: tr('my_tings.title'),
                      iconName: 'general_home',
                      onTap: () {
                        pageIndex.value = 0;
                      },
                      pageIndex: 0,
                      currentPageIndex: pageIndex.value,
                    ),
                    NavigationBarItem(
                      label: tr('search.title'),
                      iconName: 'general_search-search',
                      onTap: () {
                        pageIndex.value = 1;
                      },
                      pageIndex: 1,
                      currentPageIndex: pageIndex.value,
                    ),
                    NavigationBarItem(
                      label: tr('scan.title'),
                      iconName: 'general_qr-code-scan',
                      isElevated: true,
                      onTap: () {
                        navigationService.push(const ScanPage());
                      },
                      pageIndex: 2,
                      currentPageIndex: pageIndex.value,
                    ),
                    NavigationBarItem(
                      label: tr('feed.title'),
                      iconName: 'general_messages-multiple',
                      onTap: () {
                        pageIndex.value = 3;
                      },
                      pageIndex: 3,
                      currentPageIndex: pageIndex.value,
                    ),
                    NavigationBarItem(
                      label: tr('menu.title'),
                      iconName: 'general_menu-burger',
                      onTap: () {
                        pageIndex.value = 4;
                      },
                      pageIndex: 4,
                      currentPageIndex: pageIndex.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
