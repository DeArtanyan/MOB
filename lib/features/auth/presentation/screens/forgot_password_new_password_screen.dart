import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';

class ForgotPasswordNewPasswordScreen extends StatefulWidget {
  const ForgotPasswordNewPasswordScreen({super.key});

  @override
  State<ForgotPasswordNewPasswordScreen> createState() => _ForgotPasswordNewPasswordScreenState();
}

class _ForgotPasswordNewPasswordScreenState extends State<ForgotPasswordNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

                    const SizedBox(height: 26),

                    const Text('Новый пароль*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text('Подтвердите пароль*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          // UI-only: позже будет запрос на backend
                        },
                        child: const Text('Подтвердить'),
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
