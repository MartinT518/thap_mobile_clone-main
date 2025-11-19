import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/scan_history/presentation/providers/scan_history_provider.dart';
import 'package:thap/features/scan_history/domain/repositories/scan_history_repository.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/deletable.dart';
import 'package:thap/ui/common/product_page_opener.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/product_list_item.dart';

class ScanHistoryPage extends ConsumerWidget {
  const ScanHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanHistoryState = ref.watch(scanHistoryProvider);

    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: tr('scan.history')),
      body: Container(
        decoration: const BoxDecoration(color: TingsColors.grayLight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 17, bottom: 15, left: 23),
              child: Heading3(tr('scan.history')),
            ),
            if (scanHistoryState.hasValue && scanHistoryState.value!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContentBig(tr('scan.history')),
                    TextButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(tr('scan.clear_all_confirm_title')),
                            content: Text(tr('scan.clear_all_confirm_message')),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: Text(tr('common.cancel')),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: Text(tr('common.clear_all'), style: const TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          final repository = await ref.read(scanHistoryRepositoryProvider.future);
                          await repository.clearHistory();
                          ref.invalidate(scanHistoryProvider);
                        }
                      },
                      child: Text(tr('scan.clear_all')),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: scanHistoryState.when(
                data: (scanHistory) => Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: TingsColors.grayMedium,
                        width: 2,
                      ),
                    ),
                  ),
                  child: scanHistory.isEmpty
                      ? Center(
                          child: ContentBig(tr('scan.no_history')),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              Container(height: 2, color: TingsColors.grayMedium),
                          scrollDirection: Axis.vertical,
                          itemCount: scanHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            final scanItem = scanHistory[index];
                            final product = scanItem.product;
                            return Deletable(
                              itemId: scanItem.scanHistoryId,
                              confirmDeletion: false, // No confirmation for single delete per FRD
                              onDeleted: () async {
                                try {
                                  final repository = await ref.read(scanHistoryRepositoryProvider.future);
                                  await repository.removeFromHistory(scanItem.scanHistoryId);
                                  ref.invalidate(scanHistoryProvider); // Refresh the list
                                } catch (e) {
                                  // Error handling - show snackbar
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Failed to delete: $e')),
                                    );
                                  }
                                }
                              },
                              child: ProductPageOpener(
                                product: product as dynamic, // ProductItem compatibility
                                pageId: 'preview',
                                child: ProductListItem(
                                  imageUrl: product.imageUrl ?? '',
                                  brand: product.brand ?? '',
                                  displayName: product.displayName,
                                ),
                              ),
                            );
                          },
                        ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContentBig('Error: $error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(scanHistoryProvider),
                        child: Text(tr('common.retry')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
