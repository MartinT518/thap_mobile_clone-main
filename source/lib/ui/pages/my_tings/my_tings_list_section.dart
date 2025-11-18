import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/deletable.dart';
import 'package:thap/ui/common/product_page_opener.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/product_grid_item.dart';
import 'package:thap/ui/pages/my_tings/product_list_item.dart';
import 'package:thap/ui/pages/my_tings/product_list_item_skeleton.dart';

class MyTingsListSection extends StatelessWidget {
  MyTingsListSection({super.key});

  final _myTingsStore = locator<MyTingsStore>();
  final _scanHistoryStore = locator<ScanHistoryStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final List<ProductItem?> tings = List.from(
          _myTingsStore.myTingsFiltered,
        );
        // final int totalTings = tings.length;
        // int minimumOnScreen = _scanHistoryStore.hasAny ? 4 : 6;

        // Fill up my tings list with skeletons if needed
        // if (totalTings < minimumOnScreen) {
        //   int numberOfSkeletonItemsToAdd = minimumOnScreen - totalTings;
        //   for (var i = 1; i <= numberOfSkeletonItemsToAdd; i++) {
        //     tings.add(null);
        //   }
        // }

        if (_myTingsStore.displayGrid) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 225,
              crossAxisSpacing: 7,
              mainAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            itemCount: _myTingsStore.myTingsFiltered.length,
            itemBuilder: (_, int index) {
              final product = _myTingsStore.myTingsFiltered[index];

              return Deletable(
                itemId: product.id,
                confirmDeletion: true,
                onDeleted: () async {
                  await _myTingsStore.remove(product);
                },
                child: ProductPageOpener(
                  product: product,
                  child: Hero(
                    tag: product.id,
                    child: ProductGridItem(product: product),
                  ),
                ),
              );
            },
          );
        }

        return Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: TingsColors.grayMedium, width: 2),
            ),
          ),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const TingDivider(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: tings.length,
            itemBuilder: (_, int index) {
              final myTing = tings[index];
              return myTing == null
                  ? const ProductListItemSkeleton()
                  : Deletable(
                    itemId: myTing.id,
                    confirmDeletion: true,
                    onDeleted: () async {
                      await _myTingsStore.remove(myTing);
                    },
                    child: ProductPageOpener(
                      product: myTing,
                      child: Hero(
                        tag: myTing.id,
                        child: ProductListItem(
                          imageUrl: myTing.imageUrl,
                          brand: myTing.brand,
                          displayName: myTing.displayName,
                        ),
                      ),
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}

class SharedTingsListSection extends StatelessWidget {
  SharedTingsListSection({super.key});

  final _myTingsStore = locator<MyTingsStore>();
  final _tagsStore = locator<ProductTagsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (!_tagsStore.hasAny) return Container();

        final lastTagId = _tagsStore.tags.last.id;
        final List<ProductItem?> tings = List.from(
          _myTingsStore.myTings.where((ting) => ting.tags.contains(lastTagId)),
        );

        if (tings.isEmpty) return Container();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Heading3(tr('my_tings.shared_title')),
            ),
            if (_myTingsStore.displayGrid)
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 225,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: tings.length,
                itemBuilder: (_, int index) {
                  final product = tings[index]!;

                  return Deletable(
                    itemId: product.id,
                    confirmDeletion: true,
                    onDeleted: () async {
                      await _myTingsStore.remove(product);
                    },
                    child: ProductPageOpener(
                      product: product,
                      child: Hero(
                        tag: product.id,
                        child: ProductGridItem(product: product),
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: TingsColors.grayMedium,
                      width: 2,
                    ),
                  ),
                ),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const TingDivider(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tings.length,
                  itemBuilder: (_, int index) {
                    final myTing = tings[index];
                    return myTing == null
                        ? const ProductListItemSkeleton()
                        : Deletable(
                          itemId: myTing.id,
                          confirmDeletion: true,
                          onDeleted: () async {
                            await _myTingsStore.remove(myTing);
                          },
                          child: ProductPageOpener(
                            product: myTing,
                            child: Hero(
                              tag: myTing.id,
                              child: ProductListItem(
                                imageUrl: myTing.imageUrl,
                                brand: myTing.brand,
                                displayName: myTing.displayName,
                              ),
                            ),
                          ),
                        );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
