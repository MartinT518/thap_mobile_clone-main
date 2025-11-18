import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';

class PermissionsService {
  final _toastService = locator<ToastService>();

  Future<bool> requestPhotosAddOnly() async {
    if (Platform.isAndroid) return true; // iOS only permission

    final isGranted = await Permission.photosAddOnly.request().isGranted;

    if (!isGranted) {
      _toastService.error(tr('permissions.image_save_denied'));
    }

    return isGranted;
  }

  Future<bool> requestPhotos() async {
    final isGranted = await Permission.photos.request().isGranted;

    if (!isGranted) {
      _toastService.error(tr('permissions.photos_access_denied'));
    }
    return isGranted;
  }

  Future<bool> requestCamera() async {
    final isGranted = await Permission.camera.request().isGranted;

    if (!isGranted) {
      _toastService.error(tr('permissions.camera_access_denied'));
    }
    return isGranted;
  }
}
