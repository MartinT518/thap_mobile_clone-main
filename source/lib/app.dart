import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/core/router/app_router.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/ui/common/colors.dart';

/// Main app widget with Riverpod and GoRouter
class ThapApp extends ConsumerStatefulWidget {
  const ThapApp({super.key});

  @override
  ConsumerState<ThapApp> createState() => _ThapAppState();
}

class _ThapAppState extends ConsumerState<ThapApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(ref);
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: TingsColors.grayLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: TingsColors.white,
      ),
    );

    return OKToast(
      child: MaterialApp.router(
        title: 'Thap',
        debugShowCheckedModeBanner: false,
        
        // Localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        
        // Theme
        theme: AppTheme.lightTheme,
        
        // Router
        routerConfig: _router,
      ),
    );
  }
}

