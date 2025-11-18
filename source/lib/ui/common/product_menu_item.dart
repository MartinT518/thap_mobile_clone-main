import 'package:flutter/material.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ProductMenuItem extends StatelessWidget {
  const ProductMenuItem({
    super.key,
    this.iconName,
    required this.title,
    this.onTap,
    this.dividerTop = false,
    this.dividerBottom = true,
  });

  final String? iconName;
  final String title;
  final Function()? onTap;
  final bool dividerTop;
  final bool dividerBottom;

  @override
  Widget build(BuildContext context) {
    bool isDisabled = onTap == null;
    double opacity = isDisabled ? 0.4 : 1;

    return Material(
      color:
          isDisabled
              ? TingsColors.grayLight.withOpacity(opacity)
              : TingsColors.white,
      borderRadius: BorderRadius.circular(2),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            if (dividerTop) const TingDivider(height: 1),
            Container(
              padding: const EdgeInsets.only(left: 18, right: 20),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconName != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: TingIcon(
                        iconName,
                        height: 24,
                        color: TingsColors.black.withOpacity(opacity),
                      ),
                    ),
                  Expanded(
                    child: ContentBig(
                      title,
                      color: TingsColors.black.withOpacity(opacity),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TingIcon(
                      'general_arrow-chevron-right',
                      height: 24,
                      color: TingsColors.black.withOpacity(opacity),
                    ),
                  ),
                ],
              ),
            ),
            if (dividerBottom) const TingDivider(height: 1),
          ],
        ),
      ),
    );
  }
}
