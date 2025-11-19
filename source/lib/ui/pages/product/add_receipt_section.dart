import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/services/permissions_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';

class AddReceiptSection extends HookWidget {
  AddReceiptSection({super.key, required this.productInstanceId});

  final ImagePicker _picker = ImagePicker();
  final _myTingsRepository = locator<MyTingsRepository>();
  final _toastService = locator<ToastService>();
  final _permissionsService = locator<PermissionsService>();

  final String productInstanceId;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final imageFile = useState<XFile?>(null);

    Future<void> saveReceipt(XFile? image) async {
      if (image != null) {
        loading.value = true;
        try {
          await _myTingsRepository.addReceipt(
            productInstanceId,
            image.path,
            image.name,
          );

          _toastService.success(tr('product.receipt.added_message'));
          loading.value = false;
        } catch (e) {
          _toastService.error(e.toString(), 6);

          loading.value = false;
        }

        imageFile.value = image;
      }
    }

    return loading.value
        ? const Padding(
          padding: EdgeInsets.all(64),
          child: Center(child: CircularProgressIndicator()),
        )
        : Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageFile.value == null) ...[
                ElevatedButton.icon(
                  onPressed: () async {
                    final hasPermission =
                        await _permissionsService.requestCamera();

                    if (!hasPermission) return;

                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                    );

                    await saveReceipt(image);
                  },
                  icon: const TingIcon('camera_camera', height: 20),
                  label: Text(tr('product.image.camera')),
                  style: DesignSystemComponents.primaryButton(),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final hasPermission =
                        await _permissionsService.requestPhotos();

                    if (!hasPermission) return;

                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    await saveReceipt(image);
                  },
                  icon: const TingIcon('arrow_upload', height: 20),
                  label: Text(tr('product.image.upload')),
                  style: DesignSystemComponents.primaryButton(),
                ),
              ] else
                Flexible(
                  child: Stack(
                    children: [
                      Image.file(
                        File(imageFile.value!.path),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: GestureDetector(
                          onTap: () async {
                            await _myTingsRepository.deleteReceipt(
                              productInstanceId,
                            );

                            _toastService.success(
                              tr('product.receipt.deleted_message'),
                            );

                            imageFile.value = null;
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: TingsColors.white,
                            ),
                            child: const Center(
                              child: TingIcon('trash_trash-bin', height: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
  }
}
