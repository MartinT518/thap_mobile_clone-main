import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/models/search_product_result.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/alert_message.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/search_links.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/my_tings/product_list_item.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    final searchResults = useState<List<SearchProductResult>?>(null);
    final showNoDataMessage = useState<bool>(false);
    final showSearchInfoMessage = useState<bool>(true);
    final searching = useState<bool>(false);
    final productsRepository = locator<ProductsRepository>();
    final navigationService = locator<NavigationService>();
    final debounceTimer = useRef<Timer?>(null);

    Future<void> onSearch() async {
      if (!searchTextController.text.isBlank) {
        showNoDataMessage.value = false;

        searching.value = true;
        final data = await productsRepository.search(searchTextController.text);
        searching.value = false;
        showSearchInfoMessage.value = false;
        FocusManager.instance.primaryFocus?.unfocus();

        searchResults.value = data;

        if (data?.isEmpty ?? true) {
          showNoDataMessage.value = true;
        }
      }
    }

    // Debounced search function (300ms delay per FR-SEARCH-001)
    void _onSearchChanged(String value) {
      debounceTimer.value?.cancel();
      if (value.isBlank) {
        showNoDataMessage.value = false;
        showSearchInfoMessage.value = true;
        searchResults.value = null;
      } else {
        debounceTimer.value = Timer(const Duration(milliseconds: 300), () {
          onSearch();
        });
      }
    }

    useEffect(() {
      return () {
        debounceTimer.value?.cancel();
      };
    }, []);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TingsTextField(
                controller: searchTextController,
                hint: tr('search.hint'),
                onSubmitted: (_) async {
                  await onSearch();
                },
                onChanged: (value) {
                  _onSearchChanged(value);
                },
                rightIcon: GestureDetector(
                  onTap: () async {
                    await onSearch();
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: TingIcon(
                        'general_search-search',
                      )),
                )),
          ),
          if (showSearchInfoMessage.value)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AlertMessage(
                  title: tr('search.info'),
                  iconName: 'general_info-notification',
                  rounded: true),
            ),
          if (searching.value)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
          if ((searchResults.value?.isNotEmpty ?? false) && !searching.value)
            ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                scrollDirection: Axis.vertical,
                itemCount: searchResults.value?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final results = searchResults.value;
                  if (results == null || index >= results.length) {
                    return const SizedBox.shrink();
                  }
                  final product = results[index];
                  return Material(
                    color: TingsColors.white,
                    child: InkWell(
                      onTap: () async {
                        final result =
                            await productsRepository.findByEan(product.barcode);
                        if (result != null) {
                          await navigationService.openProduct(result,
                              context.locale.languageCode, false, false);
                        }
                      },
                      child: ProductListItem(
                        brand: product.producerName,
                        displayName: product.productName,
                        imageUrl: product.imageUrl,
                      ),
                    ),
                  );
                }),
          if (showNoDataMessage.value)
            ProductNotFound(keyword: searchTextController.text)
        ],
      ),
    );
  }
}

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AlertMessage(
            rounded: true,
            title: tr('search.not_found'),
            backgroundColor: TingsColors.redMedium,
            iconName: 'notification_alert-round',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: ContentBig(tr('search.or')),
        ),
        SearchLinks(backgroundColor: TingsColors.grayLight, links: [
          SearchLinkContentModel(type: SearchLinkType.google, query: keyword),
          SearchLinkContentModel(type: SearchLinkType.reddit, query: keyword),
          SearchLinkContentModel(type: SearchLinkType.ebay, query: keyword),
          SearchLinkContentModel(type: SearchLinkType.amazon, query: keyword),
        ])
      ],
    );
  }
}
