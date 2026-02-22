import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_logo_top_left.dart';
import 'package:wordpice/features/auth/presentation/screens/account_confirmation_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/privacy_policy_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _openPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
    );
  }

  void _goToAccountConfirmation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AccountConfirmationScreen()),
    );
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            const AppLogoTopLeft(),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 112, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Регистрация',
                        style: AppTextStyles.title26,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Имя*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _firstNameController,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите имя',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text('Фамилия*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _lastNameController,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите фамилию',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Отчество (необязательно)',
                      style: AppTextStyles.label12Grey,
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _middleNameController,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите отчество',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text('Эл.почта*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите электронную почту',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text('Пароль*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Подтвердите пароль*',
                      style: AppTextStyles.label12Grey,
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscureConfirmPassword = !_obscureConfirmPassword,
                          ),
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: InkWell(
                        onTap: _openPolicy,
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            'Нажимая на кнопку “Зарегистрироваться”, я соглашаюсь с условиями\nПолитики конфиденциальности',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: OutlinedButton(
                        onPressed: _goToAccountConfirmation,
                        child: const Text('Зарегистрироваться'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text(
                        'Уже есть аккаунт?',
                        style: AppTextStyles.body14,
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: _goToAuth,
                        child: const Text('Авторизация'),
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
