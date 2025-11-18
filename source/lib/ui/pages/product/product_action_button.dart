import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_action.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ProductActionButton extends StatelessWidget {
  const ProductActionButton({super.key, required this.action});

  final ProductAction action;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TingsColors.white,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: action.onTap,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: TingsColors.grayMedium, width: 2),
          ),
          child: Center(
            child: Row(
              children: [
                if (action.icon.isNotBlank) ...[
                  TingIcon(action.icon!, height: 20),
                  const SizedBox(width: 6),
                ],
                ContentBig(action.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
