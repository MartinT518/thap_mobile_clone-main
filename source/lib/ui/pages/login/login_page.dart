import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/features/auth/domain/entities/user.dart'; // AuthMethod
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';
import 'package:thap/ui/common/typography.dart';
import 'package:thap/ui/pages/home_page.dart';
import 'package:thap/ui/pages/login/register_page.dart';
import 'package:thap/ui/pages/login/terms_policy_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = locator<AuthService>();
  final _toastService = locator<ToastService>();
  final _userRepository = locator<UserRepository>();

  late Future<bool> _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = _authService.tryRestoreSession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData || snapshot.hasError) {
          if (snapshot.hasData && snapshot.data == true) {
            return HomePage();
          } else {
            return Scaffold(
              body: SafeArea(
                bottom: true,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset('assets/login-pyramid.png'),
                      ),
                      const SizedBox(height: 50),
                      SvgPicture.asset('assets/logo.svg'),
                      const SizedBox(height: 18),
                      Heading4(tr('login.message')),
                      const SizedBox(height: 64),
                      SingInButton(
                        text: tr('login.signin_google'),
                        logo: 'google',
                        textColor: TingsColors.black,
                        backgroundColor: TingsColors.white,
                        borderColor: TingsColors.grayMedium,
                        onPressed: () => _signIn(context, AuthMethod.google),
                      ),
                      // TODO: Facebook disabled for now, need to have android app to be in app store for verification
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // SingInButton(
                      //   text: tr('login.signin_facebook'),
                      //   logo: 'facebook',
                      //   textColor: TingsColors.white,
                      //   backgroundColor: const Color(0xff3875F9),
                      //   borderColor: const Color(0xff3875F9),
                      //   onPressed: () =>
                      //       _signIn(context, AuthMethod.facebook),
                      // ),
                      const SizedBox(height: 27),
                      TermsPolicyMessage(language: context.locale.languageCode),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _signIn(BuildContext context, AuthMethod authMethod) async {
    final navigationService = locator<NavigationService>();
    final email = await _authService.socialSignIn(authMethod);

    if (email == null) {
      _toastService.error(tr('login.error')); // Todo different error
    } else {
      final isRegistered = await _userRepository.isRegistered(email);

      if (isRegistered) {
        final authSuccess = await _authService.authenticate();

        if (authSuccess) {
          navigationService.replace(HomePage());
        } else {
          _toastService.error(tr('login.error'));
        }
      } else {
        navigationService.push(RegisterPage());
      }
    }
  }
}

class SingInButton extends StatelessWidget {
  const SingInButton({
    super.key,
    required this.text,
    required this.logo,
    required this.textColor,
    required this.backgroundColor,
    this.onPressed,
    required this.borderColor,
  });

  final String text;
  final String logo;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size.fromHeight(64),
        shape: const StadiumBorder(),
        side: BorderSide(width: 2, color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TingIcon(logo),
          const SizedBox(width: 18),
          Heading4(text, color: textColor),
        ],
      ),
    );
  }
}
