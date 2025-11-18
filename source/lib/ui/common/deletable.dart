import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class Deletable extends StatelessWidget {
  const Deletable({
    super.key,
    required this.itemId,
    required this.onDeleted,
    required this.child,
    this.confirmDeletion = false,
    this.direction = DismissDirection.horizontal,
  });

  final String itemId;
  final Widget child;
  final bool confirmDeletion;
  final Future<void> Function() onDeleted;
  final DismissDirection direction;

  @override
  Widget build(BuildContext context) {
    final toastService = locator<ToastService>();
    final navigationService = locator<NavigationService>();

    return Dismissible(
      key: Key(itemId),
      direction: direction,
      onDismissed: (direction) async {
        await onDeleted();
        toastService.success(tr('common.delete_message'));
      },
      confirmDismiss:
          confirmDeletion
              ? (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Heading2(tr('common.confirm')),
                      content: ContentBig(tr('common.delete_confirmation')),
                      actions: [
                        TextButton(
                          onPressed: () => navigationService.pop(true),
                          child: Heading3(tr('common.delete')),
                        ),
                        TextButton(
                          onPressed: () => navigationService.pop(false),
                          child: ContentBig(tr('common.cancel')),
                        ),
                      ],
                    );
                  },
                );
              }
              : null,
      // Swipe from left
      background: _buildBackground(Alignment.centerLeft),
      // Swipe from right or up
      secondaryBackground: _buildBackground(
        direction == DismissDirection.up
            ? Alignment.bottomCenter
            : Alignment.centerRight,
      ),
      child: child,
    );
  }

  Container _buildBackground(AlignmentGeometry alignment) {
    return Container(
      color: TingsColors.red,
      alignment: alignment,
      padding: EdgeInsets.symmetric(
        horizontal: 28,
        vertical: alignment == Alignment.bottomCenter ? 12 : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TingIcon(
            'trash_trash-bin',
            width: 20,
            color: TingsColors.white,
          ),
          const SizedBox(height: 6),
          ContentBig(tr('common.delete'), color: TingsColors.white),
        ],
      ),
    );
  }
}
