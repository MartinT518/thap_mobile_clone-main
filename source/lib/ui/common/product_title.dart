import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/typography.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key, this.title, this.subTitle});

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    if (title.isBlank && subTitle.isBlank) return Container();

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      child: Center(
        child: Column(
          children: [
            if (title.isNotBlank) Heading2(title!, textAlign: TextAlign.center),
            if (subTitle.isNotBlank)
              Container(
                padding: EdgeInsets.only(top: title.isNotBlank ? 5 : 0),
                child: ContentSmall(subTitle!, textAlign: TextAlign.center),
              ),
          ],
        ),
      ),
    );
  }
}
