import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/utilities/utilities.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.url});

  final String url;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch _pdfControllerPinch;
  final openerService = locator<OpenerService>();

  @override
  void initState() {
    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(geInternetFileBytes(widget.url)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfControllerPinch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(
        showBackButton: true,
        rightWidget: Padding(
          padding: const EdgeInsets.only(right: 12, bottom: 4),
          child: TextButton(
            onPressed: () async {
              await openerService.openExternalBrowser(widget.url);
            },
            child: ContentBig(tr('common.download')),
          ),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: PdfViewPinch(
          builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
            pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, error) => Center(child: ContentBig(error.toString())),
          ),
          controller: _pdfControllerPinch,
        ),
      ),
    );
  }
}
