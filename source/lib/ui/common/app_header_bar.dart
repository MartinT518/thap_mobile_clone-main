import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const AppHeaderBar({
    super.key,
    this.showBackButton = false,
    this.backButtonIcon = 'general_arrow-left',
    this.title,
    this.subTitle,
    this.onNavigateBack,
    this.rightWidget,
    this.logo,
  });

  final double height = 70;
  final bool showBackButton;
  final String backButtonIcon;
  final String? title;
  final String? subTitle;
  final Function? onNavigateBack;
  final Widget? rightWidget;
  final Widget? logo;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    final hasTitle = title?.isNotEmpty ?? false;
    final hasSubTitle = subTitle?.isNotEmpty ?? false;
    
    // FIX: Wrap in SizedBox to enforce PreferredSizeWidget contract
    // This provides explicit height constraint required when used as Scaffold.appBar
    // SafeArea is inside SizedBox, so inner Container should fill available space
    return SizedBox(
      height: height,
      child: Container(
        color: TingsColors.white,
        child: SafeArea(
          top: true,
          bottom: false,
          child: SizedBox(
            // Fill available height after SafeArea padding
            height: double.infinity,
            child: Container(
              padding: EdgeInsets.only(
                left: (showBackButton ? 7 : 17),
                right: rightWidget != null ? 0 : 27,
                top: 10,
              ),
              decoration: const BoxDecoration(
                color: TingsColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBackButton)
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: OutlinedButton(
                      onPressed: () {
                        if (onNavigateBack != null) {
                          onNavigateBack!();
                        } else {
                          navigationService.maybePop();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        side: BorderSide.none,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: TingIcon(backButtonIcon, width: 24),
                    ),
                  ),
                if (hasTitle)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!hasSubTitle)
                          Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Heading4(
                              title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (hasSubTitle)
                          ContentBig(
                            title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (hasSubTitle)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Heading4(
                              subTitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  )
                else
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child:
                                logo ??
                                SvgPicture.asset(
                                  'assets/logo.svg',
                                  alignment: Alignment.centerLeft,
                                  height: 28,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (rightWidget != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [rightWidget!],
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
