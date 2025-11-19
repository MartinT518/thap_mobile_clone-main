import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/common/pdf_viewer.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ProductFile extends StatelessWidget {
  const ProductFile({
    super.key,
    required this.title,
    this.description,
    required this.fileUrl,
  });

  final String title;
  final String? description;
  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    final shareService = locator<ShareService>();
    final openerService = locator<OpenerService>();
    final navigationService = locator<NavigationService>();

    final isPdf = fileUrl.endsWith('.pdf');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      //height: 190,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 24),
                child: const TingIcon('files_file-text', height: 41),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading3(
                      title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null)
                      ContentSmall(
                        description!,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    await shareService.shareText(fileUrl);
                  },
                  style: DesignSystemComponents.secondaryButton(),
                  child: Text(tr('common.share')),
                ),
              ),
              const SizedBox(width: 15),
              if (isPdf)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      navigationService.push(PdfViewer(url: fileUrl));
                    },
                    style: DesignSystemComponents.primaryButton(),
                    child: Text(tr('common.open')),
                  ),
                )
              else
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await openerService.openExternalBrowser(fileUrl);
                    },
                    style: DesignSystemComponents.primaryButton(),
                    child: Text(tr('common.download')),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
