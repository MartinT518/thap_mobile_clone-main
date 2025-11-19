import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tap_area.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/utilities/utilities.dart';

class ScanPage extends HookWidget {
  const ScanPage({super.key, this.isDebugMode = false});

  final bool isDebugMode;

  static const List<BarcodeFormat> _supportedFormats = [
    BarcodeFormat.upcA,
    BarcodeFormat.upcE,
    BarcodeFormat.ean13,
    BarcodeFormat.ean8,
    BarcodeFormat.qrCode,
  ];

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => MobileScannerController(
        autoStart: true,
        facing: CameraFacing.back,
        detectionSpeed: DetectionSpeed.normal,
        detectionTimeoutMs: 500,
        formats: _supportedFormats,
      ),
      [],
    );

    useEffect(() {
      Logger().i('ScanPage: Starting camera controller');

      return () async {
        Logger().i('ScanPage: Stopping camera controller');

        await controller.dispose();
      };
    }, []);

    final navigationService = locator<NavigationService>();

    final size = MediaQuery.of(context).size;
    final isSearching = useState<bool>(false);
    final isProductNotFound = useState<bool>(false);
    final lastDebugBarcode = useState<String?>(null);
    final isProcessing = useState<bool>(false);
    // Buffer barcode scan results to get more accurate read
    final buffer = useState<List<String>>([]);
    final scanHistory = useState<List<String>>([]);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: MobileScanner(
              controller: controller,
              onDetectError:
                  (error, stackTrace) =>
                      Logger().e('Scan detect error: $error', error: error, stackTrace: stackTrace),
              onDetect: (result) async {
                final barcode = result.barcodes.firstOrNull;

                if (isProcessing.value ||
                    barcode == null ||
                    barcode.rawValue.isBlank ||
                    scanHistory.value.contains(barcode.rawValue)) {
                  return;
                }

                final barcodeRaw = barcode.rawValue!;

                if (buffer.value.where((bc) => bc == barcodeRaw).length < 5) {
                  buffer.value.add(barcodeRaw);

                  return;
                }

                // Processing barcode: ${barcode.rawValue} ${barcode.format}

                isProcessing.value = true;

                final BarcodeFormat rawFormat = barcode.format;
                final String? format = convertBarcodeFormat(rawFormat);

                lastDebugBarcode.value = 'Format=${barcode.format.name}, Code=${barcode.rawValue}';

                if (format != null && !isDebugMode) {
                  // Success vibration
                  await vibrate(duration: 400);
                  try {
                    isSearching.value = true;
                    final result = await locator<ProductsRepository>().scan(barcodeRaw, format);

                    if (result != null) {
                      await navigationService.openProduct(result, context.locale.languageCode);

                      return;
                    }
                  } catch (_) {}
                }

                if (!isDebugMode) {
                  // Not found pattern vibration
                  await vibrate(duration: 200);
                  await Future.delayed(const Duration(milliseconds: 400));
                  await vibrate(duration: 200);
                }

                isProductNotFound.value = true;
                isSearching.value = false;
                isProcessing.value = false;
                buffer.value = [];
                scanHistory.value.add(barcodeRaw);

                // Barcode processed: Code: $barcodeRaw, Format: $format
              },
            ),
          ),
          const OverlayWithRectangleClipping(),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 325,
              height: 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  isDebugMode
                      ? _buildDebugMessage(lastDebugBarcode.value)
                      : isProductNotFound.value
                      ? _buildStatusMessage(tr('scan.not_found_message'), TingsColors.red)
                      : isSearching.value
                      ? _buildStatusMessage(tr('scan.searching_message'), TingsColors.black)
                      : null,
            ),
          ),
          Positioned(
            top: (size.height * 0.5) - (325 / 2) - 50,
            child: Heading3(tr('scan.instruction_message'), color: TingsColors.white),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 18),
                child: RowHitTestWithoutSizeLimit(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TapArea(
                      extraTapArea: const EdgeInsets.all(0),
                      onTap: () => navigationService.pop(),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 27, top: 24, right: 24, bottom: 24),
                        child: TingIcon('general_arrow-left', width: 24, color: TingsColors.white),
                      ),
                    ),
                    // SvgPicture.asset(
                    //   "assets/icons/notification_question.svg",
                    //   width: 20,
                    //   color: TingsColors.white,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          if (isSearching.value)
            Align(
              child: Transform.scale(
                scale: 1.5,
                child: const RefreshProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDebugMessage(String? lastDebugBarcode) {
    if (lastDebugBarcode?.isEmpty ?? true) return Container();
    return GestureDetector(
      onTap: () {
        Clipboard.setData(
          ClipboardData(text: lastDebugBarcode),
        ).then((_) => locator<ToastService>().success(tr('common.value_copied')));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, left: 8, right: 8),
        // height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: TingsColors.orange,
        ),
        child: ContentBig(lastDebugBarcode!, color: TingsColors.white, textAlign: TextAlign.center),
      ),
    );
  }

  Container _buildStatusMessage(String message, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: color,
      ),
      child: ContentBig(message, color: TingsColors.white),
    );
  }

  String? convertBarcodeFormat(BarcodeFormat rawFormat) {
    switch (rawFormat) {
      case BarcodeFormat.upcA:
        return 'UPC_A';
      case BarcodeFormat.ean13:
        return 'EAN_13';
      case BarcodeFormat.ean8:
        return 'EAN_8';
      case BarcodeFormat.upcE:
        return 'UPC_E';
      case BarcodeFormat.qrCode:
        return 'QR';
      default:
        return null;
    }
  }
}

class OverlayWithRectangleClipping extends StatelessWidget {
  const OverlayWithRectangleClipping({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: MediaQuery.of(context).size, painter: RectanglePainter());
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset(size.width * 0.5, size.height * 0.5),
                width: 325,
                height: 325,
              ),
              const Radius.circular(16),
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
