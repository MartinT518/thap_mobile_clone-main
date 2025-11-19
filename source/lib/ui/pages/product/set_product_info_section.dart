import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/product_tags_section.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';

class SetProductInfoSection extends HookWidget {
  const SetProductInfoSection({
    super.key,
    required this.product,
    this.wasAdded = false,
  });

  final ProductItem product;
  final bool wasAdded;

  @override
  Widget build(BuildContext context) {
    if (product.instanceId == null) {
      Logger().e('No ting found for productId: ${product.id}');
      throw Exception('No ting found for productId: ${product.id}');
    }

    final toastService = locator<ToastService>();
    final myTingsStore = locator<MyTingsStore>();
    final myTingsRepository = locator<MyTingsRepository>();
    final navigationService = locator<NavigationService>();
    var ting = myTingsStore.getTing(product.id)!;

    final nicknameController = useTextEditingController(text: ting.nickname);
    final quickNoteController = useTextEditingController();
    final isOwner = useState(ting.isOwner);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TingsTextField(
            controller: nicknameController,
            hint: tr('product.info.nickname_hint'),
          ),
          if (wasAdded) ...[
            const SizedBox(height: 14),
            TingsTextField(
              controller: quickNoteController,
              hint: tr('product.note.quick'),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Transform.scale(
                scale: 0.8,
                alignment: Alignment.centerLeft,
                child: CupertinoSwitch(
                  activeTrackColor: TingsColors.blue,
                  inactiveTrackColor: TingsColors.grayMedium,
                  thumbColor: TingsColors.white,
                  value: isOwner.value,
                  onChanged: (value) => isOwner.value = value,
                ),
              ),
              ContentBig(tr('product.info.owned')),
            ],
          ),
          const SizedBox(height: 22),
          ProductTagsSection(myTing: product),
          const SizedBox(height: 38),
          Row(
            children: [
              if (wasAdded) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => navigationService.pop(),
                    style: DesignSystemComponents.secondaryButton(),
                    child: Text(tr('my_tings.new_ting_added_extra_info.skip')),
                  ),
                ),
                const SizedBox(width: 15),
              ],
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                  ting = myTingsStore.getTing(product.id)!;

                  if (ting.nickname != nicknameController.text) {
                    await myTingsRepository.setNickname(
                      product.instanceId!,
                      nicknameController.text,
                    );

                    await myTingsStore.update(
                      ting.copyWith(nickname: nicknameController.text),
                    );
                  }

                  if (quickNoteController.text.isNotBlank && wasAdded) {
                    await myTingsRepository.saveNote(
                      product.instanceId!,
                      quickNoteController.text,
                    );
                  }

                  ting = myTingsStore.getTing(product.id)!;
                  await myTingsRepository.setIsOwner(
                    product.instanceId!,
                    isOwner.value,
                  );
                  await myTingsStore.update(
                    ting.copyWith(isOwner: isOwner.value),
                  );

                  if (quickNoteController.text.isNotBlank ||
                      nicknameController.text.isNotBlank) {
                    toastService.success(
                      tr('my_tings.new_ting_added_extra_info.saved_message'),
                    );
                  }

                  navigationService.pop();
                  },
                  style: DesignSystemComponents.primaryButton(),
                  child: Text(tr('common.done')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
