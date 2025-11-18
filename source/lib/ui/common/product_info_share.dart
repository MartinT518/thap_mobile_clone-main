import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_checkbox.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/product/share_buttons_section.dart';

class ProductInfoShareSection extends HookWidget {
  const ProductInfoShareSection({super.key, required this.product});

  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final selectedProductDataMap = useState<Map<String, String?>>({
      'name': product.name,
      'code': product.code,
      'description': product.description,
      'shareLink': product.shareLink,
    });
    return Container(
      color: TingsColors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 9),
            child: Column(
              children: [
                if (product.qrCodes.isNotEmpty) ...[
                  _ProductQrCarousel(qrCodes: product.qrCodes),
                  const SizedBox(height: 12),
                ],
                TingCheckbox(
                  label: tr('product.share.product_name'),
                  checked: true,
                  onChange: (checked) {
                    selectedProductDataMap.value['name'] =
                        checked ? product.name : null;
                    selectedProductDataMap.value = Map.from(
                      selectedProductDataMap.value,
                    );
                  },
                ),
                if (product.code.isNotBlank) ...[
                  const SizedBox(height: 8),
                  TingCheckbox(
                    label: tr('product.share.product_code'),
                    checked: true,
                    onChange: (checked) {
                      selectedProductDataMap.value['code'] =
                          checked ? product.code : null;
                      selectedProductDataMap.value = Map.from(
                        selectedProductDataMap.value,
                      );
                    },
                  ),
                ],
                if (product.description.isNotBlank) ...[
                  const SizedBox(height: 8),
                  TingCheckbox(
                    label: tr('product.share.product_description'),
                    checked: true,
                    onChange: (checked) {
                      selectedProductDataMap.value['description'] =
                          checked ? product.description : null;
                      selectedProductDataMap.value = Map.from(
                        selectedProductDataMap.value,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          ShareButtonsSection(
            content: selectedProductDataMap.value.values.whereNotNull().join(
              '\n',
            ),
            copyLinkUrl: product.shareLink,
          ),
        ],
      ),
    );
  }
}

class ProductInfoShareButton extends StatelessWidget {
  ProductInfoShareButton({super.key, required this.product});

  final ProductItem product;

  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: OutlinedButton(
        onPressed:
            () => _navigationService.productPageNavigate(
              context,
              product,
              'shareProduct',
            ),
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        ),
        child: Row(
          children: [
            const TingIcon('interface_share', height: 20),
            const SizedBox(width: 9),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: ContentBig(tr('common.share')),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductQrCarousel extends HookWidget {
  const _ProductQrCarousel({required this.qrCodes});
  final List<String> qrCodes;

  @override
  Widget build(BuildContext context) {
    final activePage = useState(0);
    final qrCodesInternal = useState<List<String>>([]);

    useEffect(() {
      qrCodesInternal.value =
          qrCodes.where((qrCode) => qrCode.isNotBlank).toList();

      return null;
    }, [qrCodes]);

    if (qrCodesInternal.value.isEmpty) return Container();

    final pageController = usePageController(
      viewportFraction: 0.7,
      initialPage: 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 29),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: qrCodesInternal.value.length,
              pageSnapping: true,
              controller: pageController,
              onPageChanged: (page) {
                activePage.value = page;
              },
              itemBuilder: (context, pagePosition) {
                final code = qrCodesInternal.value[pagePosition];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      PrettyQr(data: code, size: 200),
                      const SizedBox(height: 6),
                      ContentSmall(
                        code,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (qrCodesInternal.value.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(qrCodesInternal.value.length, (
                  index,
                ) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          activePage.value == index
                              ? TingsColors.black
                              : TingsColors.grayMedium,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
