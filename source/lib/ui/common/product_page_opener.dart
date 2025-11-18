import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/ui/pages/product/product_page.dart';
import 'package:thap/utilities/tings_loader.dart';

class ProductPageOpener extends StatelessWidget {
  const ProductPageOpener({
    super.key,
    required this.product,
    required this.child,
    this.pageId = 'root',
    this.onClosed,
  });

  final String pageId;
  final ProductItem product;
  final Widget child;
  final Function()? onClosed;

  @override
  Widget build(BuildContext context) {
    final productPagesStore = locator<ProductPagesStore>();
    final navigationService = locator<NavigationService>();

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2),
      child: InkWell(
        onTap: () async {
          TingsLoader(context).show();
          final productPage = await productPagesStore.getPage(
            product.id,
            context.locale.languageCode,
            pageId,
          );
          TingsLoader(context).hide();

          if (productPage != null) {
            await navigationService.push(
              ProductPage(page: productPage, product: product),
            );
            if (onClosed != null) {
              onClosed!();
            }
          }
        },
        child: child,
      ),
    );
  }
}
