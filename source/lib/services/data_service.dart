import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thap/configuration.dart';
import 'package:thap/models/open_graph_scrape_result.dart';
import 'package:thap/models/product_item_result.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/stores/user_profile_store.dart';

const String apiUrl = Configuration.apiUrl;
const String _userHeaderKey = 'User';

class DataService {
  Map<String, String> _getHeaders() {
    final userProfileStore = locator<UserProfileStore>();

    return {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      _userHeaderKey: userProfileStore.userProfile?.email ?? ''
    };
  }

  Future<Response> get(String url) {
    return http.get(Uri.parse('$apiUrl/$url'), headers: _getHeaders());
  }

  Future<Response> post(String url, [Map<String, String?>? data]) {
    return http.post(
      Uri.parse('$apiUrl/$url'),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
  }

  Future<Response> put(String url, [Map<String, String?>? data]) {
    return http.put(
      Uri.parse('$apiUrl/$url'),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
  }

  Future<String?> getContent(String key, String lang) async {
    final response = await get('content/$lang/$key');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Could not load content');
    }
  }

  Future<List<ProductItemResult>> getProductItems(
      String productId, String contentUrl) async {
    final response =
        await http.get(Uri.parse(contentUrl), headers: _getHeaders());
    List<ProductItemResult> result = [];
    try {
      if (response.statusCode == 200) {
        final sanitizedData = response.body.replaceAll(RegExp(r',{}'), '');
        result = (jsonDecode(sanitizedData) as List)
            .map((ting) => ProductItemResult.fromJson(ting))
            .toList();
      }
    } catch (_) {}

    return result;
  }

  Future<OpenGraphScrapeResult?> extractProductInfo(String url) async {
    var uri =
        'https://opengraph.io/api/1.1/site/${Uri.encodeComponent(url)}?accept_lang=en&full_render&app_id=${Configuration.openGraphAppId}';
    final response = await http.get(Uri.parse(uri), headers: _getHeaders());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return OpenGraphScrapeResult.fromJson(data);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to scrape url: $url');
    }
  }
}
