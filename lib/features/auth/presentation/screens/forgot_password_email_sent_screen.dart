import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/widgets/buttons/app_back_button.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/auth/presentation/widgets/cards/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';

class ForgotPasswordEmailSentScreen extends StatelessWidget {
  const ForgotPasswordEmailSentScreen({super.key});

  void _openAuth(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openAuth(context),
          child: Stack(
            children: [
              const AppBackButton(),
              Padding(
                padding: AuthStyles.screenHorizontalPadding,
                child: Center(
                  child: AuthFormCard(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
