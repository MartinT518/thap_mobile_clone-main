import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/ui/common/typography.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      child: Heading3(title),
    );
  }
}
