import 'package:flutter/material.dart';
import 'package:thap/models/shortcut_item.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ShortcutListItem extends StatelessWidget {
  const ShortcutListItem({super.key, required this.shortcutItem});

  final ShortcutItem shortcutItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: shortcutItem.backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: shortcutItem.onTap,
        child: Container(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 10,
            top: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TingIcon(
                shortcutItem.iconName,
                height: 26,
                color: shortcutItem.color,
              ),
              ContentBig(
                shortcutItem.title,
                color: shortcutItem.color,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
