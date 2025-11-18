import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logger/logger.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_action.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/models/shortcut_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/ui/common/add_to_my_tings_button.dart';
import 'package:thap/ui/common/address.dart';
import 'package:thap/ui/common/alert_message.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/ask_ai_button.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/html_content.dart';
import 'package:thap/ui/common/image_carousel.dart';
import 'package:thap/ui/common/key_value_table.dart';
import 'package:thap/ui/common/product_file.dart';
import 'package:thap/ui/common/product_info_share.dart';
import 'package:thap/ui/common/product_items.dart';
import 'package:thap/ui/common/product_marketing_message.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/ui/common/product_rating.dart';
import 'package:thap/ui/common/product_title.dart';
import 'package:thap/ui/common/product_website_view.dart';
import 'package:thap/ui/common/search_links.dart';
import 'package:thap/ui/common/section_title.dart';
import 'package:thap/ui/common/shortcut_list.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/verified_banner.dart';
import 'package:thap/ui/common/video_player.dart';
import 'package:thap/ui/pages/product/product_action_buttons_list.dart';
import 'package:thap/ui/pages/product/share_buttons_section.dart';
import 'package:thap/ui/pages/product/ting_product_more_menu.dart';
import 'package:thap/ui/pages/scan/scan_page.dart';
import 'package:thap/utilities/utilities.dart';

class ProductPage extends HookWidget {
  const ProductPage({
    super.key,
    required this.page,
    required this.product,
    this.openAction,
    this.isModal = false,
    this.navigateToRootOnPop = false,
  });

  final ProductItem product;
  final ProductPageModel page;
  final String? openAction;
  final bool isModal;
  final bool navigateToRootOnPop;

  @override
  Widget build(BuildContext context) {
    final myTingsStore = locator<MyTingsStore>();
    final productPagesStore = locator<ProductPagesStore>();
    final navigationService = locator<NavigationService>();

    useEffect(() {
      if (openAction?.isNotEmpty ?? false) {
        Timer.run(() {
          locator<NavigationService>().productPageNavigate(context, product, openAction!);
        });
      }
      return null;
    }, [openAction]);
    Logger().i('Page id is ${page.pageId}, product: ${product.id}');

    return WillPopScope(
      onWillPop: () async {
        if (!navigateToRootOnPop) return true;

        navigationService.popToRoot();

        return false;
      },
      child: Observer(
        builder: (BuildContext context) {
          final productPage = productPagesStore.getStoredPage(product.id, page.pageId)!;

          // Title not shown on root or preview pages as it should be inside the productPage content already
          final bool showTitle = productPage.pageId != 'root' && productPage.pageId != 'preview';
          final ting = myTingsStore.getTing(product.id);

          final String? displayName =
              (ting?.nickname?.isNotEmpty ?? false) ? ting!.nickname : product.name;

          if (isModal) {
            return ProductPageComponents(page: productPage, product: product);
          }

          final showMoreMenu = !showTitle && ting != null;

          return Scaffold(
            appBar: AppHeaderBar(
              title: showTitle ? displayName : null,
              subTitle: showTitle ? apiTranslate(productPage.title) : null,
              logo:
                  !showTitle &&
                          product.brandLogoUrl.isNotBlank &&
                          product.externalProductType == null
                      ? TingsImage(
                        product.brandLogoUrl!,
                        //width: 150,
                        alignment: Alignment.centerLeft,
                        height: 28,
                      )
                      : null,
              showBackButton: true,
              onNavigateBack: () {
                if (navigateToRootOnPop) {
                  navigationService.popToRoot();
                } else {
                  navigationService.pop();
                }
              },
              rightWidget: Row(
                children: [
                  if (!showTitle) ProductInfoShareButton(product: product),
                  if (showMoreMenu)
                    TingProductMoreMenu(product: product)
                  else
                    const SizedBox(width: 27),
                ],
              ),
            ),
            bottomNavigationBar: ting == null ? _buildTingsBottomBar(context) : null,
            body: SafeArea(
              child: Container(
                color: TingsColors.white,
                child: ProductPageComponents(page: productPage, product: product),
              ),
            ),
          );
        },
      ),
    );
  }

