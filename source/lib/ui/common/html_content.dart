import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/typography.dart';

class HtmlContent extends HookWidget {
  const HtmlContent({
    super.key,
    required this.content,
    this.spacing = 16,
    this.clamping = false,
  });

  final String content;
  final double spacing;
  final bool clamping;
  static const double clampingSize = 350;

  @override
  Widget build(BuildContext context) {
    final clampingInternal = useState<bool>(clamping);

    // Sync internal state with prop changes
    useEffect(() {
      clampingInternal.value = clamping;
      return null;
    }, [clamping]);

    if (clampingInternal.value) {
      return Column(
        children: [
          ShaderMask(
            shaderCallback:
                LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 1],
                ).createShader,
            child: _buildHtmlContent(clampingInternal.value),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => clampingInternal.value = false,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: TingsColors.grayMedium,
                    ),
                  ),
                  child: ContentBig(tr('common.show_more'), isBold: true),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return _buildHtmlContent(clampingInternal.value);
    }
  }

  Widget _buildHtmlContent(bool isClamping) {
    final openerService = locator<OpenerService>();

    return Container(
      constraints: BoxConstraints(
        maxHeight: isClamping ? clampingSize : double.infinity,
      ),
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: SingleChildScrollView(
        physics:
            isClamping
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: spacing),
        child: HtmlWidget(
          _normalizeHtml(content),
          onTapUrl: (url) async {
            await openerService.openInternalBrowser(url);
            return true;
          },
          textStyle: const TextStyle(
            fontFamily: 'Manrope-Full',
            fontSize: 14,
            color: TingsColors.black,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }

  String _normalizeHtml(String content) {
    var isHtmlContent = RegExp(
      '</?[a-z][sS]*>',
      caseSensitive: false,
      multiLine: true,
    ).hasMatch(content);

    // If regular text content, replace newline with html line breaks
    if (!isHtmlContent) {
      content = content.replaceAll('\n', '<br/>');
    }

    return '<div>$content</div>';
  }
}
