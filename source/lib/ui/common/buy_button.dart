import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page_action.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';

class BuyButton extends HookWidget {
  const BuyButton({
    super.key,
    required this.product,
    required this.title,
    this.icon,
    required this.url,
  });

  final ProductItem product;
  final String title;
  final String url;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PastelButton(
              onTap:
                  () => navigationService.productPageNavigate(
                    context,
                    product,
                    url,
                  ),
              text: title,
              iconName: icon ?? 'general_cart-basket-shop-market-buy',
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed:
                () => navigationService.productPageNavigate(
                  context,
                  product,
                  ProductPageAction.addNickname.name,
                ),
            style: OutlinedButton.styleFrom(
              backgroundColor: TingsColors.grayLight,
              fixedSize: const Size(88, 64),
              shape: const StadiumBorder(),
              side: BorderSide.none,
            ),
            child: const Center(
              child: TingIcon('options', height: 24, color: TingsColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
