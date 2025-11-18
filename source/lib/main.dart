import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/pages/ai_settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set app orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupServiceLocator();
  await EasyLocalization.ensureInitialized();
  //
  // final appData = await locator<AppRepository>().getData();
  // final locales = appData.languages.map((e) => Locale(e.code)).toList();

  runApp(
    // TOOD: move to config
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('et'),
        Locale('sv'),
        Locale('lt'),
        Locale('lv'),
        Locale('de'),
        Locale('fi'),
        Locale('fr'),
        Locale('es'),
        Locale('it'),
        Locale('da'),
        Locale('nl'),
        Locale('pt'),
        Locale('pl'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      child: const TingsApp(),
    ),
  );
}

class TingsApp extends StatefulWidget {
  const TingsApp({super.key});

  @override
  State<TingsApp> createState() => _TingsAppState();
}

class _TingsAppState extends State<TingsApp> {
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initAppLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initAppLinks() async {
    _linkSubscription = AppLinks().uriLinkStream.listen((uri) async {
      Logger().i('onAppLink: $uri');

      await locator<NavigationService>().openAppLink(uri, 'en');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: TingsColors.grayLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: TingsColors.white,
      ),
    );

    // Workaround for rebuilding all widgets if locale is changed
    rebuildAllChildren(context);

    return OKToast(
      child: MaterialApp(
        title: 'thap',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: TingsColors.white,
          canvasColor: TingsColors.white,
          // backgroundColor: TingsColors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: TingsColors.grayDark,
          ).copyWith(
            primary: TingsColors.black,
            secondary: TingsColors.grayDark,
          ),
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationService>().navigatorKey,
        home: const AISettingsPage(),
      ),
    );
  }
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
