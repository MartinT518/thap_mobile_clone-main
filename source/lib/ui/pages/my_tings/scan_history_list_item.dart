import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/deletable.dart';
import 'package:thap/ui/common/product_page_opener.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class ScanHistoryListItem extends StatelessWidget {
  ScanHistoryListItem({required this.product, super.key});

  final ProductItem product;
  final _scanHistoryStore = locator<ScanHistoryStore>();

  @override
  Widget build(BuildContext context) {
    return Deletable(
      itemId: product.id,
      direction: DismissDirection.up,
      onDeleted: () async {
        await _scanHistoryStore.remove(product);
      },
      child: ProductPageOpener(
        product: product,
        pageId: 'preview',
        child: Container(
          height: 141,
          width: 129,
          padding: const EdgeInsets.only(top: 10, bottom: 0, left: 6, right: 6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
          child: Column(
            children: [
              if (product.imageUrl.isNotBlank)
                TingsImage(
                  product.imageUrl,
                  height: 68,
                  width: 61,
                  fit: BoxFit.fitHeight,
                )
              else
                Container(
                  width: 61,
                  height: 68,
                  decoration: BoxDecoration(
                    color: TingsColors.grayLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(top: 7),
                child: ContentSmall(
                  product.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
