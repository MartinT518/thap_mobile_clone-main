import 'package:flutter/material.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class ProductMarketingMessage extends StatelessWidget {
  const ProductMarketingMessage({
    super.key,
    required this.message,
    this.backgroundColor = TingsColors.grayMedium,
    this.textColor = TingsColors.primary,
    this.imageUrl,
    this.onReadMore,
  });

  final String message;
  final String? imageUrl;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onReadMore;
  final double borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 124, minHeight: 80),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onReadMore,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imageUrl.isNotBlank)
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          topLeft: Radius.circular(borderRadius),
                        ),
                        child: TingsImage(
                          imageUrl!,
                          fit: BoxFit.cover,
                          height: 124,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 10,
                        ),
                        child: ContentBig(
                          message,
                          color: textColor,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (onReadMore != null)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: TingIcon(
                    'arrow_arrow-right',
                    width: 18,
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
