import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/widgets/layout/app_logo_top_left.dart';
import 'package:wordpice/features/auth/presentation/screens/account_confirmation_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/register_screen.dart';
import 'package:wordpice/features/auth/presentation/widgets/buttons/auth_action_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/cards/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _openRegister() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RegisterScreen()));
  }

  void _openAccountConfirmation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AccountConfirmationScreen()),
    );
  }

  void _openForgotPassword() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
  }

  void _openProfile() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppLogoTopLeft(useHero: true),
            Center(
              child: SingleChildScrollView(
                padding: AuthStyles.screenHorizontalPadding,
                child: AuthFormCard(
                  padding: AuthStyles.formPaddingCompact,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Center(child: AuthTitleText('Авторизация')),
                      const SizedBox(height: 26),
                      const AuthLabelText('Эл.почта*'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppInputDecorations.authField(
                          hintText: 'Введите электронную почту',
                        ),
                      ),
                      const SizedBox(height: 18),
                      const AuthLabelText('Пароль*'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: AppInputDecorations.authField(
                          hintText: 'Введите пароль',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: _openForgotPassword,
                            child: const AuthBodyText('Забыли пароль?'),
                          ),
                          TextButton(
                            onPressed: _openRegister,
                            child: const AuthBodyText('Зарегистрироваться'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: AuthActionButton(
                          label: 'Войти',
                          onPressed: _openProfile,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: AuthActionButton(
                          label: 'Подтвердить аккаунт',
                          onPressed: _openAccountConfirmation,
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
