import 'package:flutter/widgets.dart';
import 'package:thap/ui/common/colors.dart';

class Heading1 extends StatelessWidget {
  const Heading1(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    isBold: true,
    fontSize: 32,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    textDecoration: textDecoration,
  );
}

class Heading2 extends StatelessWidget {
  const Heading2(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    isBold: true,
    fontSize: 24,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    textDecoration: textDecoration,
  );
}

class Heading3 extends StatelessWidget {
  const Heading3(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    isBold: true,
    fontSize: 18,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    textDecoration: textDecoration,
  );
}

class Heading4 extends StatelessWidget {
  const Heading4(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    isBold: true,
    fontSize: 14,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    textDecoration: textDecoration,
  );
}

class ContentSmall extends StatelessWidget {
  const ContentSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.isBold = false,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final bool isBold;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    fontSize: 12,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    isBold: isBold,
    textDecoration: textDecoration,
  );
}

class ContentBig extends StatelessWidget {
  const ContentBig(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.isBold = false,
    this.textDecoration,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final bool isBold;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) => _buildText(
    text: text,
    fontSize: 14,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    isBold: isBold,
    textDecoration: textDecoration,
  );
}

Widget _buildText({
  required String text,
  required double fontSize,
  bool isBold = false,
  Color? color = TingsColors.black,
  TextAlign? textAlign,
  TextOverflow? overflow,
  int? maxLines,
  bool? softWrap,
  TextDecoration? textDecoration,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    style: TextStyle(
      decoration: textDecoration,
      decorationThickness: 2,
      fontFamily: isBold ? 'Manrope-Bold' : 'Manrope',
      fontSize: fontSize,
      color: color,
    ),
  );
}
