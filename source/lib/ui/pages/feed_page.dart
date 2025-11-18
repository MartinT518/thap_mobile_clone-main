import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/models/user_feed_message_model.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/alert_message.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/tings_image.dart';
import 'package:thap/ui/common/typography.dart';

class FeedPage extends HookWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = locator<UserRepository>();
    final reloadKey = useState(UniqueKey());
    final feedMessagesFuture = useMemoized(
      () => userRepository.getUserFeed(context.locale.languageCode),
      [reloadKey.value],
    );
    final feedMessagesSnapshot = useFuture(feedMessagesFuture);

    return RefreshIndicator(
      backgroundColor: TingsColors.white,
      onRefresh: () async {
        reloadKey.value = UniqueKey();
      },
      child:
          feedMessagesSnapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child:
                    feedMessagesSnapshot.data != null &&
                            feedMessagesSnapshot.data!.isNotEmpty
                        ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder:
                              (context, index) => const TingDivider(),
                          scrollDirection: Axis.vertical,
                          itemCount: feedMessagesSnapshot.data!.length,
                          itemBuilder:
                              (_, int index) => buildFeedItem(
                                context,
                                feedMessagesSnapshot.data![index],
                              ),
                        )
                        : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: AlertMessage(
                              title: tr('feed.no_messages'),
                              iconName: 'general_info-notification',
                              rounded: true,
                            ),
                          ),
                        ),
              ),
    );
  }

  Widget buildFeedItem(BuildContext context, UserFeedMessageModel feedMessage) {
    final openerService = locator<OpenerService>();

    return Material(
      color: TingsColors.white,
      child: InkWell(
        onTap:
            feedMessage.url.isNotBlank
                ? () => openerService.openInternalBrowser(feedMessage.url!)
                : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (feedMessage.imageUrl.isNotBlank) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 342,
                    width: double.infinity,
                    child: TingsImage(feedMessage.imageUrl!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (feedMessage.productNames.isNotEmpty) ...[
                ContentBig(feedMessage.brandName),
                Heading3(_getProductsTitle(feedMessage.productNames)),
              ] else
                Heading3(feedMessage.brandName),
              const SizedBox(height: 6),
              ContentBig(feedMessage.text),
            ],
          ),
        ),
      ),
    );
  }
}

String _getProductsTitle(List<String> productNames) {
  final String firstProductName = productNames.first;

  if (productNames.length == 1) {
    return firstProductName;
  }

  return '$firstProductName + ${productNames.length} ${tr('common.more')}';
}
