import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_logo_top_left.dart';
import 'register_fio_screen.dart';
import 'auth_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToFio() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterFioScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppLogoTopLeft(),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    const Center(
                      child: Text(
                        'Регистрация',
                        style: AppTextStyles.title26,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text('Эл.почта*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Введите электронную почту',
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text('Пароль*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
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

                    const SizedBox(height: 26),

                    Center(
                      child: OutlinedButton(
                        onPressed: _goToFio,
                        child: const Text('Зарегистрироваться'),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Center(
                      child: Text(
                        'Уже есть аккаунт?',
                        style: AppTextStyles.body14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const AuthScreen()),
                          );
                        },
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
