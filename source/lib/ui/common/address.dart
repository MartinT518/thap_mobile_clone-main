import 'package:easy_localization/easy_localization.dart';
import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/tap_area.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';

class Address extends StatelessWidget {
  Address({
    super.key,
    required this.title,
    this.websiteUrl,
    this.iconName,
    this.email,
    this.phone,
    this.showDivider = false,
    required this.address,
  });

  final String title;
  final String? websiteUrl;
  final String? iconName;
  final String? email;
  final String? phone;
  final String address;
  final bool showDivider;

  final _openerService = locator<OpenerService>();
  @override
  Widget build(BuildContext context) {
    final iconNameInternal = iconName.isNotBlank ? iconName : 'home_dog-house';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 17),
                    child: TingIcon(iconNameInternal, width: 41),
                  ),
                  Expanded(
                    child: ColumnHitTestWithoutSizeLimit(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Heading3(
                          title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (websiteUrl.isNotBlank)
                          TapArea(
                            extraTapArea: const EdgeInsets.all(5),
                            onTap: () async {
                              await _openerService.openInternalBrowser(
                                websiteUrl!,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: ContentBig(
                                websiteUrl!.replaceAll(
                                  RegExp(r'^(https?:\/\/)'),
                                  '',
                                ),
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ContentBig(address),
                        if (phone.isNotBlank)
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: ContentBig(
                              tr(
                                'product.address_phone',
                                namedArgs: {'phoneNo': phone!},
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (email.isNotBlank || phone.isNotBlank)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (email.isNotBlank)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await _openerService.openEmail(email!);
                          },
                          style: DesignSystemComponents.secondaryButton(),
                          child: Text(tr('product.address_write')),
                        ),
                      ),
                    if (email.isNotBlank) const SizedBox(width: 15),
                    if (phone.isNotBlank)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await _openerService.openDialer(phone!);
                          },
                          style: DesignSystemComponents.primaryButton(),
                          child: Text(tr('product.address_call')),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (showDivider) TingDivider(),
      ],
    );
  }
}
