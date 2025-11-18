import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/material.dart';

class TapArea extends StatelessWidget {
  const TapArea({
    super.key,
    this.extraTapArea = const EdgeInsets.all(12),
    required this.onTap,
    required this.child,
  });

  final EdgeInsets extraTapArea;
  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetectorHitTestWithoutSizeLimit(
      // debugHitTestAreaColor: Colors.pink.withOpacity(0.4),
      extraHitTestArea: extraTapArea,
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: child,
    );
  }
}
