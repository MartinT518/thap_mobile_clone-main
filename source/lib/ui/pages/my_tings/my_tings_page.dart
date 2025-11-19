import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
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
      Future.microtask(() async => await myTingsStore.load());
      Future.microtask(() async => await scanHistoryStore.load());
      return null;
    }, []);

    return RefreshIndicator(
      onRefresh: () async {
        refreshing.value = true;
        await myTingsStore.load();
        await scanHistoryStore.load();
      },
      child: Observer(
        builder: (_) {
          if ((scanHistoryStore.isLoading || myTingsStore.isLoading) &&
              !refreshing.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!myTingsStore.hasAny &&
              !scanHistoryStore.hasAny &&
              myTingsStore.filterTagId.isBlank) {
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
                  if (myTingsStore.hasAny ||
                      myTingsStore.filterTagId.isNotBlank) ...[
                    const MyTingsTagsFilter(),
                    MyTingsListSection(),

                    SharedTingsListSection(),
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
}

class MyTingsTagsFilter extends HookWidget {
  const MyTingsTagsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final productTagsStore = locator<ProductTagsStore>();

    useEffect(() {
      Future.microtask(() async => await productTagsStore.load());

      return null;
    }, []);

    return Observer(
      builder: (_) {
        if (productTagsStore.tagsWithTings.isEmpty) return Container();

        return Container(
          height: 32,
          margin: const EdgeInsets.only(bottom: 14),
          child: ListView.separated(
            key: const PageStorageKey<String>('tags'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(width: 0),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: productTagsStore.tagsWithTings.length + 1,
            itemBuilder: (_, int index) {
              return Observer(
                builder: (_) {
                  final myTingsStore = locator<MyTingsStore>();

                  if (index == 0) {
                    return _buildTag(null, myTingsStore.filterTagId.isBlank);
                  }
                  final tag = productTagsStore.tagsWithTings[index - 1];
                  return _buildTag(tag, myTingsStore.filterTagId == tag.id);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTag(TagResult? tag, bool isActive) {
    final myTingsStore = locator<MyTingsStore>();

    return Material(
      color: TingsColors.grayLight,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          myTingsStore.setFilterTag(tag?.id);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 32,
          decoration:
              isActive
                  ? BoxDecoration(
                    color: TingsColors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: TingsColors.grayMedium, width: 2),
                  )
                  : null,
          child: Center(
            child: ContentBig(
              tag != null ? tag.title : tr('common.all'),
              isBold: isActive,
            ),
          ),
        ),
      ),
    );
  }
}

class MyTingsMoreMenu extends StatelessWidget {
  const MyTingsMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    final myTingsStore = locator<MyTingsStore>();

    return Observer(
      builder: (_) {
        return TingsKebabMenu<String>(
          items: [
            if (myTingsStore.displayGrid)
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
              await myTingsStore.setDisplayMode(displayGrid: false);
            } else if (value == 'gridView') {
              await myTingsStore.setDisplayMode(displayGrid: true);
            }
          },
        );
      },
    );
  }
}
