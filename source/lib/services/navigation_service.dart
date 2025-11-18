import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page_action.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/not_mytings_interaction_bottom_sheet.dart';
import 'package:thap/ui/common/product_info_share.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/product/add_receipt_section.dart';
import 'package:thap/ui/pages/product/producer_feedback_section.dart';
import 'package:thap/ui/pages/product/product_form_page.dart';
import 'package:thap/ui/pages/product/product_note_page.dart';
import 'package:thap/ui/pages/product/product_page.dart';
import 'package:thap/ui/pages/product/set_product_info_section.dart';
import 'package:thap/utilities/utilities.dart';

class NavigationService {
  final _openerService = locator<OpenerService>();
  final _productPagesStore = locator<ProductPagesStore>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(Widget page) {
    return navigatorKey.currentState!.push(MaterialPageRoute<void>(
      builder: (BuildContext context) => page,
    ));
  }

  Future<dynamic> replace(Widget page) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) => page,
    ));
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  void maybePop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.maybePop(result);
  }

  void popToRoot() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<dynamic> replaceAll(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => page),
        (Route<dynamic> route) => false);
  }

  Future productPageNavigate(
      BuildContext context, ProductItem product, String href,
      [bool openInModal = false]) async {
    if (href.startsWith('#')) {
      // Internal product page link
      var pageId = href.substring(1);
      Logger().i(
          'Trying to navigate to pageId: $pageId, href: $href, openInModal: $openInModal');

      final productPages = _productPagesStore.productPages
              .firstWhereOrNull((pages) => pages.productId == product.id) ??
          (await _productPagesStore.load(
              product.id, context.locale.languageCode));

      if (productPages == null) return;

      final page =
          productPages.pages.firstWhereOrNull((page) => page.pageId == pageId);

      if (page == null) {
        Logger()
            .w('Cold not find pageId: $pageId  for productId ${product.id}');
        return;
      }

      if (openInModal) {
        await showTingsBottomSheet(
          context: context,
          title: apiTranslate(page.title),
          child: ProductPage(
            page: page,
            product: product,
            isModal: true,
          ),
        );
      } else {
        await push(ProductPage(page: page, product: product));
      }
    } else if (href.startsWith('http')) {
      // External web link
      await _openerService.openInternalBrowser(href, product: product);
    } else {
      // Custom page action
      var pageAction = _enumFromString(ProductPageAction.values, href);

      if (pageAction != null) {
        if (pageAction == ProductPageAction.shareProduct) {
          showTingsBottomSheet(
              context: context,
              title: tr('product.share.title'),
              child: ProductInfoShareSection(
                product: product,
              ));

          return;
        }

        final ting = locator<MyTingsStore>().getTing(product.id);

        if (ting != null) {
          switch (pageAction as ProductPageAction) {
            case ProductPageAction.addReceipt:
              await showTingsBottomSheet(
                  context: context,
                  title: tr('product.receipt.page_title'),
                  child: AddReceiptSection(
                    productInstanceId: product.instanceId!,
                  ));
              await _productPagesStore.load(
                  product.id, context.locale.languageCode);
              break;
            case ProductPageAction.deleteReceipt:
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Heading2(tr('common.delete')),
                    content: ContentBig(tr('common.delete_confirmation')),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await locator<MyTingsRepository>()
                                .deleteReceipt(product.instanceId!);
                            await _productPagesStore.load(
                                product.id, context.locale.languageCode);
                            locator<ToastService>()
                                .success(tr('common.delete_message'));
                            pop(true);
                          },
                          child: Heading3(tr('common.proceed'))),
                      TextButton(
                        onPressed: () => pop(false),
                        child: ContentBig(tr('common.cancel')),
                      ),
                    ],
                  );
                },
              );

              break;
            case ProductPageAction.showOptions:
            case ProductPageAction.addNickname:
              await showTingsBottomSheet(
                  context: context,
                  title: tr('product.info.title'),
                  child: SetProductInfoSection(
                    product: product,
                  ));
              await _productPagesStore.load(
                  product.id, context.locale.languageCode);
              break;
            case ProductPageAction.registerProduct:
              final registrationFormModel = await locator<ProductsRepository>()
                  .registrationForm(product.id);

              if (registrationFormModel == null) {
                locator<ToastService>()
                    .error('Could not find registration form for this product');
                Logger().w(
                    'Could not find any form fields for product ${product.id}');
                break;
              }

              await push(ProductFormPage(
                  productInstanceId: product.instanceId!,
                  formModel: registrationFormModel));

              await _productPagesStore.load(
                  product.id, context.locale.languageCode);
              break;
            case ProductPageAction.showNote:
              await push(ProductNotePage(product: product));

              await _productPagesStore.load(
                  product.id, context.locale.languageCode);
              break;
            case ProductPageAction.producerFeedback:
              await showTingsBottomSheet(
                  context: context,
                  title: tr('product.feedback.title'),
                  child: ProducerFeedbackSection(
                    productId: product.id,
                  ));
              // await _productPagesStore.load(product.id);
              break;
            default:
              Logger().w('Cold not find page action for href: $href');
          }
        } else {
          showNotMyTingsInteractionBottomSheet(
              context: context, product: product);
        }
      } else {
        Logger().w('Cold not find page action for href: $href');
      }
    }
  }

  Future<void> openProduct(ProductItem product, String languageCode,
      [bool replaceRoute = true, bool saveHistory = true]) async {
    final scanHistoryStore = locator<ScanHistoryStore>();
    final myTingsStore = locator<MyTingsStore>();
    final ting = myTingsStore.getTing(product.id);
    final productPage = await _productPagesStore.getPage(
        product.id,
        languageCode,
        ting != null ? 'root' : 'preview'); // Show preview page if not my ting

    if (productPage == null) {
      locator<ToastService>().error(tr('pages.not_found_error'));
      return;
    }

    final page = ProductPage(
      page: productPage,
      product: product,
      navigateToRootOnPop: replaceRoute,
    );

    if (replaceRoute) {
      replace(page);
    } else {
      push(page);
    }

    if (saveHistory && myTingsStore.getTing(product.id) == null) {
      scanHistoryStore.add(product);
    }
  }

  Future<void> openAppLink(Uri appLink, String languageCode) async {
    final isLoggedIn = locator<UserProfileStore>().userProfile != null;

    if (!isLoggedIn) {
      await locator<AuthService>().tryRestoreSession();
    }

    final productRepository = locator<ProductsRepository>();
    ProductItem? productItem;

    if (appLink.host == 'id.tings.info') {
      final productId = appLink.pathSegments.last;
      Logger().i('Opening App link with Product ID: $productId');
      productItem = await productRepository.getProduct(productId);
    } else if (appLink.host == 'qr.tings.info') {
      final qrUrl = appLink;
      Logger().i('Opening App link with qrUrl: $qrUrl');
      productItem = await productRepository.findByQrUrl(qrUrl);
    }

    if (productItem == null) {
      locator<ToastService>().error('Could not find this product.');
      return;
    }

    openProduct(productItem, languageCode, false, false);
  }
}

dynamic _enumFromString(List enumValues, String value) {
  dynamic enumValue;
  for (var item in enumValues) {
    if (item.toString().split('.').last == value) {
      enumValue = item;
    }
  }
  return enumValue;
}
