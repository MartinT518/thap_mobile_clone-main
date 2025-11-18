import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class TingsPopupMenuItem<T> extends PopupMenuItem<T> {
  TingsPopupMenuItem({super.key, required this.value, required this.name})
    : super(
        child: ContentBig(name),
        value: value,
        padding: const EdgeInsets.symmetric(horizontal: 28),
      );

  @override
  final T value;
  final String name;
}

// TODO: Not used anymore, maybe not needed
class TingsPopupMenuContainer<T> extends HookWidget {
  const TingsPopupMenuContainer({
    required this.child,
    required this.items,
    required this.onItemSelected,
    this.enabled = true,
    this.longPress = false,
    super.key,
  });

  final Widget child;
  final List<TingsPopupMenuItem<T>> items;
  final void Function(T?) onItemSelected;
  final bool enabled;
  final bool longPress;

  @override
  Widget build(BuildContext context) {
    final tapDownPosition = useState<Offset?>(null);

    if (!enabled) return child;

    void openMenu() async {
      showTingsPopupMenu(
        items: items,
        onItemSelected: onItemSelected,
        tapDownPosition: tapDownPosition.value,
        context: context,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (TapDownDetails details) {
        tapDownPosition.value = details.globalPosition;
      },
      onLongPress: longPress ? openMenu : null,
      onTap: !longPress ? openMenu : null,
      child: child,
    );
  }
}

void showTingsPopupMenu<T>({
  required List<TingsPopupMenuItem<T>> items,
  required void Function(T?) onItemSelected,
  required BuildContext context,
  required Offset? tapDownPosition,
}) async {
  if (tapDownPosition == null) return;

  T? value = await showMenu<T>(
    context: context,
    constraints: const BoxConstraints(minWidth: 170),
    items: items,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    position: RelativeRect.fromLTRB(
      tapDownPosition.dx,
      tapDownPosition.dy,
      tapDownPosition.dx,
      tapDownPosition.dy,
    ),
  );

  onItemSelected(value);
}

class TingsKebabMenu<T> extends StatelessWidget {
  const TingsKebabMenu({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.child,
    this.size = 48,
    this.iconSize = 20,
    this.opacity = 1,
    this.backgroundColor = TingsColors.white,
  });
  final List<TingsPopupMenuItem<T>> items;
  final void Function(T?) onItemSelected;
  final Widget? child;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Material(
        borderRadius: BorderRadius.circular(32),
        color: backgroundColor.withOpacity(opacity),
        child: PopupMenuButton<T>(
          constraints: const BoxConstraints(minWidth: 170),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onSelected: onItemSelected,
          itemBuilder: (context) => items,
          tooltip: '',
          child:
              child ??
              SizedBox(
                width: size,
                height: size,
                child: Center(
                  child: TingIcon(
                    'general_menu-dots-kebab-more-vertical',
                    height: iconSize,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
