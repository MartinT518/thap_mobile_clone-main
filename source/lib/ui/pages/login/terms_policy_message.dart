import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/api_html_content.dart';
import 'package:thap/ui/common/typography.dart';

class TermsPolicyMessage extends HookWidget {
  const TermsPolicyMessage({super.key, this.language});

  final String? language;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTermsLink(tr('register.terms'), 'terms'),
        const ContentBig(' & ', isBold: true),
        _buildTermsLink(tr('register.policy'), 'policy'),
      ],
    );
  }

  Widget _buildTermsLink(String text, String contentKey) {
    final navigationService = locator<NavigationService>();

    return GestureDetector(
      onTap: () {
        navigationService.push(
          ApiHtmlContent(contentKey: contentKey, language: language ?? 'en'),
        );
      },
      child: ContentBig(
        text,
        isBold: true,
        textDecoration: TextDecoration.underline,
      ),
    );
  }
}
