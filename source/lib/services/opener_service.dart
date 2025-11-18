import 'package:thap/models/product_item.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/tings_internal_browser.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenerService {
  Future<void> openInternalBrowser(String url, {ProductItem? product}) async {
    if (!url.startsWith('http')) throw 'Url not valid: $url';

    final encodedUrl = Uri.tryParse(url);

    if (encodedUrl == null) throw 'Could not open url: $encodedUrl';

    locator<NavigationService>().push(
      TingsInternalBrowser(url: encodedUrl.toString(), product: product),
    );
  }

  Future<void> openExternalBrowser(String url) async {
    if (!url.startsWith('http')) throw 'Url not valid: $url';

    final encodedUrl = Uri.tryParse(url);

    if (encodedUrl == null) throw 'Could not open url: $encodedUrl';

    if (await canLaunchUrl(encodedUrl)) {
      await launchUrl(encodedUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open url: $encodedUrl';
    }
  }

  Future<void> openEmail(String email) async {
    final emailLaunchUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not open email: $emailLaunchUri';
    }
  }

  Future<void> openDialer(String phone) async {
    final dialerLaunchUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(dialerLaunchUri)) {
      await launchUrl(dialerLaunchUri);
    } else {
      throw 'Could not open dialer: $dialerLaunchUri';
    }
  }
}
