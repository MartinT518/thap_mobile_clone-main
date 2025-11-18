import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/features/auth/presentation/providers/auth_provider.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/shared/widgets/design_system_components.dart';
import 'package:thap/shared/widgets/terms_policy_message_v2.dart';

/// Login page with Google OAuth sign-in
/// Follows Design System v2.0 specifications
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    // Try to restore session on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to auth state changes and navigate
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (_) {
          // Navigate to home on successful authentication
          context.go('/home');
        },
        error: (message) {
          // Show error toast
          showToast(
            tr('login.error'),
            duration: const Duration(seconds: 3),
            position: ToastPosition.bottom,
          );
        },
        orElse: () {},
      );
    });

    // If authenticated, show loading (will navigate)
    if (authState.maybeWhen(authenticated: (_) => true, orElse: () => false)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Loading state
    if (authState.maybeWhen(loading: () => true, orElse: () => false)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.gray50, // Design System: Page backgrounds
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingM), // 16px - Design System
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Pyramid image (top section)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingL, // 24px
                ),
                child: Image.asset(
                  'assets/login-pyramid.png',
                  fit: BoxFit.contain,
                ),
              ),
              
              // Spacing: 48px (Design System: spacingXXL)
              const SizedBox(height: AppTheme.spacingXXL),
              
              // Logo SVG
              SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.contain,
              ),
              
              // Spacing: 16px (Design System: spacingM)
              const SizedBox(height: AppTheme.spacingM),
              
              // Message text - using Heading4 (14px, bold) per existing design
              Heading4(
                tr('login.message'),
                color: AppTheme.gray900, // Design System: Text primary
                textAlign: TextAlign.center,
              ),
              
              // Spacing: 64px (Design System: spacingXXXL)
              const SizedBox(height: AppTheme.spacingXXXL),
              
              // Sign in button - custom styled per existing design
              _buildSignInButton(authState),
              
              // Spacing: 24px (Design System: spacingL)
              const SizedBox(height: AppTheme.spacingL),
              
              // Terms and privacy message
              TermsPolicyMessageV2(language: context.locale.languageCode),
              
              // Bottom spacing: 12px
              const SizedBox(height: AppTheme.spacingS),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(AuthState authState) {
    final isLoading = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    // Design System Primary Button Specification (Section 5.1):
    // Background: Primary Blue 500 (#2196F3)
    // Text: White
    // Height: 48px (minimum tap target)
    // Border Radius: 24px (pill shape)
    // Font: Label Large (14px, Weight 500)
    // Elevation: 2dp
    return ElevatedButton.icon(
      onPressed: isLoading
          ? null
          : () async {
              await ref.read(authProvider.notifier).signInWithGoogle();
            },
      style: DesignSystemComponents.primaryButton(
        isDisabled: isLoading,
      ),
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : TingIcon('google', width: 24, height: 24, color: Colors.white),
      label: Text(
        isLoading ? 'Signing in...' : tr('login.signin_google'),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              // Design System: Label Large (14px, Weight 500)
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
    );
  }
}
