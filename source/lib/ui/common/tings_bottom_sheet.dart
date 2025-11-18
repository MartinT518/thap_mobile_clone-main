import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/typography.dart';

Future<void> showTingsBottomSheet({
  required BuildContext context,
  String title = '',
  Widget? titleWidget,
  bool showHeader = true,
  bool scrollable = true,
  bool rounded = true,
  bool closeButtonRightSide = true,
  required Widget child,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: TingsColors.white,
    enableDrag: false,
    barrierColor: TingsColors.black.withOpacity(0.2),
    shape:
        rounded
            ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            )
            : null,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    constraints: BoxConstraints(
      maxHeight:
          MediaQuery.of(context).size.height -
          MediaQueryData.fromView(window).padding.top -
          0,
      minWidth: double.infinity,
    ),
    builder: (BuildContext context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: SafeArea(
          bottom: true,
          child:
              showHeader
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 70),
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: 16,
                                  ),
                                  child:
                                      titleWidget ??
                                      Heading3(
                                        title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ),
                              _closeButton(context, closeButtonRightSide),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          physics:
                              scrollable
                                  ? const BouncingScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                          child: child,
                        ),
                      ),
                    ],
                  )
                  : Stack(
                    children: [
                      SingleChildScrollView(
                        physics:
                            scrollable
                                ? const BouncingScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                        child: child,
                      ),
                      _closeButton(context, closeButtonRightSide),
                    ],
                  ),
        ),
      );
    },
  );
}

Widget _closeButton(BuildContext context, bool showOnRightSide) {
  final navigationService = locator<NavigationService>();
  const double size = 40;

  return Positioned(
    right: showOnRightSide ? 5 : null,
    left: showOnRightSide ? null : 5,
    top: 15,
    height: size,
    child: TingsIconButton(
      onPressed: () => navigationService.pop(),
      icon: 'menu_menu-close',
      size: size,
    ),
  );
}
