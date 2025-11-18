import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_internal_browser.dart';
import 'package:thap/ui/common/typography.dart';

class SearchLinks extends StatelessWidget {
  SearchLinks({
    super.key,
    required this.links,
    this.product,
    this.backgroundColor = TingsColors.white,
  });

  final List<SearchLinkContentModel> links;
  final Color backgroundColor;
  final ProductItem? product;

  final _openerService = locator<OpenerService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: backgroundColor,
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children:
            links
                .where((link) => link.type != null)
                .map((link) => _buildSearchLink(context, link, product))
                .toList(),
      ),
    );
  }

  Widget _buildSearchLink(
    BuildContext context,
    SearchLinkContentModel link,
    ProductItem? product,
  ) {
    final searchTypeName = link.type.toString().split('.')[1];
    final navigationService = locator<NavigationService>();

    return Material(
      color: TingsColors.white,
      child: InkWell(
        onTap: () {
          if (product != null && product.externalProductType != null) {
            navigationService.push(
              TingsInternalBrowser(url: _getSearchUrl(link), product: product),
            );
          } else {
            _openerService.openInternalBrowser(
              _getSearchUrl(link),
              product: product,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: TingsColors.grayMedium, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/search_logos/$searchTypeName.svg',
                height: 24,
              ),
              Heading4(_getSearchText(link)),
            ],
          ),
        ),
      ),
    );
  }

  String _getSearchText(SearchLinkContentModel link) {
    switch (link.type!) {
      case SearchLinkType.google:
        return tr('search.google');
      case SearchLinkType.reddit:
        return tr('search.reddit');
      case SearchLinkType.ebay:
        return tr('search.ebay');
      case SearchLinkType.amazon:
        return tr('search.amazon');
      case SearchLinkType.youtube:
        return tr('search.youtube');
    }
  }

  String _getSearchUrl(SearchLinkContentModel link) {
    final searchQuery = Uri.encodeFull(link.query);
    Logger().i(searchQuery);

    switch (link.type!) {
      case SearchLinkType.google:
        return 'https://www.google.com/search?q=$searchQuery';
      case SearchLinkType.reddit:
        return 'https://www.reddit.com/search?q=$searchQuery';
      case SearchLinkType.ebay:
        return 'https://www.ebay.co.uk/sch/i.html?_nkw=$searchQuery&_sacat=0';
      case SearchLinkType.amazon:
        return 'https://www.amazon.de/s?k=$searchQuery';
      case SearchLinkType.youtube:
        return 'https://www.youtube.com/results?search_query=$searchQuery';
    }
  }
}
