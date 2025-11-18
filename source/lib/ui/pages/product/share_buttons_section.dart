import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';

class ShareButtonsSection extends HookWidget {
  const ShareButtonsSection({
    super.key,
    required this.content,
    this.copyLinkUrl,
  });

  final String content;
  final String? copyLinkUrl;

  @override
  Widget build(BuildContext context) {
    final toastService = locator<ToastService>();
    final shareService = locator<ShareService>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: TingsColors.grayLight,
      child: Row(
        children: [
          LightButton(
            onTap:
                () => Clipboard.setData(
                  ClipboardData(
                    text: copyLinkUrl.isNotBlank ? copyLinkUrl! : content,
                  ),
                ).then((_) => toastService.success(tr('common.value_copied'))),
            text: tr('product.copy_link'),
            iconName: 'files_file-copy',
            expand: true,
          ),
          const SizedBox(width: 8),
          LightButton(
            onTap: () => shareService.shareText(content),
            text: tr('product.share.share_to'),
            iconName: 'interface_share',
            expand: true,
          ),
        ],
      ),
    );
  }
}
