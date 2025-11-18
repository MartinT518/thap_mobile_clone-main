import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/ui/common/add_to_my_tings_button.dart';
import 'package:thap/ui/common/alert_message.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';

Future<void> showNotMyTingsInteractionBottomSheet(
    {required BuildContext context, required ProductItem product}) {
  return showTingsBottomSheet(
      context: context,
      title: tr('my_tings.not_in_tings_interaction_title'),
      child: Column(
        children: [
          AlertMessage(
            title: tr('my_tings.not_in_tings_interaction_message'),
            iconName: 'general_info-notification',
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                AddToMyTingsButton(product: product),
              ],
            ),
          ),
        ],
      ));
}
