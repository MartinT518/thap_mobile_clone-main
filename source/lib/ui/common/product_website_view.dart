import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/web.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class ProductWebsiteView extends HookWidget {
  ProductWebsiteView({super.key, required this.url, this.title, this.onFocus, this.onScrollTop});

  final String url;
  final String? title;
  final Function? onFocus;
  final Function? onScrollTop;

  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isFocused = useState<bool>(false);
    var normalizedUrl = url.trim();

    if (!normalizedUrl.startsWith('http')) {
      normalizedUrl = 'https://$normalizedUrl';
    }
    final webUri = WebUri(normalizedUrl);

    if (!webUri.isValidUri) {
      Logger().e('Invalid URL in product website view: $url');
      return Container();
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18, right: 8),
          height: 70,
          color: TingsColors.grayLight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TingIcon('arrow_arrow-bot', height: 26, color: TingsColors.black),
              const SizedBox(width: 14),
              Expanded(
                child: ContentBig(
                  title.isNotBlank ? title! : tr('pages.product_website'),
                  color: TingsColors.black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              TingsIconButton(
                onPressed: () {
                  locator<OpenerService>().openInternalBrowser(url);
                },
                icon: 'arrow_external-link',
                backgroundColor: TingsColors.white,
                opacity: 1,
                size: 50,
                showBorder: true,
              ),
            ],
          ),
        ),
        const TingDivider(),
        Stack(
          children: [
            SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  95, // subtract app bar height + safe area padding
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: webUri),
                onOverScrolled: (_, int x, int y, bool clampedX, bool clampedY) {
                  if (y == 0 && onScrollTop != null) {
                    onScrollTop!();
                    isFocused.value = false;
                  }
                },
                onScrollChanged: (_, int x, int y) {
                  if (onFocus != null && !isFocused.value && y > 5) {
                    isFocused.value = true;
                    onFocus!();
                  }
                },
                onWindowFocus: (_) {
                  if (onFocus != null && !isFocused.value) {
                    isFocused.value = true;
                    onFocus!();
                  }
                },
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: TingsIconButton(
                onPressed: () {
                  if (onScrollTop != null) {
                    onScrollTop!();
                    isFocused.value = false;
                  }
                },
                icon: 'arrow_arrow-top',
                backgroundColor: TingsColors.grayLight,
                opacity: 1,
                size: 50,
                showBorder: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
