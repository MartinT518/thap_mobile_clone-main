import 'package:flutter/material.dart';
import 'package:thap/models/shortcut_item.dart';
import 'package:thap/ui/common/shortcut_list_item.dart';

class ShortcutList extends StatelessWidget {
  const ShortcutList({super.key, required this.shortcuts});

  final List<ShortcutItem> shortcuts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 24),
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        children:
            shortcuts
                .map(
                  (shortcutItem) =>
                      ShortcutListItem(shortcutItem: shortcutItem),
                )
                .toList(),
      ),
    );
  }
}