  SafeArea _buildTingsBottomBar(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return SafeArea(
      bottom: true,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(color: TingsColors.grayLight),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                navigationService.push(const ScanPage());
              },
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: TingsColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: TingsColors.black, width: 2),
                ),
                child: const Center(
                  child: TingIcon(
                    'general_qr-code-scan',
                    width: 24,
                    height: 24,
                    color: TingsColors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            AddToMyTingsButton(product: product),
          ],
        ),
      ),
    );
  }
}

class ProductPageComponents extends HookWidget {
  const ProductPageComponents({super.key, required this.page, required this.product});

  final ProductPageModel page;
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 0),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: scrollController,
      itemCount: page.components.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildComponent(
          context,
          product,
          page.components[index],
          page.components,
          page.userImages,
          () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
          () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent - MediaQuery.of(context).size.height + 95,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
        );
      },
    );
  }
}

Widget _buildComponent(
  BuildContext context,
  ProductItem product,
  ProductPageComponentModel component,
  List<ProductPageComponentModel> components,
  List<CdnImage> userImages,
  Function scrollToBottom,
  Function scrollUp,
) {
  final navigationService = locator<NavigationService>();

  if (component.hidden == true) return Container();

  try {
    switch (component.type) {
      case ProductPageComponentType.title:
        final isValid =
            (component.title?.isNotEmpty ?? false) || (component.subTitle?.isNotEmpty ?? false);
        if (!isValid) break;

        return ProductTitle(
          title: apiTranslate(component.title),
          subTitle: apiTranslate(component.subTitle),
        );
      case ProductPageComponentType.sectionTitle:
        final isValid = component.title?.isNotEmpty ?? false;
        if (!isValid) break;

        return SectionTitle(title: apiTranslate(component.title));
      case ProductPageComponentType.imageCarusel:
        return ImageCarousel(
          product: product,
          cdnImages: component.cdnImages ?? [],
          canUpload: component.canUpload == true,
          deletableProductImages: userImages,
        );
      case ProductPageComponentType.actionButtons:
        final links = _filterOutHiddenLinks(component.links);
        final isValid = links?.isNotEmpty ?? false;
        if (!isValid) break;

        final actions =
            links!
                .map(
                  (link) => ProductAction(
                    text: apiTranslate(link.title!),
                    icon: link.icon,
                    onTap: () {
                      navigationService.productPageNavigate(
                        context,
                        product,
                        link.href!,
                        link.openInModal,
                      );
                    },
                  ),
                )
                .toList();

        if (actions.isNotEmpty) {
          return ProductActionButtonsList(actions: actions, showTopShadow: true);
        }
        break;
      case ProductPageComponentType.rating:
        final isValid =
            (component.link?.title?.isNotEmpty ?? false) &&
            (component.rating != null && component.rating?.type != null);
        if (!isValid) break;

        final index = components.indexOf(component);
        final isPreviousComponentRating =
            index > 0 && components[index - 1].type == ProductPageComponentType.rating;
        final isNextComponentRating =
            components.length > index + 1 &&
            components[index + 1].type == ProductPageComponentType.rating;

        return ProductRating(
          title: apiTranslate(component.link!.title!),
          iconName: component.link?.icon,
          rating: component.rating!.value,
          ratingType: component.rating!.type!,
          isFirst: !isPreviousComponentRating && isNextComponentRating,
          isMiddle: isPreviousComponentRating && isNextComponentRating,
          isLast: !isNextComponentRating && isPreviousComponentRating,
          onTap:
              (component.link?.href?.isNotEmpty ?? false)
                  ? () {
                    navigationService.productPageNavigate(
                      context,
                      product,
                      component.link!.href!,
                      component.link!.openInModal,
                    );
                  }
                  : null,
        );
      case ProductPageComponentType.shortcutBand:
        final List<ShortcutItem>? shortcuts =
            _filterOutHiddenLinks(component.links)?.map((link) {
              final backgroundColor =
                  (link.color?.isNotEmpty ?? false)
                      ? TingsColors.fromString(link.color!)
                      : TingsColors.primary;
              return ShortcutItem(
                backgroundColor: backgroundColor,
                color: TingsColors.textColorFromBackgroundColor(backgroundColor),
                iconName: link.icon ?? '',
                title: apiTranslate(link.title!),
                onTap: () {
                  if (link.href?.isNotEmpty ?? false) {
                    navigationService.productPageNavigate(
                      context,
                      product,
                      link.href!,
                      link.openInModal,
                    );
                  }
                },
              );
            }).toList();

        if (shortcuts != null && shortcuts.isNotEmpty) {
          return ShortcutList(shortcuts: shortcuts);
        }
        break;
      case ProductPageComponentType.message:
        final isValid = component.link?.title?.isNotEmpty ?? false;
        if (!isValid) break;

        final backgroundColor =
            (component.link?.color?.isNotEmpty ?? false)
                ? TingsColors.fromString(component.link!.color!)
                : TingsColors.grayMedium;

        return ProductMarketingMessage(
          backgroundColor: backgroundColor,
          textColor: TingsColors.textColorFromBackgroundColor(backgroundColor),
          imageUrl: component.cdnImages?.first.getThumbnail(),
          message: apiTranslate(component.link!.title!),
          onReadMore:
              component.link?.href?.isNotEmpty ?? false
                  ? () {
                    navigationService.productPageNavigate(
                      context,
                      product,
                      component.link!.href!,
                      component.link!.openInModal,
                    );
                  }
                  : null,
        );
      case ProductPageComponentType.menuItem:
        final isValid = component.link?.title?.isNotEmpty ?? false;
        if (!isValid) break;

        final index = components.indexOf(component);
        final isPreviousComponentMenuItem =
            index > 0 && components[index - 1].type == ProductPageComponentType.menuItem;

        return ProductMenuItem(
          title: apiTranslate(component.link!.title!),
          iconName: component.link?.icon,
          dividerTop: !isPreviousComponentMenuItem,
          onTap:
              component.link?.href?.isNotEmpty ?? false
                  ? () {
                    navigationService.productPageNavigate(
                      context,
                      product,
                      component.link!.href!,
                      component.link!.openInModal,
                    );
                  }
                  : null,
        );
      case ProductPageComponentType.htmlContent:
        final isValid = component.content?.isNotEmpty ?? false;
        if (!isValid) break;

        return HtmlContent(content: component.content!, clamping: component.clamping == true);
      case ProductPageComponentType.document:
        final isValid =
            (component.title?.isNotEmpty ?? false) && (component.link?.href?.isNotEmpty ?? false);
        if (!isValid) break;

        return ProductFile(
          title: component.title!,
          description: component.subTitle,
          fileUrl: component.link!.href!,
        );
      case ProductPageComponentType.actionLink:
        final isValid =
            (component.link?.title?.isNotEmpty ?? false) &&
            (component.link?.href?.isNotEmpty ?? false);
        if (!isValid) break;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: MainButton(
            onTap:
                () => navigationService.productPageNavigate(
                  context,
                  product,
                  component.link!.href!,
                  component.link!.openInModal,
                ),
            text: apiTranslate(component.link!.title!),
          ),
        );
      case ProductPageComponentType.keyValueTable:
        final isValid = component.tableContents?.isNotEmpty ?? false;
        if (!isValid) break;

        return KeyValueTable(
          title: apiTranslate(component.title),
          tableContents: component.tableContents!,
          allowCopy: component.allowCopy == true,
        );
      case ProductPageComponentType.addressBlock:
        final isValid =
            (component.title?.isNotEmpty ?? false) &&
            (component.contact?.location.isNotEmpty ?? false);
        if (!isValid) break;

        final index = components.indexOf(component);
        final isNextComponentAddress =
            components.length > index + 1 &&
            components[index + 1].type == ProductPageComponentType.addressBlock;
        return Address(
          title: component.title!,
          address: component.contact!.location,
          email: component.contact?.email,
          websiteUrl: component.contact?.website,
          phone: component.contact?.phone,
          iconName: component.link?.icon,
          showDivider: isNextComponentAddress,
        );
      case ProductPageComponentType.items:
        final isValid = (component.contentUrl?.isNotEmpty ?? false);
        if (!isValid) break;

        return ProductItems(productId: product.id, contentUrl: component.contentUrl!);
      case ProductPageComponentType.alert:
        final isValid = (component.title?.isNotEmpty ?? false);
        if (!isValid) break;

        final backgroundColor =
            (component.link?.color?.isNotEmpty ?? false)
                ? TingsColors.fromString(component.link!.color!)
                : TingsColors.blueMedium;

        return AlertMessage(
          title: apiTranslate(component.title!),
          subTitle: apiTranslate(component.subTitle),
          iconName: component.link?.icon,
          backgroundColor: backgroundColor,
          textColor: TingsColors.textColorFromBackgroundColor(backgroundColor),
          onTap:
              component.link?.href?.isNotEmpty ?? false
                  ? () {
                    navigationService.productPageNavigate(
                      context,
                      product,
                      component.link!.href!,
                      component.link!.openInModal,
                    );
                  }
                  : null,
        );
      case ProductPageComponentType.verifiedBanner:
        final isValid = product.brand.isNotBlank;
        if (!isValid) break;

        return VerifiedBanner(brandName: product.brand);
      case ProductPageComponentType.searchLinks:
        final isValid = component.searchLinksContent?.isNotEmpty ?? false;
        if (!isValid) break;

        return SearchLinks(links: component.searchLinksContent!, product: product);
      case ProductPageComponentType.buyButton:
        return AskAIButton(
          product: product,
          isOwned: product.isOwner,
        );

      case ProductPageComponentType.divider:
        final isValid = component.divider != null;
        if (!isValid) break;

        final color =
            component.divider!.color != null
                ? TingsColors.fromString(component.divider!.color!)
                : TingsColors.transparent;

        return TingDivider(height: component.divider!.height, color: color);

      case ProductPageComponentType.video:
        final isValid = component.video != null && component.video!.videoUrl.startsWith('http');
        if (!isValid) break;

        return VideoPreviewLink(
          videoUrl: component.video!.videoUrl,
          title: apiTranslate(component.video!.title),
          previewImage: component.video!.previewImage,
        );

      case ProductPageComponentType.shareButtons:
        final isValid = component.content.isNotBlank;
        if (!isValid) break;

        return ShareButtonsSection(content: component.content!);

      case ProductPageComponentType.productWebsite:
        final isLastComponent = (components.indexOf(component) + 1) == components.length;

        if (!isLastComponent) {
          Logger().w(
            'ProductWebsite component must be last element of a page, ${(components.indexOf(component) + 1)} , ${components.length}',
          );

          break;
        }

        final isValid = isLastComponent && component.contentUrl.isNotBlank;
        if (!isValid) break;

        return ProductWebsiteView(
          title: apiTranslate(component.title),
          url: component.contentUrl!,
          onFocus: () => scrollToBottom(),
          onScrollTop: () => scrollUp(),
        );
      default:
        throw UnimplementedError();
    }
  } catch (e, stack) {
    Logger().e(
      'Could not parse component ${component.type.toString()}',
      stackTrace: stack,
      error: e,
    );
  }

  return Container();
}

List<ProductPageComponentLinkModel>? _filterOutHiddenLinks(
  List<ProductPageComponentLinkModel>? links,
) => links?.where((link) => link.hidden != true).toList();
