import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/my_tings/presentation/providers/my_tings_provider.dart';
import 'package:thap/features/tags/presentation/providers/tags_provider.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/typography.dart';

/// Tag filter widget - fully implemented with Riverpod
class MyTingsTagsFilter extends HookWidget {
  const MyTingsTagsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final tagsState = ref.watch(tagsNotifierProvider);
        final myTingsState = ref.watch(myTingsProvider);
        final filterTagId = myTingsState.filterTagId;

        // Load tags on first build
        useEffect(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(tagsNotifierProvider.notifier).loadTags();
          });
          return null;
        }, []);

        return tagsState.maybeWhen(
          loaded: (tags) {
            // Convert domain tags to TagResult for compatibility
            final tagsWithTings = tags.map((tag) => TagResult(
              id: tag.id,
              title: tag.title,
              itemCount: tag.itemCount,
            )).toList();

            if (tagsWithTings.isEmpty) return Container();

            return Container(
              height: 32,
              margin: const EdgeInsets.only(bottom: 14),
              child: ListView.separated(
                key: const PageStorageKey<String>('tags'),
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tagsWithTings.length + 1,
                itemBuilder: (_, int index) {
                  if (index == 0) {
                    return _buildTag(context, ref, null, filterTagId.isEmpty);
                  }
                  
                  final tag = tagsWithTings[index - 1];
                  final isActive = filterTagId == tag.id;
                  return _buildTag(context, ref, tag, isActive);
                },
              ),
            );
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Widget _buildTag(BuildContext context, WidgetRef ref, TagResult? tag, bool isActive) {
    return Material(
      color: TingsColors.grayLight,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          ref.read(myTingsProvider.notifier).setFilterTagId(tag?.id ?? '');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 32,
          decoration: isActive
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

