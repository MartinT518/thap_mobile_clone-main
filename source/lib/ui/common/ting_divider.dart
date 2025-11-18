import 'package:flutter/material.dart';
import 'package:thap/ui/common/colors.dart';

class TingDivider extends StatelessWidget {
  const TingDivider({
    super.key,
    this.height = 2,
    this.color = TingsColors.grayMedium,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: height, height: height, color: color);
  }
}
