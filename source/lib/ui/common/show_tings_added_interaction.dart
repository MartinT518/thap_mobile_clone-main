import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/product/set_product_info_section.dart';

Future<void> showTingsAddedInteraction(
    BuildContext context, ProductItem ting) async {
  await showTingsBottomSheet(
    context: context,
    titleWidget: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading3(
          tr('my_tings.new_ting_added_extra_info.title_prefix'),
          color: TingsColors.green,
        ),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          child: Heading3(
            tr('my_tings.new_ting_added_extra_info.title'),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
    child: SetProductInfoSection(
      wasAdded: true,
      product: ting,
    ),
  );
}
