import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';

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
          Expanded(
            child: OutlinedButton.icon(
              onPressed:
                  () => Clipboard.setData(
                    ClipboardData(
                      text: copyLinkUrl.isNotBlank ? copyLinkUrl! : content,
                    ),
                  ).then((_) => toastService.success(tr('common.value_copied'))),
              icon: TingIcon('files_file-copy', height: 20),
              label: Text(tr('product.copy_link')),
              style: DesignSystemComponents.secondaryButton(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => shareService.shareText(content),
              icon: TingIcon('interface_share', height: 20),
              label: Text(tr('product.share.share_to')),
              style: DesignSystemComponents.secondaryButton(),
            ),
          ),
        ],
      ),
    );
  }
}
