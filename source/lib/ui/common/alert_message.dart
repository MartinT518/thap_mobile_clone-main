import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    required this.title,
    this.subTitle,
    this.iconName,
    this.onTap,
    this.rounded,
    this.backgroundColor = TingsColors.blueMedium,
    this.textColor = TingsColors.black,
  });

  final String title;
  final String? subTitle;
  final String? iconName;
  final bool? rounded;
  final Function()? onTap;

  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: rounded == true ? BorderRadius.circular(4) : null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding:
              subTitle.isBlank
                  ? const EdgeInsets.all(16)
                  : const EdgeInsets.only(
                    top: 26,
                    bottom: 26,
                    left: 18,
                    right: 24,
                  ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconName.isNotBlank)
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: TingIcon(iconName, height: 26, color: textColor),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subTitle.isBlank)
                      ContentBig(title, color: textColor)
                    else
                      Heading4(title, color: textColor),
                    if (subTitle.isNotBlank)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: ContentBig(subTitle!, color: textColor),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TingIcon(
                    'general_arrow-chevron-right',
                    height: 26,
                    color: textColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
