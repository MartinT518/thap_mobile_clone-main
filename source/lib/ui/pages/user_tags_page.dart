import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/common/typography.dart';

class UserTagsPage extends HookWidget {
  const UserTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tagsStore = locator<ProductTagsStore>();
    final toastService = locator<ToastService>();
    final navigationService = locator<NavigationService>();

    return Scaffold(
      appBar: const AppHeaderBar(showBackButton: true),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              showTagEditor(context: context);
            },
            style: DesignSystemComponents.primaryButton(),
            child: Text(tr('tags.add_title')),
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          // TODO: Migrate to Riverpod - temporarily disabled Observer
          final isLoading = false; // tagsStore.isLoading;
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final tags = <TagResult>[]; // tagsStore.tags
          return ReorderableListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tags.length,
            header: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: TingsColors.grayMedium, width: 2),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 16),
              child: Heading3(tr('tags.edit')),
            ),
            itemBuilder: (BuildContext context, int index) {
              final tag = tags[index];
              return Container(
                key: Key(tag.id),
                height: 70,
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: TingsColors.grayMedium, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TingIcon('general_drag-sort'),
                    const SizedBox(width: 16),
                    Expanded(child: ContentBig(tag.title)),
                    const SizedBox(width: 16),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            tag.itemCount > 0
                                ? TingsColors.blue
                                : TingsColors.grayDark,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Center(
                          child: Text(
                            tag.itemCount.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: TingsColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    TingsKebabMenu<String>(
                      items: [
                        TingsPopupMenuItem(
                          value: 'edit',
                          name: tr('common.edit'),
                        ),
                        if (tags.length > 1)
                          TingsPopupMenuItem(
                            value: 'delete',
                            name: tr('common.delete'),
                          ),
                      ],
                      onItemSelected: (value) async {
                        if (value == 'delete') {
                          await showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: Heading2(tr('common.delete')),
                                  content: ContentBig(
                                    tr('tags.delete_confirmation'),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        toastService.success(
                                          tr('tags.delete_message'),
                                        );
                                        await tagsStore.remove(tag);

                                        navigationService.pop(true);
                                      },
                                      child: Heading3(tr('common.proceed')),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => navigationService.pop(false),
                                      child: ContentBig(tr('common.cancel')),
                                    ),
                                  ],
                                ),
                          );
                        } else if (value == 'edit') {
                          showTagEditor(context: context, tag: tag);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            onReorder:
                (int oldIndex, int newIndex) async =>
                    await tagsStore.reorder(oldIndex, newIndex),
          );
        },
      ),
    );
  }
}

void showTagEditor({
  required BuildContext context,
  TagResult? tag,
  Function(TagResult tag)? onSave,
}) {
  final tagsStore = locator<ProductTagsStore>();
  final toastService = locator<ToastService>();
  final navigationService = locator<NavigationService>();
  final tagNameController = TextEditingController(text: tag?.title);

  showTingsBottomSheet(
    context: context,
    title: tr('tags.name'),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          TingsTextField(
            controller: tagNameController,
            hint: tr('tags.add_hint'),
          ),
          const SizedBox(height: 38),
          ElevatedButton(
            onPressed: () async {
              final tagName = tagNameController.text;
              if (tagName.isBlank) {
                toastService.error(tr('tags.no_name_message'));
              } else if (tag != null) {
                await tagsStore.rename(tag.id, tagName);

                navigationService.pop();
                toastService.success(tr('tags.renamed_message'));
              } else {
                final tag = await tagsStore.add(tagName);

                if (onSave != null) {
                  onSave(tag);
                }

                navigationService.pop();
                toastService.success(tr('tags.added_message'));
              }
            },
            style: DesignSystemComponents.primaryButton(),
            child: Text(tr('common.done')),
          ),
        ],
      ),
    ),
  );
}
