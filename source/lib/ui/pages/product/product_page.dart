import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
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

/// Refactored ProductPage - Clean implementation with comprehensive error handling
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
    final navigationService = locator<NavigationService>();

    useEffect(() {
      if (openAction?.isNotEmpty ?? false) {
        // Delay to ensure widget tree is built
        Timer.run(() {
          try {
            if (context.mounted) {
              navigationService.productPageNavigate(context, product, openAction!);
            }
          } catch (e) {
            Logger().e('Error navigating to action: $e');
          }
        });
      }
      return null;
    }, [openAction]);

    Logger().i('ProductPage: pageId=${page.pageId}, productId=${product.id}');

    return WillPopScope(
      onWillPop: () async {
        if (!navigateToRootOnPop) return true;
        try {
          navigationService.popToRoot();
        } catch (e) {
          Logger().e('Error popping to root: $e');
        }
        return false;
      },
      child: Builder(
        builder: (BuildContext context) {
          if (isModal) {
            return _ProductPageContent(page: page, product: product);
          }

          final myTingsStore = locator<MyTingsStore>();
          final ting = myTingsStore.getTing(product.id);
          final showTitle = page.pageId != 'root' && page.pageId != 'preview';
          final displayName = (ting?.nickname?.isNotEmpty ?? false) 
              ? ting!.nickname! 
              : product.name;

          return Scaffold(
            appBar: AppHeaderBar(
              title: showTitle ? displayName : null,
              subTitle: showTitle ? apiTranslate(page.title) : null,
              logo: _buildLogo(),
              showBackButton: true,
              onNavigateBack: () {
                try {
                  if (navigateToRootOnPop) {
                    navigationService.popToRoot();
                  } else {
                    navigationService.pop();
                  }
                } catch (e) {
                  Logger().e('Error navigating back: $e');
                }
              },
              rightWidget: _buildAppBarActions(showTitle, ting != null),
            ),
            bottomNavigationBar: ting == null ? _buildBottomBar(context) : null,
            body: SafeArea(
              child: Container(
                color: TingsColors.white,
                child: _ProductPageContent(page: page, product: product),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? _buildLogo() {
    try {
      if (page.pageId == 'root' || page.pageId == 'preview') {
        if (product.brandLogoUrl.isNotBlank && product.externalProductType == null) {
          return TingsImage(
            product.brandLogoUrl!,
            alignment: Alignment.centerLeft,
            height: 28,
          );
        }
      }
    } catch (e) {
      Logger().e('Error building logo: $e');
    }
    return null;
  }

  Widget _buildAppBarActions(bool showTitle, bool showMoreMenu) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!showTitle)
          _ErrorBoundary(
            child: ProductInfoShareButton(product: product),
          ),
        if (showMoreMenu)
          _ErrorBoundary(
            child: TingProductMoreMenu(product: product),
          )
        else
          const SizedBox(width: 27),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
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
              onTap: () {
                try {
                  navigationService.push(const ScanPage());
                } catch (e) {
                  Logger().e('Error opening scan page: $e');
                }
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
            Expanded(
              child: _ErrorBoundary(
                child: AddToMyTingsButton(product: product),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Content widget with error handling
class _ProductPageContent extends HookWidget {
  const _ProductPageContent({
    required this.page,
    required this.product,
  });

  final ProductPageModel page;
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    // Validate components before building
    final validComponents = page.components.where((c) => c.type != null).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      itemCount: validComponents.length,
      itemBuilder: (context, index) {
        final component = validComponents[index];
        
        // Skip hidden components
        if (component.hidden == true) {
          return const SizedBox.shrink();
        }

        return _ErrorBoundary(
          child: _ComponentBuilder(
            component: component,
            product: product,
            allComponents: validComponents,
            userImages: page.userImages,
            scrollController: scrollController,
          ),
        );
      },
    );
  }
}

/// Error boundary widget - catches and handles all exceptions
class _ErrorBoundary extends StatelessWidget {
  const _ErrorBoundary({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        try {
          return child;
        } catch (e, stack) {
          Logger().e('ErrorBoundary caught exception: $e', stackTrace: stack);
          return const SizedBox.shrink();
        }
      },
    );
  }
}

/// Safe component builder with comprehensive error handling
class _ComponentBuilder extends StatelessWidget {
  const _ComponentBuilder({
    required this.component,
    required this.product,
    required this.allComponents,
    required this.userImages,
    required this.scrollController,
  });

  final ProductPageComponentModel component;
  final ProductItem product;
  final List<ProductPageComponentModel> allComponents;
  final List<CdnImage> userImages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    // Double error boundary - outer catches build errors, inner catches runtime errors
    return Builder(
      builder: (context) {
        try {
          return _buildComponentSafely(context);
        } catch (e, stack) {
          Logger().e(
            'Error building component ${component.type}: $e',
            stackTrace: stack,
          );
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildComponentSafely(BuildContext context) {
    final navigationService = locator<NavigationService>();

    // Validate component type
    if (component.type == null) {
      return const SizedBox.shrink();
    }

    switch (component.type!) {
      case ProductPageComponentType.title:
        return _buildTitle();
      case ProductPageComponentType.sectionTitle:
        return _buildSectionTitle();
      case ProductPageComponentType.imageCarusel:
        return _buildImageCarousel();
      case ProductPageComponentType.buyButton:
        return _buildBuyButton();
      case ProductPageComponentType.keyValueTable:
        return _buildKeyValueTable();
      case ProductPageComponentType.htmlContent:
        return _buildHtmlContent();
      case ProductPageComponentType.actionButtons:
        return _buildActionButtons(context, navigationService);
      case ProductPageComponentType.actionLink:
        return _buildActionLink(context, navigationService);
      case ProductPageComponentType.menuItem:
        return _buildMenuItem(context, navigationService);
      case ProductPageComponentType.rating:
        return _buildRating(context, navigationService);
      case ProductPageComponentType.shortcutBand:
        return _buildShortcutBand(context, navigationService);
      case ProductPageComponentType.message:
        return _buildMessage(context, navigationService);
      case ProductPageComponentType.document:
        return _buildDocument();
      case ProductPageComponentType.addressBlock:
        return _buildAddress();
      case ProductPageComponentType.items:
        return _buildItems();
      case ProductPageComponentType.alert:
        return _buildAlert(context, navigationService);
      case ProductPageComponentType.verifiedBanner:
        return _buildVerifiedBanner();
      case ProductPageComponentType.searchLinks:
        return _buildSearchLinks();
      case ProductPageComponentType.divider:
        return _buildDivider();
      case ProductPageComponentType.video:
        return _buildVideo();
      case ProductPageComponentType.shareButtons:
        return _buildShareButtons();
      case ProductPageComponentType.productWebsite:
        return _buildProductWebsite(context);
      default:
        Logger().w('Unhandled component type: ${component.type}');
        return const SizedBox.shrink();
    }
  }

  Widget _buildTitle() {
    try {
      final hasTitle = component.title.isNotBlank;
      final hasSubTitle = component.subTitle.isNotBlank;
      
      if (!hasTitle && !hasSubTitle) {
        return const SizedBox.shrink();
      }

      return ProductTitle(
        title: apiTranslate(component.title),
        subTitle: apiTranslate(component.subTitle),
      );
    } catch (e) {
      Logger().e('Error building title: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildSectionTitle() {
    try {
      if (component.title.isBlank) {
        return const SizedBox.shrink();
      }

      return SectionTitle(title: apiTranslate(component.title));
    } catch (e) {
      Logger().e('Error building section title: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildImageCarousel() {
    try {
      return ImageCarousel(
        product: product,
        cdnImages: component.cdnImages ?? [],
        canUpload: component.canUpload == true,
        deletableProductImages: userImages,
      );
    } catch (e) {
      Logger().e('Error building image carousel: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildBuyButton() {
    try {
      return AskAIButton(product: product, isOwned: product.isOwner);
    } catch (e) {
      Logger().e('Error building buy button: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildKeyValueTable() {
    try {
      if (component.tableContents?.isEmpty ?? true) {
        return const SizedBox.shrink();
      }

      return KeyValueTable(
        title: apiTranslate(component.title),
        tableContents: component.tableContents!,
        allowCopy: component.allowCopy == true,
      );
    } catch (e) {
      Logger().e('Error building key value table: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildHtmlContent() {
    try {
      if (component.content.isBlank) {
        return const SizedBox.shrink();
      }

      return HtmlContent(
        content: component.content!,
        clamping: component.clamping == true,
      );
    } catch (e) {
      Logger().e('Error building HTML content: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildActionButtons(BuildContext context, NavigationService navigationService) {
    try {
      final links = _filterHiddenLinks(component.links);
      if (links?.isEmpty ?? true) {
        return const SizedBox.shrink();
      }

      final actions = links!
          .map((link) {
            try {
              return ProductAction(
                text: apiTranslate(link.title),
                icon: link.icon,
                onTap: () {
                  try {
                    if (link.href?.isNotEmpty ?? false) {
                      navigationService.productPageNavigate(
                        context,
                        product,
                        link.href!,
                        link.openInModal,
                      );
                    }
                  } catch (e) {
                    Logger().e('Error in action button tap: $e');
                  }
                },
              );
            } catch (e) {
              Logger().e('Error creating action: $e');
              return null;
            }
          })
          .whereType<ProductAction>()
          .toList();

      if (actions.isEmpty) {
        return const SizedBox.shrink();
      }

      return ProductActionButtonsList(actions: actions, showTopShadow: true);
    } catch (e) {
      Logger().e('Error building action buttons: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildActionLink(BuildContext context, NavigationService navigationService) {
    try {
      final link = component.link;
      if (link == null) {
        return const SizedBox.shrink();
      }
      
      final titleEmpty = link.title == null || link.title!.isEmpty;
      final hrefEmpty = link.href == null || link.href!.isEmpty;
      
      if (titleEmpty || hrefEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              try {
                navigationService.productPageNavigate(
                  context,
                  product,
                  link.href!,
                  link.openInModal,
                );
              } catch (e) {
                Logger().e('Error in action link tap: $e');
              }
            },
            style: DesignSystemComponents.primaryButton(),
            child: Text(apiTranslate(link.title!)),
          ),
        ),
      );
    } catch (e) {
      Logger().e('Error building action link: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildMenuItem(BuildContext context, NavigationService navigationService) {
    try {
      final link = component.link;
      if (link == null || link.title.isBlank) {
        return const SizedBox.shrink();
      }

      final index = allComponents.indexOf(component);
      final isPreviousMenuItem = index > 0 &&
          allComponents[index - 1].type == ProductPageComponentType.menuItem;

      return ProductMenuItem(
        title: apiTranslate(link.title!),
        iconName: link.icon,
        dividerTop: !isPreviousMenuItem,
        onTap: link.href.isNotBlank
            ? () {
                try {
                  navigationService.productPageNavigate(
                    context,
                    product,
                    link.href!,
                    link.openInModal,
                  );
                } catch (e) {
                  Logger().e('Error in menu item tap: $e');
                }
              }
            : null,
      );
    } catch (e) {
      Logger().e('Error building menu item: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildRating(BuildContext context, NavigationService navigationService) {
    try {
      final link = component.link;
      if (link == null || 
          link.title.isBlank ||
          component.rating == null ||
          component.rating?.type == null) {
        return const SizedBox.shrink();
      }

      final index = allComponents.indexOf(component);
      final isPreviousRating = index > 0 &&
          allComponents[index - 1].type == ProductPageComponentType.rating;
      final isNextRating = index + 1 < allComponents.length &&
          allComponents[index + 1].type == ProductPageComponentType.rating;

      final rating = component.rating;
      if (rating == null || rating.type == null) {
        return const SizedBox.shrink();
      }
      
      return ProductRating(
        title: apiTranslate(link.title!),
        iconName: link.icon,
        rating: rating.value,
        ratingType: rating.type!,
        isFirst: !isPreviousRating && isNextRating,
        isMiddle: isPreviousRating && isNextRating,
        isLast: !isNextRating && isPreviousRating,
        onTap: link.href.isNotBlank
            ? () {
                try {
                  navigationService.productPageNavigate(
                    context,
                    product,
                    link.href!,
                    link.openInModal,
                  );
                } catch (e) {
                  Logger().e('Error in rating tap: $e');
                }
              }
            : null,
      );
    } catch (e) {
      Logger().e('Error building rating: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShortcutBand(BuildContext context, NavigationService navigationService) {
    try {
      final links = _filterHiddenLinks(component.links);
      if (links?.isEmpty ?? true) {
        return const SizedBox.shrink();
      }

      final shortcuts = links!
          .map((link) {
            try {
              final backgroundColor = (link.color?.isNotEmpty ?? false)
                  ? TingsColors.fromString(link.color!)
                  : TingsColors.primary;
              return ShortcutItem(
                backgroundColor: backgroundColor,
                color: TingsColors.textColorFromBackgroundColor(backgroundColor),
                iconName: link.icon ?? '',
                title: apiTranslate(link.title!),
                onTap: () {
                  try {
                    if (link.href?.isNotEmpty ?? false) {
                      navigationService.productPageNavigate(
                        context,
                        product,
                        link.href!,
                        link.openInModal,
                      );
                    }
                  } catch (e) {
                    Logger().e('Error in shortcut tap: $e');
                  }
                },
              );
            } catch (e) {
              Logger().e('Error creating shortcut: $e');
              return null;
            }
          })
          .whereType<ShortcutItem>()
          .toList();

      if (shortcuts.isEmpty) {
        return const SizedBox.shrink();
      }

      return ShortcutList(shortcuts: shortcuts);
    } catch (e) {
      Logger().e('Error building shortcut band: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildMessage(BuildContext context, NavigationService navigationService) {
    try {
      final link = component.link;
      if (link == null || link.title.isBlank) {
        return const SizedBox.shrink();
      }

      final backgroundColor = link.color.isNotBlank
          ? TingsColors.fromString(link.color!)
          : TingsColors.grayMedium;

      final cdnImages = component.cdnImages;
      final imageUrl = (cdnImages?.isNotEmpty ?? false)
          ? cdnImages!.first.getThumbnail()
          : null;
      
      return ProductMarketingMessage(
        backgroundColor: backgroundColor,
        textColor: TingsColors.textColorFromBackgroundColor(backgroundColor),
        imageUrl: imageUrl,
        message: apiTranslate(link.title!),
        onReadMore: link.href.isNotBlank
            ? () {
                try {
                  navigationService.productPageNavigate(
                    context,
                    product,
                    link.href!,
                    link.openInModal,
                  );
                } catch (e) {
                  Logger().e('Error in message read more: $e');
                }
              }
            : null,
      );
    } catch (e) {
      Logger().e('Error building message: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildDocument() {
    try {
      final link = component.link;
      if (component.title.isBlank || link == null || link.href.isBlank) {
        return const SizedBox.shrink();
      }

      return ProductFile(
        title: component.title!,
        description: component.subTitle,
        fileUrl: link.href!,
      );
    } catch (e) {
      Logger().e('Error building document: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAddress() {
    try {
      final contact = component.contact;
      if (component.title.isBlank || contact == null || contact.location.isEmpty) {
        return const SizedBox.shrink();
      }

      final index = allComponents.indexOf(component);
      final isNextAddress = index + 1 < allComponents.length &&
          allComponents[index + 1].type == ProductPageComponentType.addressBlock;

      return Address(
        title: component.title!,
        address: contact.location,
        email: contact.email,
        websiteUrl: contact.website,
        phone: contact.phone,
        iconName: component.link?.icon,
        showDivider: isNextAddress,
      );
    } catch (e) {
      Logger().e('Error building address: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildItems() {
    try {
      if (component.contentUrl.isBlank) {
        return const SizedBox.shrink();
      }

      return ProductItems(productId: product.id, contentUrl: component.contentUrl!);
    } catch (e) {
      Logger().e('Error building items: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAlert(BuildContext context, NavigationService navigationService) {
    try {
      final link = component.link;
      if (component.title.isBlank) {
        return const SizedBox.shrink();
      }

      final backgroundColor = link?.color.isNotBlank == true
          ? TingsColors.fromString(link!.color!)
          : TingsColors.blueMedium;

      return AlertMessage(
        title: apiTranslate(component.title!),
        subTitle: apiTranslate(component.subTitle),
        iconName: link?.icon,
        backgroundColor: backgroundColor,
        textColor: TingsColors.textColorFromBackgroundColor(backgroundColor),
        onTap: link?.href.isNotBlank == true
            ? () {
                try {
                  navigationService.productPageNavigate(
                    context,
                    product,
                    link!.href!,
                    link.openInModal,
                  );
                } catch (e) {
                  Logger().e('Error in alert tap: $e');
                }
              }
            : null,
      );
    } catch (e) {
      Logger().e('Error building alert: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildVerifiedBanner() {
    try {
      if (product.brand.isEmpty) {
        return const SizedBox.shrink();
      }

      return VerifiedBanner(brandName: product.brand);
    } catch (e) {
      Logger().e('Error building verified banner: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildSearchLinks() {
    try {
      if (component.searchLinksContent?.isEmpty ?? true) {
        return const SizedBox.shrink();
      }

      return SearchLinks(links: component.searchLinksContent!, product: product);
    } catch (e) {
      Logger().e('Error building search links: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildDivider() {
    try {
      final divider = component.divider;
      if (divider == null) {
        return const SizedBox.shrink();
      }

      final color = divider.color.isNotBlank
          ? TingsColors.fromString(divider.color!)
          : TingsColors.transparent;

      return TingDivider(height: divider.height, color: color);
    } catch (e) {
      Logger().e('Error building divider: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildVideo() {
    try {
      final video = component.video;
      if (video == null || !video.videoUrl.startsWith('http')) {
        return const SizedBox.shrink();
      }

      return VideoPreviewLink(
        videoUrl: video.videoUrl,
        title: apiTranslate(video.title),
        previewImage: video.previewImage,
      );
    } catch (e) {
      Logger().e('Error building video: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShareButtons() {
    try {
      if (component.content.isBlank) {
        return const SizedBox.shrink();
      }

      return ShareButtonsSection(content: component.content!);
    } catch (e) {
      Logger().e('Error building share buttons: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildProductWebsite(BuildContext context) {
    try {
      final index = allComponents.indexOf(component);
      final isLast = index + 1 == allComponents.length;

      if (!isLast) {
        Logger().w(
          'ProductWebsite must be last component. Position: ${index + 1}/${allComponents.length}',
        );
        return const SizedBox.shrink();
      }

      if (component.contentUrl.isBlank) {
        return const SizedBox.shrink();
      }

      // Safe scroll controller access
      void safeScrollToBottom() {
        try {
          if (scrollController.hasClients && scrollController.position.hasContentDimensions) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        } catch (e) {
          Logger().e('Error scrolling to bottom: $e');
        }
      }

      void safeScrollUp() {
        try {
          if (scrollController.hasClients && scrollController.position.hasContentDimensions) {
            final screenHeight = MediaQuery.of(context).size.height;
            final target = scrollController.position.maxScrollExtent - screenHeight + 95;
            if (target >= 0) {
              scrollController.animateTo(
                target,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            }
          }
        } catch (e) {
          Logger().e('Error scrolling up: $e');
        }
      }

      return ProductWebsiteView(
        title: apiTranslate(component.title),
        url: component.contentUrl!,
        onFocus: safeScrollToBottom,
        onScrollTop: safeScrollUp,
      );
    } catch (e) {
      Logger().e('Error building product website: $e');
      return const SizedBox.shrink();
    }
  }

  List<ProductPageComponentLinkModel>? _filterHiddenLinks(
      List<ProductPageComponentLinkModel>? links) {
    try {
      return links?.where((link) => link.hidden != true).toList();
    } catch (e) {
      Logger().e('Error filtering hidden links: $e');
      return null;
    }
  }
}
