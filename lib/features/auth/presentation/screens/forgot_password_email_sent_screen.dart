import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'package:wordpice/features/auth/presentation/screens/forgot_password_new_password_screen.dart';

class ForgotPasswordEmailSentScreen extends StatelessWidget {
  const ForgotPasswordEmailSentScreen({super.key});

  void _openNewPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ForgotPasswordNewPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openNewPassword(context),
          child: Stack(
            children: [
              const AppBackButton(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Восстановление\nпароля',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title26,
                      ),
                      SizedBox(height: 28),
                      Text(
                        'Мы отправили вам ссылку для сброса\nпароля, проверьте пожалуйста свой\nпочтовый ящик',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          height: 1.35,
                        ),
                      ),
                    ],
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
