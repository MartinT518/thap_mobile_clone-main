import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/permissions_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/tings_popup_menu.dart';
import 'package:thap/ui/pages/product/add_product_image.dart';
import 'package:thap/utilities/utilities.dart';

class ImageCarousel extends HookWidget {
  const ImageCarousel({
    super.key,
    required this.product,
    required this.cdnImages,
    this.deletableProductImages = const [],
    this.canUpload = false,
    this.small = false,
  });
  final List<CdnImage> cdnImages;
  final List<CdnImage> deletableProductImages;
  final bool canUpload;
  final ProductItem product;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final activePage = useState(0);
    final imagesInternal = useState<List<CdnImage>>([]);
    final totalElements = useState<int>(0);

    useEffect(() {
      imagesInternal.value = cdnImages.where((image) => image.url.startsWith('http')).toList();
      totalElements.value =
          canUpload ? imagesInternal.value.length + 1 : imagesInternal.value.length;
      return null;
    }, [cdnImages]);

    if (totalElements.value == 0) return Container();

    if (small) {
      return SizedBox(
        height: 100,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          itemCount: totalElements.value,
          itemBuilder: (BuildContext context, int index) {
            return _ImageWithMenu(
              small: true,
              image: imagesInternal.value[index],
              deletable:
                  deletableProductImages.any((i) => i.url == imagesInternal.value[index].url) &&
                  product.instanceId != null,
              productInstanceId: product.instanceId,
              onDelete: (image) {
                imagesInternal.value.remove(image);
                totalElements.value = totalElements.value - 1;
              },
            );
          },
        ),
      );
    }

    final pageController = usePageController(viewportFraction: 0.7, initialPage: 0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 29),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: totalElements.value,
              pageSnapping: true,
              controller: pageController,
              onPageChanged: (page) {
                activePage.value = page;
              },
              itemBuilder: (context, pagePosition) {
                final isAddImage = canUpload && pagePosition == totalElements.value - 1;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                      isAddImage
                          ? AddProductImage(
                            product: product,
                            onAddImage: (CdnImage image) {
                              imagesInternal.value = [...imagesInternal.value, image];
                              totalElements.value = totalElements.value + 1;

                              deletableProductImages.add(image);
                              //  canUploadInternal.value = false;
                            },
                          )
                          : _ImageWithMenu(
                            image: imagesInternal.value[pagePosition],
                            deletable:
                                deletableProductImages.any(
                                  (i) => i.url == imagesInternal.value[pagePosition].url,
                                ) &&
                                product.instanceId != null,
                            productInstanceId: product.instanceId,
                            onDelete: (imageUrl) {
                              imagesInternal.value.remove(imageUrl);
                              totalElements.value = totalElements.value - 1;
                            },
                          ),
                );
              },
            ),
          ),
          if (totalElements.value > 1)
            Padding(
              padding: const EdgeInsets.only(top: 29),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicators(totalElements.value, activePage.value, canUpload),
              ),
            ),
        ],
      ),
    );
  }
}

List<Widget> _buildIndicators(int imagesLength, int currentIndex, bool canUpload) {
  return List<Widget>.generate(imagesLength, (index) {
    final isUploadIndicator = canUpload && index + 1 == imagesLength;
    final indicatorDecoration = BoxDecoration(
      color: currentIndex == index ? TingsColors.black : TingsColors.grayMedium,
      shape: BoxShape.circle,
    );
    final uploadIndicatorDecoration = BoxDecoration(
      color: TingsColors.white,
      shape: BoxShape.circle,
      border: Border.all(
        width: 2,
        color: currentIndex == index ? TingsColors.black : TingsColors.grayMedium,
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      width: 8,
      height: 8,
      decoration: isUploadIndicator ? uploadIndicatorDecoration : indicatorDecoration,
    );
  });
}

Widget _renderImage(String url) {
  return TingsImage(url);
}

class _ImageWithMenu extends HookWidget {
  _ImageWithMenu({
    required this.image,
    required this.deletable,
    this.small = false,
    this.onDelete,
    this.productInstanceId,
  });

  final CdnImage image;
  final bool deletable;
  final bool small;
  final String? productInstanceId;
  final Function(CdnImage)? onDelete;

  final _toastService = locator<ToastService>();
  final _permissionsService = locator<PermissionsService>();

  @override
  Widget build(BuildContext context) {
    final tapDownPosition = useState<Offset?>(null);

    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        tapDownPosition.value = details.globalPosition;
      },
      onTap: () {
        _openImagePreview(image, context, deletable, productInstanceId, onDelete);
      },
      onLongPress: () {
        showTingsPopupMenu(
          context: context,
          tapDownPosition: tapDownPosition.value,
          items: _getImageMenuItems(),
          onItemSelected: _onImageMenuSelect,
        );
      },
      child: _renderImage(small ? image.getThumbnail() : image.getNormal()),
    );
  }

  void _onImageMenuSelect(value) async {
    if (value == 'save') {
      try {
        final hasPermission = await _permissionsService.requestPhotosAddOnly();

        if (hasPermission) {
          await GallerySaver.saveImage(image.url);
          _toastService.success(tr('product.image.saved_message'));
        }
      } on PlatformException catch (error) {
        Logger().e(error);
      }
    } else if (value == 'share') {
      final shareService = locator<ShareService>();

      // Download and save image temporarily
      final tempImage = await saveInternetFileTemp(image.url);
      await shareService.shareFile(tempImage.path);
      // Delete temp image after it is shared
      tempImage.delete();
    } else if (value == 'delete') {
      await _deleteProductImage(image, productInstanceId!, onDelete);
    }
  }

  List<TingsPopupMenuItem<String>> _getImageMenuItems() => [
    TingsPopupMenuItem(value: 'save', name: tr('product.image.save')),
    TingsPopupMenuItem(value: 'share', name: tr('product.image.share')),
    if (deletable) TingsPopupMenuItem(value: 'delete', name: tr('common.delete')),
  ];

  void _openImagePreview(
    CdnImage image,
    BuildContext context,
    bool deletable,
    String? productInstanceId,
    Function(CdnImage)? onDelete,
  ) {
    showTingsBottomSheet(
      context: context,
      showHeader: false,
      rounded: false,
      scrollable: false,
      closeButtonRightSide: false,
      child: ClipRect(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PhotoView.customChild(
                backgroundDecoration: const BoxDecoration(color: TingsColors.white),
                enableRotation: false,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                child: _renderImage(image.getFull()),
              ),
            ),
            Positioned(
              right: 15,
              top: 15,
              child: TingsKebabMenu<String>(
                items: _getImageMenuItems(),
                onItemSelected: _onImageMenuSelect,
                backgroundColor: TingsColors.grayMedium,
                opacity: 0.8,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _deleteProductImage(
  CdnImage image,
  String productInstanceId,
  Function(CdnImage)? onDelete,
) async {
  await locator<MyTingsRepository>().removeProductImage(productInstanceId, image);

  locator<ToastService>().success(tr('product.image.deleted_message'));

  if (onDelete != null) onDelete(image);
}
