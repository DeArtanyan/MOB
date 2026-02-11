import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'forgot_password_code_screen.dart';

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

  void _goToCode() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ForgotPasswordCodeScreen()),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    const Center(
                      child: Text(
                        'Восстановление\nпароля',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title26,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'Введите адрес эл. почты от аккаунта, мы\nотправим Вам код сброса пароля',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.4,
                        ),
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
                      child: OutlinedButton(
                        onPressed: _goToCode,
                        child: const Text('Отправить'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
