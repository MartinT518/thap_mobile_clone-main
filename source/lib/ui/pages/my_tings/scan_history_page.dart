import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/deletable.dart';
import 'package:thap/ui/common/product_page_opener.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/product_list_item.dart';

class ScanHistoryPage extends StatelessWidget {
  ScanHistoryPage([Key? key]) : super(key: key);

  final _scanHistoryStore = locator<ScanHistoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(showBackButton: true, title: tr('scan.history')),
      body: Container(
        decoration: const BoxDecoration(color: TingsColors.grayLight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 17, bottom: 15, left: 23),
              child: Heading3(tr('scan.history')),
            ),
            Observer(builder: (_) {
              return Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: TingsColors.grayMedium, width: 2))),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        Container(height: 2, color: TingsColors.grayMedium),
                    scrollDirection: Axis.vertical,
                    itemCount: _scanHistoryStore.scanHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = _scanHistoryStore.scanHistory[index];
                      return Deletable(
                        itemId: product.id,
                        onDeleted: () async {
                          await _scanHistoryStore.remove(product);
                        },
                        child: ProductPageOpener(
                          product: product,
                          pageId: 'preview',
                          child: ProductListItem(
                              imageUrl: product.imageUrl,
                              brand: product.brand,
                              displayName: product.name),
                        ),
                      );
                    }),
              ));
            })
          ],
        ),
      ),
    );
  }
}
