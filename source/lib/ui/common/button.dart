import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onTap,
    required this.text,
    this.expand = false,
    this.iconName,
  });

  final String text;
  final String? iconName;
  final bool expand;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => _buildButton(
    text: text,
    onTap: onTap,
    color: TingsColors.black,
    textColor: TingsColors.white,
    iconName: iconName,
    expand: expand,
  );
}

class LightButton extends StatelessWidget {
  const LightButton({
    super.key,
    required this.onTap,
    required this.text,
    this.expand = false,
    this.iconName,
  });

  final String text;
  final String? iconName;
  final bool expand;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => _buildButton(
    text: text,
    onTap: onTap,
    color: TingsColors.white,
    textColor: TingsColors.black,
    borderColor: TingsColors.grayMedium,
    iconName: iconName,
    expand: expand,
  );
}

class PastelButton extends StatelessWidget {
  const PastelButton({
    super.key,
    required this.onTap,
    required this.text,
    this.expand = false,
    this.iconName,
  });

  final String text;
  final String? iconName;
  final bool expand;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => _buildButton(
    text: text,
    onTap: onTap,
    color: TingsColors.blueStrong,
    textColor: TingsColors.black,
    iconName: iconName,
    expand: expand,
  );
}

class MiniButton extends StatelessWidget {
  const MiniButton({super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TingsColors.grayLight,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: TingsColors.grayMedium, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(widthFactor: 1, child: Heading4(text)),
        ),
      ),
    );
  }
}

Widget _buildButton({
  required String text,
  required Function() onTap,
  required Color color,
  required Color textColor,
  Color? borderColor,
  String? iconName,
  required bool expand,
}) {
  final button = OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      foregroundColor: color == TingsColors.black ? TingsColors.white : null,
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      minimumSize: const Size.fromHeight(64),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      side: BorderSide(width: 2, color: borderColor ?? Colors.transparent),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconName?.isNotBlank ?? false) ...[
          TingIcon(iconName, color: textColor),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Heading4(
            text,
            color: textColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    ),
  );

  if (expand) return Expanded(child: button);

  return button;
}

class TingsIconButton extends StatelessWidget {
  const TingsIconButton({
    super.key,
    required this.onPressed,
    this.size = 40,
    this.iconSize = 20,
    required this.icon,
    this.opacity = 0.8,
    this.showBorder = false,
    this.backgroundColor = TingsColors.grayMedium,
  });

  final void Function() onPressed;
  final String icon;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final double opacity;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor.withOpacity(opacity),
        fixedSize: Size(size, size),
        shape: const CircleBorder(),
        side: !showBorder ? BorderSide.none : null,
      ),
      child: Center(
        child: TingIcon(icon, height: iconSize, color: TingsColors.black),
      ),
    );
  }
}
