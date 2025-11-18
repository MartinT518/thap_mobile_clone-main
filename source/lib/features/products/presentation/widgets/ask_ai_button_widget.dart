import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/ui/pages/ai_question_selection_page.dart';
import 'package:thap/ui/pages/ai_settings_page.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/models/product_item.dart';

/// Ask AI button widget for product detail page
/// Matches the demo script: Blue button, full width, shows on product pages
class AskAIButtonWidget extends ConsumerWidget {
  final Product product;
  final bool isOwned;

  const AskAIButtonWidget({
    super.key,
    required this.product,
    required this.isOwned,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = locator<NavigationService>();
    final aiSettingsService = locator<AISettingsService>();

    return FutureBuilder<bool>(
      future: aiSettingsService.hasActiveProvider(),
      builder: (context, snapshot) {
        final hasProvider = snapshot.data ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingL,
          ),
          child: ElevatedButton.icon(
            onPressed: () async {
              if (!hasProvider) {
                // Navigate to AI Settings if not configured
                await navigationService.push(const AISettingsPage());
              } else {
                // Convert Product to ProductItem for old AI pages
                final productItem = ProductItem(
                  id: product.id,
                  instanceId: product.instanceId,
                  name: product.name,
                  nickname: product.nickname,
                  brand: product.brand,
                  barcode: product.barcode,
                  imageUrl: product.imageUrl,
                  brandLogoUrl: product.brandLogoUrl,
                  code: product.code,
                  qrCode: product.qrCode,
                  qrCodes: product.qrCodes,
                  shareLink: product.shareLink,
                  description: product.description,
                  isOwner: product.isOwner,
                  externalProductType: product.externalProductType,
                  tags: product.tags,
                );

                // Navigate to question selection
                await navigationService.push(
                  AIQuestionSelectionPage(
                    product: productItem,
                    isOwned: isOwned,
                  ),
                );
              }
            },
            icon: const Icon(Icons.auto_awesome, size: 20),
            label: const Text('Ask AI'),
            style: DesignSystemComponents.aiButton(),
          ),
        );
      },
    );
  }
}

