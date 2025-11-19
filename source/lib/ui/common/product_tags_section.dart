import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/user_tags_page.dart';

class ProductTagsSection extends StatelessWidget {
  const ProductTagsSection({
    super.key,
    required this.myTing,
    this.showDoneButton = false,
    this.showTitle = true,
  });

  final ProductItem myTing;
  final bool showDoneButton;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final productTagsStore = locator<ProductTagsStore>();
    final navigationService = locator<NavigationService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Heading3(tr('tags.title')),
          const SizedBox(height: 13),
        ],
        Observer(
          builder: (_) {
            return Wrap(
              spacing: 8,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children:
                  productTagsStore.tags.map((tag) {
                    return _buildTag(tag, myTing.instanceId!);
                  }).toList(),
            );
          },
        ),
        if (productTagsStore.hasAny) ...[
          const SizedBox(height: 16),
          const TingDivider(height: 1, color: TingsColors.grayMedium),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            _buildTagButton(
              tr('tags.add_new'),
              () => showTagEditor(
                context: context,
                onSave: (tag) async => await addTagToTing(myTing.id, tag),
              ),
            ),
            const SizedBox(width: 8),
            _buildTagButton(
              tr('tags.edit'),
              () => navigationService.push(const UserTagsPage()),
            ),
          ],
        ),
        if (showDoneButton) ...[
          const SizedBox(height: 38),
          ElevatedButton(
            onPressed: () => navigationService.pop(),
            style: DesignSystemComponents.primaryButton(),
            child: Text(tr('common.done')),
          ),
        ],
      ],
    );
  }

  Widget _buildTagButton(String name, Function()? onTap) {
    return Material(
      color: TingsColors.grayMedium,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 32,
          decoration: BoxDecoration(
            //  color: TingsColors.grayMedium,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(widthFactor: 1, child: ContentBig(name)),
        ),
      ),
    );
  }

  Widget _buildTag(TagResult tag, String tingId) {
    final productTagsStore = locator<ProductTagsStore>();
    final myTingsRepository = locator<MyTingsRepository>();
    final myTingsStore = locator<MyTingsStore>();
    final ting = myTingsStore.myTings.firstWhere(
      (element) => element.instanceId == tingId,
    );
    final isActive = ting.tags.any((t) => t == tag.id);

    return Material(
      color: isActive ? TingsColors.blue : TingsColors.white,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () async {
          if (isActive) {
            // Remove tag
            final tingTags = ting.tags.toList()..remove(tag.id);
            await myTingsStore.update(ting.copyWith(tags: tingTags));
            await myTingsRepository.deleteTag(tingId, tag.id);
            await productTagsStore.updateItemCount(tag.id, -1);
          } else {
            // Add tag
            await addTagToTing(ting.id, tag);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border:
                !isActive
                    ? Border.all(color: TingsColors.grayMedium, width: 2)
                    : null,
          ),
          child: Center(
            widthFactor: 1,
            child: ContentBig(
              tag.title,
              color: isActive ? TingsColors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTagToTing(String productId, TagResult tag) async {
    final productTagsStore = locator<ProductTagsStore>();
    final myTingsRepository = locator<MyTingsRepository>();
    final myTingsStore = locator<MyTingsStore>();
    final ting = myTingsStore.getTing(productId)!;
    final tingTags = ting.tags.toList()..add(tag.id);

    await myTingsStore.update(ting.copyWith(tags: tingTags));
    await myTingsRepository.addTag(ting.instanceId!, tag.id);
    await productTagsStore.updateItemCount(tag.id, 1);
  }
}
