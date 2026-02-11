import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'package:wordpice/core/widgets/app_logo_top_left.dart';
import 'privacy_policy_screen.dart';

class RegisterFioScreen extends StatefulWidget {
  const RegisterFioScreen({super.key});

  @override
  State<RegisterFioScreen> createState() => _RegisterFioScreenState();
}

class _RegisterFioScreenState extends State<RegisterFioScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    super.dispose();
  }

  void _openPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppLogoTopLeft(),
            const AppBackButton(top: 110, left: 24),

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

                    const Text('Имя*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(hintText: 'Введите имя'),
                    ),

                    const SizedBox(height: 18),

                    const Text('Фамилия*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(hintText: 'Введите фамилию'),
                    ),

                    const SizedBox(height: 18),

                    const Text('Отчество (необязательно)', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _middleNameController,
                      decoration: const InputDecoration(hintText: 'Введите отчество'),
                    ),

                    const SizedBox(height: 18),

                    const Center(
                      child: Text(
                        'Нажимая на кнопку “Зарегистрироваться”, я соглашаюсь с условиями\nПолитики конфиденциальности',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: OutlinedButton(
                        onPressed: _openPolicy,
                        child: const Text('Зарегистрироваться'),
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
