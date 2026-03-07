import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/auth/presentation/widgets/cards/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';

class ForgotPasswordEmailSentScreen extends StatelessWidget {
  const ForgotPasswordEmailSentScreen({super.key});

  void _openAuth(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SplashLogo(),
                  const SizedBox(height: 44),
                  IconButton(
                    iconSize: 16,
                    padding: EdgeInsets.zero,
                    onPressed: () => _goBack(context),
                    icon: const Icon(Icons.arrow_back_ios_new),
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Colors.black87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(28, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: AuthStyles.screenPadding,
              child: Align(
                alignment: Alignment.center,
                child: AuthFormCard(
                  padding: AuthStyles.formPaddingCompact,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AuthTitleText('Забыли пароль?'),
                      const SizedBox(height: 30),
                      SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 46,
                        height: 46,
                        colorFilter: const ColorFilter.mode(
                          Colors.black87,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AuthStatusText(
                        'Мы отправили вам временный пароль\nдля входа в аккаунт, проверьте\nпожалуйста свой почтовый ящик',
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => _openAuth(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Авторизация',
                          style: TextStyle(
                            fontFamily: AuthStyles.interFontFamily,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
