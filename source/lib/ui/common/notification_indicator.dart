import 'package:flutter/widgets.dart';
import 'package:thap/ui/common/colors.dart';

class NotificationIndicator extends StatelessWidget {
  const NotificationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      decoration: const BoxDecoration(
        color: TingsColors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
