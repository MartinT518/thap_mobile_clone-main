import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/ui/common/show_tings_added_interaction.dart';
import 'package:thap/ui/pages/home_page.dart';

class AddToMyTingsButton extends StatelessWidget {
  const AddToMyTingsButton({super.key, required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final myTingsStore = locator<MyTingsStore>();
    final toastService = locator<ToastService>();
    final navigationService = locator<NavigationService>();

    return ElevatedButton(
      onPressed: () async {
        final ting = await myTingsStore.add(product);
        toastService.success(tr('my_tings.add_message'));
        navigationService.replace(HomePage());

        await showTingsAddedInteraction(context, ting);
        //  await locator<ProductPagesStore>().load(productId);
      },
      style: DesignSystemComponents.primaryButton(),
      child: Text(tr('my_tings.add')),
    );
  }
}
