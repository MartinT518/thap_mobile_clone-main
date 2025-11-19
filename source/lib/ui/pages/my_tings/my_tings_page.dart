import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/features/my_tings/presentation/providers/my_tings_provider.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/my_tings_empty_section.dart';
import 'package:thap/ui/pages/my_tings/my_tings_list_section.dart';
import 'package:thap/ui/pages/my_tings/my_tings_tags_filter.dart';
import 'package:thap/ui/pages/my_tings/scan_history_list_section.dart';
import 'package:thap/ui/pages/user_tags_page.dart';

class MyTingsPage extends HookWidget {
  const MyTingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myTingsStore = locator<MyTingsStore>();
    final scanHistoryStore = locator<ScanHistoryStore>();
    final refreshing = useState(false);
    final tagsStore = locator<ProductTagsStore>();

    useEffect(() {
      Future.microtask(() async {
         await myTingsStore.load();
      });
      Future.microtask(() async => await scanHistoryStore.load());
      return null;
    }, []);

    return Stack(
      children: [
        const _MyTingsDataUpdater(),
        Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              onRefresh: () async {
                refreshing.value = true;
                await myTingsStore.load();
                await ref.read(myTingsProvider.notifier).load();
                await scanHistoryStore.load();
                refreshing.value = false;
              },
              child: Builder(
                builder: (_) {
                  // Get state from provider to determine visibility
                  final myTingsState = ref.watch(myTingsProvider);
                  
                  final isLoading = myTingsState.isLoading;
                  final hasAnyTings = myTingsState.hasAny;
                  // Legacy stores might still be used by other widgets
                  // final hasAnyTingsLegacy = myTingsStore.hasAny;
                  
                  final hasAnyScanHistory = false; // TODO: Connect to scan history provider
                  final filterTagId = myTingsState.filterTagId;
                  
                  if (isLoading && !refreshing.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
        
                  if (!hasAnyTings &&
                      !hasAnyScanHistory &&
                      filterTagId.isEmpty) {
                    return Container(
                      color: TingsColors.white,
                      padding: const EdgeInsets.only(top: 120, bottom: 16),
                      child: const MyTingsEmptySection(),
                    );
                  }
        
                  return Container(
                    color: TingsColors.grayLight,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ScanHistoryListSection(),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Heading3(tr('my_tings.title')),
                          ),
                          if (hasAnyTings ||
                              filterTagId.isNotEmpty) ...[
                            const MyTingsTagsFilter(),
                            const MyTingsListSection(),
        
                            const SharedTingsListSection(),
                          ] else
                            const MyTingsEmptySection(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        ),
      ],
    );
  }
}

class _MyTingsDataUpdater extends ConsumerWidget {
  const _MyTingsDataUpdater();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myTingsProvider.notifier).load();
    });
    return const SizedBox.shrink();
  }
}


class MyTingsMoreMenu extends ConsumerWidget {
  const MyTingsMoreMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = locator<NavigationService>();
    final myTingsState = ref.watch(myTingsProvider);
    final displayGrid = myTingsState.displayGrid;

    return TingsKebabMenu<String>(
      items: [
        if (displayGrid)
          TingsPopupMenuItem(
            value: 'listView',
            name: tr('my_tings.list_view'),
          )
        else
          TingsPopupMenuItem(
            value: 'gridView',
            name: tr('my_tings.grid_view'),
          ),
        TingsPopupMenuItem(value: 'editTags', name: tr('tags.edit')),
      ],
      onItemSelected: (value) async {
        if (value == 'editTags') {
          navigationService.push(const UserTagsPage());
        } else if (value == 'listView') {
          ref.read(myTingsProvider.notifier).setDisplayGrid(false);
        } else if (value == 'gridView') {
          ref.read(myTingsProvider.notifier).setDisplayGrid(true);
        }
      },
    );
  }
}
