import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thap/features/auth/presentation/pages/login_page.dart';
import 'package:thap/features/auth/presentation/providers/auth_provider.dart';
import 'package:thap/features/products/presentation/pages/scan_page.dart';
import 'package:thap/features/products/presentation/pages/product_detail_page.dart';
import 'package:thap/features/wallet/presentation/pages/my_things_page.dart';
import 'package:thap/ui/pages/home_page.dart';

/// App router configuration using GoRouter
class AppRouter {
  AppRouter._();

  static GoRouter createRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshNotifier(ref),
      routes: [
        // Login Route
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),

        // Home Route (temporary - will be replaced with feature-based pages)
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        // Scan Route
        GoRoute(
          path: '/scan',
          name: 'scan',
          builder: (context, state) => const ScanPage(),
        ),

        // Product Detail Route
        GoRoute(
          path: '/product/:id',
          name: 'product',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailPage(productId: productId);
          },
        ),

        // My Things Route
        GoRoute(
          path: '/my-things',
          name: 'my-things',
          builder: (context, state) => const MyThingsPage(),
        ),
      ],

      // Redirect logic based on authentication
      redirect: (context, state) {
        final authState = ref.read(authProvider);
        final isAuthenticated = authState.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );
        final isLoginRoute = state.matchedLocation == '/login';

        if (!isAuthenticated && !isLoginRoute) {
          return '/login';
        }
        if (isAuthenticated && isLoginRoute) {
          return '/home';
        }
        return null;
      },

      // Error handling
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
    );
  }
}

/// Helper to refresh GoRouter when auth state changes
class GoRouterRefreshNotifier extends ChangeNotifier {
  final WidgetRef _ref;
  late final StreamSubscription<void> _subscription;

  GoRouterRefreshNotifier(this._ref) {
    // Listen to auth state changes
    _subscription = _ref.listen(
      authProvider,
      (previous, next) {
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

