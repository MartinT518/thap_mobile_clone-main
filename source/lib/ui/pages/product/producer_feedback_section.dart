import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/common/tings_form.dart';

class ProducerFeedbackSection extends HookWidget {
  const ProducerFeedbackSection({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final userProfileStore = locator<UserProfileStore>();
    final navigationService = locator<NavigationService>();
    final productsRepository = locator<ProductsRepository>();
    final toastService = locator<ToastService>();

    final feedbackController = useTextEditingController();
    final nameController = useTextEditingController(
      text: userProfileStore.userProfile?.name,
    );
    final emailController = useTextEditingController(
      text: userProfileStore.userProfile?.email,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TingsTextField(
            controller: feedbackController,
            label: '${tr('product.feedback.feedback')} *',
            hint: tr('product.feedback.feedback_hint'),
            maxLines: 8,
          ),
          const SizedBox(height: 16),
          TingsTextField(
            controller: nameController,
            label: tr('product.feedback.name'),
          ),
          const SizedBox(height: 16),
          TingsTextField(
            controller: emailController,
            label: tr('product.feedback.email'),
          ),
          const SizedBox(height: 38),
          ElevatedButton(
            onPressed: () async {
              if (feedbackController.text.isBlank) {
                toastService.error(tr('product.feedback.feedback_error'));
              } else {
                await productsRepository.feedback(
                  productId,
                  feedbackController.text,
                  nameController.text,
                  emailController.text,
                );

                toastService.success(tr('product.feedback.sent_message'));
                navigationService.pop();
              }
            },
            style: DesignSystemComponents.primaryButton(),
            child: Text(tr('product.feedback.send')),
          ),
        ],
      ),
    );
  }
}
