import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/features/auth/presentation/widgets/buttons/auth_action_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/cards/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';
import 'forgot_password_email_sent_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _goToEmailSent() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ForgotPasswordEmailSentScreen()),
    );
  }

  void _goBack() {
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
                    onPressed: _goBack,
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
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: AuthFormCard(
                      padding: AuthStyles.formPaddingCompact,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Забыли пароль?',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.title26,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Center(
                            child: AuthHelperText(
                              'Введите адрес эл. почты от аккаунта,\nмы отправим Вам временный пароль\nдля входа в аккаунт',
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            'Эл.почта*',
                            style: AppTextStyles.label12Grey.copyWith(
                              fontFamily: AuthStyles.interFontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: AppInputDecorations.authField(
                              hintText: 'Введите электронную почту',
                            ),
                          ),
                          const SizedBox(height: 22),
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: AuthActionButton(
                                label: 'Отправить',
                                onPressed: _goToEmailSent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
