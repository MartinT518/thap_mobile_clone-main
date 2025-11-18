import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/ai_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';

class AIChatPage extends HookWidget {
  const AIChatPage({
    super.key,
    required this.product,
    this.initialQuestion,
  });

  final ProductItem product;
  final String? initialQuestion;

  @override
  Widget build(BuildContext context) {
    final aiService = locator<AIService>();
    final toastService = locator<ToastService>();
    final questionController = useTextEditingController(
      text: initialQuestion ?? '',
    );
    final responseText = useState<String>('');
    final isLoading = useState(false);

    Future<void> askQuestion() async {
      if (questionController.text.trim().isEmpty) {
        toastService.error('Please enter a question');
        return;
      }

      isLoading.value = true;
      responseText.value = '';

      try {
        final productInfo =
            '${product.name}${product.barcode != null ? ', Barcode: ${product.barcode}' : ''}';

        final stream = await aiService.askQuestion(
          questionController.text,
          productInfo,
        );

        await for (final chunk in stream) {
          responseText.value += chunk;
        }
      } catch (e) {
        toastService.error('Failed to get AI response. Please try again.');
      } finally {
        isLoading.value = false;
      }
    }

    useEffect(() {
      if (initialQuestion != null && initialQuestion!.isNotEmpty) {
        Future.microtask(() => askQuestion());
      }
      return null;
    }, []);

    return Scaffold(
      appBar: const AppHeaderBar(
        showBackButton: true,
        title: 'Ask AI',
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: TingsColors.grayLight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Heading3('Product:'),
                  const SizedBox(height: 4),
                  ContentBig(
                    '${product.name}${product.barcode != null ? ' (Barcode: ${product.barcode})' : ''}',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: TingsColors.white,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (initialQuestion != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: TingsColors.grayLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Heading4('Question:'),
                            const SizedBox(height: 8),
                            ContentBig(initialQuestion!),
                          ],
                        ),
                      ),
                    if (isLoading.value)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (responseText.value.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Heading4('AI Response:'),
                            const SizedBox(height: 8),
                            ContentBig(responseText.value),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (initialQuestion == null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: TingsColors.grayLight,
                  border: Border(
                    top: BorderSide(color: TingsColors.grayMedium, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    TingsTextField(
                      controller: questionController,
                      label: 'Ask your question',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    MainButton(
                      onTap: isLoading.value ? () {} : askQuestion,
                      text: isLoading.value ? 'Processing...' : 'Ask',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
