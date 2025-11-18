import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/models/product_item_result.dart';
import 'package:thap/services/data_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class ProductItems extends HookWidget {
  ProductItems({super.key, required this.productId, required this.contentUrl});

  final String productId;
  final String contentUrl;

  final _dataService = locator<DataService>();

  @override
  Widget build(BuildContext context) {
    final items = useState<List<ProductItemResult>>([]);

    useEffect(() {
      Future.microtask(
        () async =>
            items.value = await _dataService.getProductItems(
              productId,
              contentUrl,
            ),
      );
      return null;
    }, []);

    if (items.value.isEmpty) return Container();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 4),
      color: TingsColors.grayLight,
      child: Wrap(
        runSpacing: 4,
        children:
            items.value.map((item) {
              return ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 100),
                child: Container(
                  decoration: const BoxDecoration(color: TingsColors.white),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 61,
                            height: 68,
                            child: TingsImage(
                              item.image,
                              height: 68,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ContentSmall(item.code),
                                      ContentSmall(item.price),
                                    ],
                                  ),
                                  Heading4(item.name),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
