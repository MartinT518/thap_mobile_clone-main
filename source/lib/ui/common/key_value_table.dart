import 'package:easy_localization/easy_localization.dart';
import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tap_area.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/utilities/utilities.dart';

class KeyValueTable extends StatelessWidget {
  KeyValueTable({
    super.key,
    this.title,
    required this.tableContents,
    this.allowCopy = false,
  });

  final _toastService = locator<ToastService>();

  final String? title;
  final bool allowCopy;
  final List<Map<String, String>> tableContents;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (title?.trim().isNotEmpty ?? false)
        _buildItemContainer(Row(
          children: [
            Heading3(title!),
          ],
        )),
      ...tableContents
          .where((e) => e['value']?.isNotEmpty ?? false)
          .map(
            (e) => _buildItemContainer(
              RowHitTestWithoutSizeLimit(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2.5),
                      child: ContentBig(
                        apiTranslate(e['key']!),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        _copyValue(e);
                      },
                      child: ContentBig(
                        e['value']!,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  if (!allowCopy) // No title, show copy button for value
                    TapArea(
                      extraTapArea: const EdgeInsets.only(
                          right: 14, top: 16, bottom: 14, left: 4),
                      onTap: () {
                        _copyValue(e);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: TingIcon(
                          'files_file-copy',
                          width: 20,
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
    ]);
  }

  void _copyValue(Map<String, String> e) {
    Clipboard.setData(ClipboardData(text: e['value']!))
        .then((_) => _toastService.success(tr('common.value_copied')));
  }
}

Container _buildItemContainer(Widget child) {
  return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: TingsColors.grayMedium, width: 1))),
      child: child);
}
