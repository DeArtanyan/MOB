import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/buttons/app_back_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackButton(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: BoxDecoration(
                    color: AppColors.controlGrey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Center(
                        child: Text(
                          'Забыли пароль?',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title26,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Center(
                        child: Text(
                          'Введите адрес эл. почты от аккаунта,\nмы отправим вам временный пароль\nдля входа в аккаунт',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 26),
                      const Text('Эл.почта*', style: AppTextStyles.label12Grey),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Введите электронную почту',
                        ),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: OutlinedButton(
                            onPressed: _goToEmailSent,
                            child: const Text('Отправить'),
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
