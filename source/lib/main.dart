import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:thap/app.dart';
import 'package:thap/core/config/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set app orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  // Initialize localization
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: AppConstants.supportedLanguageCodes
            .map((code) => Locale(code))
            .toList(),
        path: 'assets/translations',
        startLocale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        useFallbackTranslations: true,
        useOnlyLangCode: true,
        child: const ThapApp(),
      ),
    ),
  );
}

// App links handling can be added later if needed
// For now, the app uses GoRouter for navigation
