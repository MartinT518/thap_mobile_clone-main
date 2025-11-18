import 'package:flutter/widgets.dart';
import 'package:thap/ui/common/colors.dart';

class ProductListItemSkeleton extends StatelessWidget {
  const ProductListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(height: 100),
      child: Container(
        decoration: const BoxDecoration(color: TingsColors.white),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextSkeletonContainer(
                  width: 61,
                  height: 68,
                  cornerRadius: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 31),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextSkeletonContainer(
                          width: 91,
                          height: 11,
                          cornerRadius: 15,
                          marginBottom: 5,
                        ),
                        _buildTextSkeletonContainer(
                          width: 232,
                          height: 12,
                          cornerRadius: 15,
                          marginBottom: 5,
                        ),
                        _buildTextSkeletonContainer(
                          width: 112,
                          height: 12,
                          cornerRadius: 15,
                          marginBottom: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTextSkeletonContainer({
    required double width,
    required double height,
    required double cornerRadius,
    double marginBottom = 0,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: marginBottom),
      decoration: BoxDecoration(
        color: TingsColors.grayLight,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
    );
  }
}
