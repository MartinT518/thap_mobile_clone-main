import 'package:flutter/material.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    this.iconName,
    required this.title,
    this.onTap,
    required this.ratingType,
    required this.rating,
    this.isFirst = false,
    this.isMiddle = false,
    this.isLast = false,
  });

  final String? iconName;
  final String title;
  final ProductPageComponentRatingType ratingType;
  final String rating;
  final Function()? onTap;

  final bool isFirst;
  final bool isMiddle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final bool isAlone = !isFirst && !isMiddle && !isLast;
    const radius = Radius.circular(8);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: (isFirst || isAlone ? 16 : 0),
              bottom: (isLast || isAlone ? 16 : 0),
            ),
            padding: const EdgeInsets.only(left: 18, right: 24),
            decoration: BoxDecoration(
              color: TingsColors.grayLight,
              borderRadius:
                  isFirst
                      ? const BorderRadius.only(
                        topRight: radius,
                        topLeft: radius,
                      )
                      : isMiddle
                      ? const BorderRadius.all(Radius.zero)
                      : isLast
                      ? const BorderRadius.only(
                        bottomRight: radius,
                        bottomLeft: radius,
                      )
                      : const BorderRadius.all(radius),
              border: Border.all(color: TingsColors.grayMedium, width: 1),
            ),
            height: 75,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (iconName != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: TingIcon(
                      iconName,
                      height: 26,
                      color: TingsColors.black,
                    ),
                  ),
                Expanded(
                  child: ContentBig(
                    title,
                    color: TingsColors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (ratingType == ProductPageComponentRatingType.stars)
                  _buildStars(rating),
                Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Heading3(rating),
                ),
                if (onTap != null)
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TingIcon(
                      'arrow_chevron-right',
                      height: 18,
                      color: TingsColors.black,
                    ),
                  ),
              ],
            ),
          ),
          if (!isLast && !isAlone)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(left: 17, right: 17),
                height: 1,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildStars(String rating) {
  final ratingParsed = double.tryParse(rating.replaceAll(',', '.'));

  if (ratingParsed == null) return Container();

  final starsCount = ratingParsed.floor();
  List<Widget> stars = [];

  for (var i = 0; i < starsCount; i++) {
    stars.add(const TingIcon('general_star', height: 14));
  }

  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Row(mainAxisSize: MainAxisSize.min, children: stars),
  );
}
