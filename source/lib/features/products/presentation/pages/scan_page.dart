import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/features/products/presentation/providers/scan_provider.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/utilities/utilities.dart';
import 'package:vibration/vibration.dart';

/// Scan page for QR code and barcode scanning
class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  late MobileScannerController _controller;
  final List<String> _scanHistory = [];
  final List<String> _buffer = [];
  bool _isProcessing = false;

  static const List<BarcodeFormat> _supportedFormats = [
    BarcodeFormat.upcA,
    BarcodeFormat.upcE,
    BarcodeFormat.ean13,
    BarcodeFormat.ean8,
    BarcodeFormat.qrCode,
  ];

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      autoStart: true,
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 500,
      formats: _supportedFormats,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _convertBarcodeFormat(BarcodeFormat format) {
    switch (format) {
      case BarcodeFormat.qrCode:
        return 'QR';
      case BarcodeFormat.ean13:
        return 'EAN_13';
      case BarcodeFormat.ean8:
        return 'EAN_8';
      case BarcodeFormat.upcA:
        return 'UPC_A';
      case BarcodeFormat.upcE:
        return 'UPC_E';
      default:
        return null;
    }
  }

  Future<void> _handleBarcodeDetected(BarcodeCapture capture) async {
    if (capture.barcodes.isEmpty) return;
    final barcode = capture.barcodes.first;
    if (barcode.rawValue == null) return;

    final barcodeRaw = barcode.rawValue!;
    if (barcodeRaw.isEmpty) return;

    // Skip if already processing or in history
    if (_isProcessing || _scanHistory.contains(barcodeRaw)) {
      return;
    }

    // Buffer to ensure accurate read (need 5 consistent reads)
    if (_buffer.where((bc) => bc == barcodeRaw).length < 5) {
      _buffer.add(barcodeRaw);
      return;
    }

    _isProcessing = true;
    final format = _convertBarcodeFormat(barcode.format);

    if (format != null) {
      // Success vibration
      await vibrate(duration: 400);

      // Scan the code
      await ref.read(scanNotifierProvider.notifier).scanQrCode(barcodeRaw, format);
    } else {
      // Not found pattern vibration
      await vibrate(duration: 200);
      await Future.delayed(const Duration(milliseconds: 400));
      await vibrate(duration: 200);

      _isProcessing = false;
      _buffer.clear();
      _scanHistory.add(barcodeRaw);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanNotifierProvider);
    final size = MediaQuery.of(context).size;

    // Listen for success state and navigate
    ref.listen<ScanState>(scanNotifierProvider, (previous, next) {
      next.maybeWhen(
        success: (product) {
          // Navigate to product detail page
          context.go('/product/${product.id}');
          // Reset state after navigation
          Future.delayed(const Duration(milliseconds: 300), () {
            ref.read(scanNotifierProvider.notifier).reset();
          });
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Camera view
          MobileScanner(
            controller: _controller,
            onDetect: _handleBarcodeDetected,
          ),
          // Overlay with rectangle clipping
          _buildOverlay(),
          // Scanning frame
          _buildScanningFrame(),
          // Status message
          SafeArea(
            bottom: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildStatusMessage(scanState),
            ),
          ),
          // Instruction text
          Positioned(
            top: (size.height * 0.5) - (325 / 2) - 50,
            child: Text(
              tr('scan.instruction_message'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          // Back button
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),
          // Loading indicator
          if (scanState is _Processing || scanState is _Scanning)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _buildScanningFrame() {
    return Container(
      width: 325,
      height: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget? _buildStatusMessage(ScanState state) {
    return state.maybeWhen(
      notFound: () => _buildMessage(
        tr('scan.not_found_message'),
        AppTheme.errorColor,
      ),
      processing: () => _buildMessage(
        tr('scan.searching_message'),
        AppTheme.primaryColor,
      ),
      orElse: () => null,
    );
  }

  Widget _buildMessage(String message, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingL,
        vertical: AppTheme.spacingM,
      ),
      margin: const EdgeInsets.only(bottom: AppTheme.spacingXXL),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

