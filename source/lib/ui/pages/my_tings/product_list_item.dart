import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_action.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/notification_indicator.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    this.imageUrl,
    required this.brand,
    required this.displayName,
    this.hasNotification = false,
    this.actions = const [],
  });

  final String? imageUrl;
  final String brand;
  final String displayName;
  final bool hasNotification;
  final List<ProductAction> actions;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        height: actions.isNotEmpty ? 149 : 100,
      ),
      child: Container(
        // decoration: const BoxDecoration(color: TingsColors.white),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imageUrl.isNotBlank)
                      SizedBox(
                        width: 61,
                        height: 68,
                        child: TingsImage(
                          imageUrl!,
                          height: 68,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    else
                      Container(
                        width: 61,
                        height: 68,
                        decoration: BoxDecoration(
                          color: TingsColors.grayLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 31),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContentSmall(
                              brand,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Heading4(
                              displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // if (actions.isNotEmpty)
                //   SizedBox(
                //     height: 32 + 15,
                //     child: ListView.separated(
                //         separatorBuilder: (context, index) =>
                //             const SizedBox(width: 6),
                //         // shrinkWrap: true,
                //         padding: const EdgeInsets.only(top: 15),
                //         scrollDirection: Axis.horizontal,
                //         itemCount: actions.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return ProductActionButton(action: actions[index]);
                //         }),
                //   )
              ],
            ),
            if (hasNotification)
              const Positioned(right: 0, child: NotificationIndicator()),
          ],
        ),
      ),
    );
  }
}
