import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/features/tags/presentation/providers/tags_provider.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/user_tags_page.dart';

class ProductTagsSection extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsState = ref.watch(tagsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Heading3(tr('tags.title')),
          const SizedBox(height: 13),
        ],
        tagsState.when(
          data: (tags) => tags.isEmpty
              ? ContentBig(tr('tags.no_tags'))
              : Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: tags.map((tag) {
                    return _buildTag(context, ref, tag, myTing.instanceId ?? myTing.id);
                  }).toList(),
                ),
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => ContentBig(tr('tags.error_loading')),
        ),
        const SizedBox(height: 16),
        const TingDivider(height: 1, color: TingsColors.grayMedium),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildTagButton(
              tr('tags.add_new'),
              () => showTagEditor(
                context: context,
                onSave: (tag) async => await addTagToTing(ref, myTing.id, tag),
              ),
            ),
            const SizedBox(width: 8),
            _buildTagButton(
              tr('tags.edit'),
              () => context.push('/user-tags'),
            ),
          ],
        ),
        if (showDoneButton) ...[
          const SizedBox(height: 38),
          ElevatedButton(
            onPressed: () => context.pop(),
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

  Widget _buildTag(BuildContext context, WidgetRef ref, TagResult tag, String tingId) {
    // TODO: Implement tag activation logic with Riverpod
    // For now, show inactive tags (can be enhanced later)
    final isActive = myTing.tags.contains(tag.id);

    return Material(
      color: isActive ? TingsColors.blue : TingsColors.white,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () async {
          // TODO: Implement tag toggle with Riverpod
          // await ref.read(tagsProvider.notifier).toggleTag(tingId, tag.id);
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

  Future<void> addTagToTing(WidgetRef ref, String productId, TagResult tag) async {
    // TODO: Implement add tag with Riverpod
    // await ref.read(tagsProvider.notifier).addTagToProduct(productId, tag.id);
  }
}
