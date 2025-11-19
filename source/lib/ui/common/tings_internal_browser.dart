import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/open_graph_scrape_result.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/data_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/ui/common/alert_message.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/show_tings_added_interaction.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/pages/product/product_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TingsInternalBrowser extends HookWidget {
  TingsInternalBrowser({super.key, required this.url, this.product});

  final GlobalKey webViewKey = GlobalKey();
  final String url;
  final ProductItem? product;

  @override
  Widget build(BuildContext context) {
    final controller = useState<WebViewController?>(null);
    final currentUrl = useState<String>(url);
    // Show extract bar only for not found products when not in google search
    final canExtractProductInfo =
        product != null &&
        product?.externalProductType == ExternalProductType.notFoundProduct &&
        !currentUrl.value.contains('.google.');

    useEffect(() {
      controller.value =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (String url) {
                  currentUrl.value = url;
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
      return null;
    }, [url]);

    if (controller.value == null) return Container();

    return WillPopScope(
      onWillPop: () async {
        final initialUri = Uri.parse(url).removeFragment();
        final currentUri = Uri.parse(currentUrl.value).removeFragment();
        final hasNavigated = initialUri != currentUri;

        if (hasNavigated) {
          await controller.value?.goBack();
          return false;
        }
        // On back gesture navigate out of internal browser only when on initial url
        return true;
      },
      child: Scaffold(
        appBar: AppHeaderBar(
          showBackButton: true,
          backButtonIcon: 'menu_menu-close',
          onNavigateBack: () {
            locator<NavigationService>().pop();
          },
          rightWidget: TingsKebabMenu<String>(
            items: [
              TingsPopupMenuItem(value: 'share', name: tr('common.share')),
              TingsPopupMenuItem(
                value: 'open',
                name: tr('common.open_in_browser'),
              ),
            ],
            onItemSelected: (value) async {
              if (value == 'share') {
                final shareService = locator<ShareService>();
                final currentUrl = await controller.value!.currentUrl();
                shareService.shareText(currentUrl!);
              } else if (value == 'open') {
                final openerService = locator<OpenerService>();
                final currentUrl = await controller.value!.currentUrl();
                openerService.openExternalBrowser(currentUrl!);
              }
            },
          ),
        ),
        bottomNavigationBar:
            canExtractProductInfo
                ? _ExtractProductInfoBottomBar(
                  product: product!,
                  controller: controller.value,
                )
                : null,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: WebViewWidget(controller: controller.value!)),
              ],
            ),
            if (!canExtractProductInfo)
              Positioned(
                left: 8,
                bottom: 8,
                child: _buildBackButton(controller.value),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExtractProductInfoBottomBar extends HookWidget {
  const _ExtractProductInfoBottomBar({
    this.controller,
    required this.product,
  });

  final WebViewController? controller;
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final extracting = useState(false);
    final hasInstance = product.instanceId != null;

    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(color: TingsColors.grayLight),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (extracting.value)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else ...[
              _buildBackButton(controller),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                  final url = await controller?.currentUrl();

                  if (url.isNotBlank) {
                    extracting.value = true;

                    final result = await locator<DataService>()
                        .extractProductInfo(url!);

                    extracting.value = false;

                    if (result != null) {
                      titleController.text = result.title ?? '';

                      _showExtractedData(
                        context,
                        result,
                        titleController,
                        product,
                      );
                    }
                  }
                  },
                  style: DesignSystemComponents.primaryButton(),
                  child: Text(tr(hasInstance ? 'my_tings.update' : 'my_tings.add')),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showExtractedData(
    BuildContext context,
    OpenGraphScrapeResult result,
    TextEditingController titleController,
    ProductItem product,
  ) {
    final myTingsRepository = locator<MyTingsRepository>();
    final navigationService = locator<NavigationService>();
    final productPagesStore = locator<ProductPagesStore>();
    final myTingsStore = locator<MyTingsStore>();
    final toastService = locator<ToastService>();

    showTingsBottomSheet(
      context: context,
      title: tr('search.extracted_data'),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AlertMessage(
              title: tr('search.extracted_verify_message'),
              iconName: 'general_info-notification',
            ),
            const SizedBox(height: 24),
            TingsTextField(
              controller: titleController,
              label: tr('common.title'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            TingsImage(result.imageUrl!, height: 160),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final hasInstance = product.instanceId != null;
                final title = titleController.text;
                var ting = product.copyWith(
                  nickname: title,
                  imageUrl: result.imageUrl,
                );

                if (!hasInstance) {
                  ting = await myTingsStore.add(ting);

                  toastService.success(tr('my_tings.add_message'));
                } else {
                  await myTingsStore.update(product);
                }

                await myTingsRepository.saveExternalData(
                  ting.instanceId!,
                  title,
                  result.imageUrl,
                );

                final productPage = await productPagesStore.getPage(
                  product.id,
                  context.locale.languageCode,
                );

                navigationService
                  ..pop()
                  ..pop();

                if (productPage != null) {
                  navigationService.replace(
                    ProductPage(page: productPage, product: ting),
                  );
                }

                // Show options if was added to tings
                if (!hasInstance) {
                  showTingsAddedInteraction(context, ting);
                }
              },
              text: tr('common.save'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBackButton(WebViewController? controller) {
  return OutlinedButton(
    onPressed: () async {
      await controller?.goBack();
    },
    style: OutlinedButton.styleFrom(
      backgroundColor: TingsColors.white,
      shape: const CircleBorder(),
      side: const BorderSide(width: 2, color: TingsColors.black),
      padding: const EdgeInsets.all(0),
    ),
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: TingIcon('general_arrow-chevron-left', height: 40),
    ),
  );
}
