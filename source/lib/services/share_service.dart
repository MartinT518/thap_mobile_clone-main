import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<ShareResult> shareText(String text, {String? title, String? emailSubject}) async {
    return SharePlus.instance.share(ShareParams(text: text, title: title, subject: emailSubject));
  }

  Future<ShareResult> shareFile(String path, {String? title, String? text}) async {
    return SharePlus.instance.share(ShareParams(text: text, title: title, files: [XFile(path)]));
  }
}
