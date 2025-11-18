import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thap/extensions/string_extensions.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;

bool boolFromString(String? value) {
  return value?.toLowerCase() == 'true';
}

bool isImage(String fileName) => lookupMimeType(fileName)?.startsWith('image/') ?? false;

String getLocalizedDateTime(DateTime date) => DateFormat().format(date.toLocal());

String apiTranslate(String? text) {
  if (text.isBlank) return '';
  final translationKeysExp = RegExp(r'\[\S+\]');
  // No match for translation key, return original text
  if (!translationKeysExp.hasMatch(text!)) return text;

  final translated = text.replaceAllMapped(translationKeysExp, (match) {
    final key = match.group(0);
    if (key.isNotBlank) {
      var keyClean = key!.replaceAll(RegExp(r'\[|\]'), '');
      return tr(keyClean);
    }
    return '';
  });

  return translated;
}

Future<void> vibrate({int duration = 500}) async {
  final hasVibrator = await Vibration.hasVibrator();

  if (hasVibrator == true) {
    Vibration.vibrate(duration: duration);
  }
}

/// Save a file from the internet to a temporary directory and return the file.
/// File should be deleted after use.
Future<File> saveInternetFileTemp(String url) async {
  try {
    final req = await http.get(Uri.parse(url));

    if (req.statusCode >= 400) {
      throw HttpException(req.statusCode.toString());
    }

    final bytes = req.bodyBytes;
    String tempDirPath = (await getTemporaryDirectory()).path;
    File file = File('$tempDirPath/${basename(url)}');

    await file.writeAsBytes(bytes);
    return file;
  } on Exception catch (e) {
    Logger().e('Error saving temp internet file', error: e);
    rethrow;
  }
}

Future<Uint8List> geInternetFileBytes(String url) async {
  final file = await saveInternetFileTemp(url);
  final bytes = await file.readAsBytes();
  await file.delete();
  return bytes;
}
