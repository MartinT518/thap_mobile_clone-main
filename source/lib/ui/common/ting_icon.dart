import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TingIcon extends StatelessWidget {
  const TingIcon(this.name, {super.key, this.width, this.height, this.color});

  final String? name;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return name?.isNotEmpty ?? false
        ? SvgPicture.asset(
          'assets/icons/$name.svg',
          width: width,
          height: height,
          color: color, //?? TingsColors.black,
        )
        : Container();
  }
}
