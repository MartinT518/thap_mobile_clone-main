import 'package:flutter/material.dart';
import 'package:thap/models/product_action.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/pages/product/product_action_button.dart';

class ProductActionButtonsList extends StatelessWidget {
  const ProductActionButtonsList({
    super.key,
    required this.actions,
    this.showTopShadow = false,
  });

  final List<ProductAction> actions;
  final bool showTopShadow;
  @override
  Widget build(BuildContext context) {
    const double paddingTopBottom = 24;
    return Container(
      decoration:
          showTopShadow
              ? const BoxDecoration(
                color: TingsColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    offset: Offset(0, -6),
                    blurRadius: 6,
                  ),
                ],
              )
              : null,
      height: 32 + paddingTopBottom * 2,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(
        top: paddingTopBottom,
        bottom: paddingTopBottom,
        left: 16,
      ),
      child: Center(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 6),
          padding: const EdgeInsets.only(top: 0),
          scrollDirection: Axis.horizontal,
          itemCount: actions.length,
          itemBuilder:
              (_, int index) => ProductActionButton(action: actions[index]),
        ),
      ),
    );
  }
}
