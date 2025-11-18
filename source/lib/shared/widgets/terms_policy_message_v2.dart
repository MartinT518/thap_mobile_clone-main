import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/ui/common/typography.dart';

/// Terms and Policy message component (v2 - using GoRouter)
class TermsPolicyMessageV2 extends ConsumerWidget {
  const TermsPolicyMessageV2({
    super.key,
    this.language,
  });

  final String? language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTermsLink(context, tr('register.terms'), 'terms'),
        const ContentBig(' & ', isBold: true),
        _buildTermsLink(context, tr('register.policy'), 'policy'),
      ],
    );
  }

  Widget _buildTermsLink(BuildContext context, String text, String contentKey) {
    // TODO: Implement navigation to terms/policy pages when those routes are created
    return GestureDetector(
      onTap: () {
        // Navigate to terms/policy page
        // context.push('/legal/$contentKey');
      },
      child: ContentBig(
        text,
        isBold: true,
        textDecoration: TextDecoration.underline,
        color: AppTheme.primaryBlue500, // Design System: Primary Blue for links
      ),
    );
  }
}

