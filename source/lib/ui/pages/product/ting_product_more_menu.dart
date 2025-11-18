import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/pages/product/set_product_info_section.dart';

class TingProductMoreMenu extends StatelessWidget {
  const TingProductMoreMenu({super.key, required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final myTingsStore = locator<MyTingsStore>();
    final toastService = locator<ToastService>();
    final productPagesStore = locator<ProductPagesStore>();
    final navigationService = locator<NavigationService>();

    return TingsKebabMenu<ProductMenuAction>(
      items: [
        TingsPopupMenuItem(
          value: ProductMenuAction.info,
          name: tr('product.info.title'),
        ),
        TingsPopupMenuItem(
          value: ProductMenuAction.delete,
          name: tr('common.delete'),
        ),
      ],
      onItemSelected: (value) async {
        switch (value!) {
          case ProductMenuAction.info:
            await showTingsBottomSheet(
              context: context,
              title: tr('product.info.title'),
              child: SetProductInfoSection(product: product),
            );
            await productPagesStore.load(
              product.id,
              context.locale.languageCode,
            );
            break;
          case ProductMenuAction.delete:
            await myTingsStore.remove(product);
            toastService.success(tr('my_tings.deleted_message'));
            navigationService.pop();
            break;
        }
      },
    );
  }
}

enum ProductMenuAction { info, delete }
