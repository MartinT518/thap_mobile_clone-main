import 'package:flutter/material.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/html_content.dart';

class HtmlPage extends StatelessWidget {
  const HtmlPage({super.key, required this.content, required this.title});

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(title: title, showBackButton: true),
      body: SafeArea(bottom: true, child: HtmlContent(content: content)),
    );
  }
}
