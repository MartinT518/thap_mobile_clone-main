import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.imageUrl.isNotBlank)
            Center(
              child: SizedBox(
                width: 152,
                height: 108,
                child: TingsImage(
                  product.imageUrl!,
                  height: 108,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          else
            Center(
              child: Container(
                width: 152,
                height: 108,
                decoration: BoxDecoration(
                  color: TingsColors.grayLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContentSmall(
                  product.brand,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                ContentBig(
                  product.displayName,
                  isBold: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
