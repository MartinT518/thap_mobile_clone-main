import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/pages/ai_question_selection_page.dart';
import 'package:thap/ui/pages/ai_settings_page.dart';

class AskAIButton extends HookWidget {
  const AskAIButton({
    super.key,
    required this.product,
    required this.isOwned,
  });

  final ProductItem product;
  final bool isOwned;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    final aiSettingsService = locator<AISettingsService>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PastelButton(
              onTap: () async {
                final hasProvider = await aiSettingsService.hasActiveProvider();
                
                if (!hasProvider) {
                  await navigationService.push(const AISettingsPage());
                } else {
                  await navigationService.push(
                    AIQuestionSelectionPage(
                      product: product,
                      isOwned: isOwned,
                    ),
                  );
                }
              },
              text: 'Ask AI',
              iconName: 'general_settings',
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: TingsColors.grayLight,
              fixedSize: const Size(88, 64),
              shape: const StadiumBorder(),
              side: BorderSide.none,
            ),
            child: const Center(
              child: TingIcon('options', height: 24, color: TingsColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
