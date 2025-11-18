import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class TingCheckbox extends HookWidget {
  const TingCheckbox({
    super.key,
    this.label,
    this.checked = false,
    this.onChange,
  });

  final String? label;
  final bool checked;
  final Function(bool checked)? onChange;

  @override
  Widget build(BuildContext context) {
    final checkedInternal = useState<bool>(checked);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final newValue = !checkedInternal.value;
          checkedInternal.value = newValue;

          if (onChange != null) onChange!(newValue);
        },
        child: Container(
          // padding: const EdgeInsets.all(9),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      checkedInternal.value
                          ? TingsColors.blue
                          : TingsColors.white,
                  border:
                      !checkedInternal.value
                          ? Border.all(color: TingsColors.grayMedium, width: 2)
                          : null,
                ),
                child:
                    checkedInternal.value
                        ? const Center(
                          child: TingIcon('check', color: TingsColors.white),
                        )
                        : null,
              ),
              if (label.isNotBlank) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: ContentBig(
                    label!,
                    isBold: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
