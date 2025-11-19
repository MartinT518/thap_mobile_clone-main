import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/scan_history/presentation/providers/scan_history_state_provider.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/scan_history_list_item.dart';
import 'package:thap/ui/pages/my_tings/scan_history_page.dart';

class ScanHistoryListSection extends ConsumerWidget {
  const ScanHistoryListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanHistoryState = ref.watch(scanHistoryStoreProvider);
    final navigationService = locator<NavigationService>();

    return scanHistoryState.hasAny
            ? Container(
              margin: const EdgeInsets.only(top: 18, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading3(tr('scan.history')),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              navigationService.push(ScanHistoryPage());
                            },
                            child: ContentBig(tr('common.show_all')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 141,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 8),
                        padding: const EdgeInsets.only(
                          top: 15,
                          right: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            scanHistoryState.scanHistory.length +
                            1, // One more for swipe up delete hint element
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          // Swipe up delete hint element
                          if (index ==
                              scanHistoryState.scanHistory.length) {
                            return _buildSwipeUpdDeleteHint();
                          }

                          final product =
                              scanHistoryState.scanHistory[index];
                          return ScanHistoryListItem(product: product as dynamic);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
            : Container();
  }

  Container _buildSwipeUpdDeleteHint() {
    return Container(
      height: 141,
      width: 129,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      decoration: BoxDecoration(
        color: TingsColors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TingIcon('arrow_double-chevron-up', height: 28),
          const SizedBox(height: 12),
          ContentSmall(
            tr('scan.history_delete_hint'),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
