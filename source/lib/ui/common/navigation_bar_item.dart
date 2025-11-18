import 'package:flutter/material.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem(
      {super.key,
      required this.iconName,
      required this.onTap,
      required this.label,
      required this.pageIndex,
      required this.currentPageIndex,
      this.isElevated = false});

  final int pageIndex;
  final int currentPageIndex;
  final String iconName;
  final String label;
  final VoidCallback onTap;
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TingsColors.grayLight,
      child: InkWell(
        splashColor: isElevated ? Colors.transparent : null,
        highlightColor: isElevated ? Colors.transparent : null,
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Container(
          width: 60,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: pageIndex == currentPageIndex
                          ? TingsColors.black
                          : TingsColors.grayLight,
                      width: 3))),
          child: isElevated
              ? OverflowBox(
                  maxHeight: 84,
                  maxWidth: 64,
                  child: Container(
                    height: 64,
                    width: 64,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                        color: TingsColors.black, shape: BoxShape.circle),
                    child: Center(
                      child: TingIcon(
                        iconName,
                        width: 24,
                        height: 24,
                        color: TingsColors.white,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 6, top: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TingIcon(
                          iconName,
                          width: 26,
                        ),
                      ),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
