import 'package:flutter/material.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/ai_chat_page.dart';

class AIQuestionSelectionPage extends StatelessWidget {
  const AIQuestionSelectionPage({
    super.key,
    required this.product,
    required this.isOwned,
  });

  final ProductItem product;
  final bool isOwned;

  List<String> get _questions {
    if (isOwned) {
      return [
        'How to optimize the life of this battery?',
        'Check warranty status.',
        'Find me authorized repair shops.',
        'What is the current aftermarket value?',
      ];
    } else {
      return [
        'What is the sustainability score of this product?',
        'What are similar alternatives?',
        'How to properly care for this material?',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return Scaffold(
      appBar: const AppHeaderBar(
        showBackButton: true,
        title: 'Ask AI',
      ),
      body: SafeArea(
        bottom: true,
        child: Container(
          color: TingsColors.grayLight,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Heading4('Select a question or ask your own'),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ..._questions.map(
                      (question) => ProductMenuItem(
                        title: question,
                        onTap: () {
                          navigationService.push(
                            AIChatPage(
                              product: product,
                              initialQuestion: question,
                            ),
                          );
                        },
                      ),
                    ),
                    ProductMenuItem(
                      title: 'Ask your question...',
                      onTap: () {
                        navigationService.push(
                          AIChatPage(
                            product: product,
                            initialQuestion: null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
