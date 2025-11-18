import 'package:flutter/widgets.dart';
import 'package:thap/ui/common/colors.dart';

class ShortcutItem {
  ShortcutItem(
      {this.color = TingsColors.secondary,
      this.backgroundColor = TingsColors.primary,
      required this.iconName,
      required this.title,
      required this.onTap});

  final Color color;
  final Color backgroundColor;
  final String iconName;
  final String title;
  final Function() onTap;
}
