import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/widgets/layout/app_logo_top_left.dart';
import 'package:wordpice/features/auth/presentation/screens/account_confirmation_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/auth/presentation/screens/privacy_policy_screen.dart';
import 'package:wordpice/features/auth/presentation/widgets/buttons/auth_action_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/cards/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';

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
  bool _isPersonalDataAccepted = false;

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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
  }

  void _goToAccountConfirmation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AccountConfirmationScreen()),
    );
  }

  void _goToAuth() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppLogoTopLeft(),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 112, 24, 12),
                child: SingleChildScrollView(
                  child: AuthFormCard(
                    padding: AuthStyles.formPaddingCompact,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: AuthTitleText('Регистрация')),
                        const SizedBox(height: 10),
                        const AuthLabelText('Имя*'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _firstNameController,
                          decoration: AppInputDecorations.authField(
                            hintText: 'Введите имя',
                          ),
                        ),
                        const SizedBox(height: 30),
                        const AuthLabelText('Фамилия*'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _lastNameController,
                          decoration: AppInputDecorations.authField(
                            hintText: 'Введите фамилию',
                          ),
                        ),
                        const SizedBox(height: 30),
                        const AuthLabelText('Отчество (необязательно)'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _middleNameController,
                          decoration: AppInputDecorations.authField(
                            hintText: 'Введите отчество',
                          ),
                        ),
                        const SizedBox(height: 30),
                        const AuthLabelText('Эл.почта*'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppInputDecorations.authField(
                            hintText: 'Введите электронную почту',
                          ),
                        ),
                        const SizedBox(height: 30),
                        const AuthLabelText('Пароль*'),
                        const SizedBox(height: 4),
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
                        const SizedBox(height: 30),
                        const AuthLabelText('Подтвердите пароль*'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: AppInputDecorations.authField(
                            hintText: 'Введите пароль',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _isPersonalDataAccepted,
                                onChanged: (value) {
                                  setState(() {
                                    _isPersonalDataAccepted = value ?? false;
                                  });
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: AuthPolicyCheckboxText(
                                'Я принимаю условия обработки персональных данных',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: InkWell(
                            onTap: _openPolicy,
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              child: AuthPolicyText(
                                'Нажимая на кнопку “Зарегистрироваться”,\nя соглашаюсь с условиями\nПолитики конфиденциальности',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: AuthActionButton(
                            label: 'Зарегистрироваться',
                            onPressed: _goToAccountConfirmation,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Center(child: AuthBodyText('Уже есть аккаунт?')),
                        Center(
                          child: TextButton(
                            onPressed: _goToAuth,
                            child: const AuthBodyText('Авторизация'),
                          ),
                        ),
                      ],
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
