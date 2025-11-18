import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:thap/services/data_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/html_content.dart';

class ApiHtmlContent extends HookWidget {
  const ApiHtmlContent({
    super.key,
    required this.contentKey,
    required this.language,
  });

  final String contentKey;
  final String language;

  @override
  Widget build(BuildContext context) {
    final dataService = locator<DataService>();
    final contentFuture = useMemoized(
      () => dataService.getContent(
        contentKey,
        language.isNotBlank ? language : 'en',
      ),
    );
    final contentSnapshot = useFuture(contentFuture);

    return Scaffold(
      appBar: const AppHeaderBar(showBackButton: true),
      body: SafeArea(
        bottom: true,
        child:
            contentSnapshot.hasData
                ? HtmlContent(content: contentSnapshot.data!)
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
