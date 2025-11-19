import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/permissions_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/not_mytings_interaction_bottom_sheet.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class AddProductImage extends HookWidget {
  AddProductImage({
    super.key,
    required this.product,
    required this.onAddImage,
    this.showAddButton = true,
  });

  final ProductItem product;
  final Function(CdnImage) onAddImage;
  final bool showAddButton;

  final ImagePicker _picker = ImagePicker();
  final _myTingsRepository = locator<MyTingsRepository>();
  final _toastService = locator<ToastService>();
  final _permissionsService = locator<PermissionsService>();

  @override
  Widget build(BuildContext context) {
    final showFileSelection = useState<bool>(!showAddButton);
    final loading = useState(false);

    Future<void> saveImage(XFile? imageFile) async {
      if (imageFile != null) {
        loading.value = true;
        final image = await _myTingsRepository.addProductImage(
          product.instanceId!,
          imageFile.path,
          imageFile.name,
        );
        loading.value = false;

        if (image == null) {
          _toastService.error(tr('product.image.upload_error'));

          return;
        }

        _toastService.success(tr('product.image.added_message'));
        showFileSelection.value = !showAddButton;
        onAddImage(image);
      }
    }

    if (!showFileSelection.value) {
      return Material(
        color: TingsColors.grayLight,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () async {
            if (product.instanceId == null) {
              showNotMyTingsInteractionBottomSheet(
                context: context,
                product: product,
              );
            } else {
              showFileSelection.value = true;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TingIcon(
                'general_add-plus',
                height: 50,
                color: TingsColors.black,
              ),
              const SizedBox(height: 12),
              Heading4(tr('product.image.add')),
            ],
          ),
        ),
      );
    } else {
      return loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final hasPermission =
                      await _permissionsService.requestCamera();

                  if (!hasPermission) return;

                  final XFile? imageFile = await _picker.pickImage(
                    source: ImageSource.camera,
                  );

                  await saveImage(imageFile);
                },
                icon: const TingIcon('camera_camera', height: 20),
                label: Text(tr('product.image.camera')),
                style: DesignSystemComponents.primaryButton(),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () async {
                  final hasPermission =
                      await _permissionsService.requestPhotos();

                  if (!hasPermission) return;

                  final XFile? imageFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  await saveImage(imageFile);
                },
                icon: const TingIcon('arrow_upload', height: 20),
                label: Text(tr('product.image.upload')),
                style: DesignSystemComponents.primaryButton(),
              ),
            ],
          );
    }
  }
}
