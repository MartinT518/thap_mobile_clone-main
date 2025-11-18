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
class ThapApp extends ConsumerWidget {
  const ThapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

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
        routerConfig: router,
      ),
    );
  }
}

/// GoRouter provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.createRouter(ref);
});

