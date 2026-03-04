import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/buttons/app_outlined_icon_button.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/auth/presentation/widgets/styles/auth_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  static const int _tabIndex = 3;
  static const double _contentWidth = 360;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _onBottomChanged(int index) {
    if (index == _tabIndex) {
      Navigator.of(context).pop();
      return;
    }
    AppTabNavigator.goToTab(context, index);
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  void _submit() {}

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _tabIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        padding: const EdgeInsets.fromLTRB(16, 54, 16, 28),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppOutlinedIconButton(
                icon: Icons.arrow_back_ios_new,
                iconSize: 14,
                size: 30,
                radius: 10,
                onPressed: _goBack,
              ),
            ),
            const SizedBox(height: 92),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
                decoration: BoxDecoration(
                  color: AppColors.controlGrey,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Смена пароля',
                      style: AppTextStyles.title26,
                    ),
                    const SizedBox(height: 30),
                    _PasswordField(
                      label: 'Пароль*',
                      hint: 'Введите пароль',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    const SizedBox(height: 24),
                    _PasswordField(
                      label: 'Подтвердите пароль*',
                      hint: 'Введите пароль',
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      onToggleVisibility: () {
                        setState(
                          () =>
                              _obscureConfirmPassword = !_obscureConfirmPassword,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: AuthStyles.actionButtonWidth,
                      height: AuthStyles.actionButtonHeight,
                      child: OutlinedButton(
                        onPressed: _submit,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Подтвердить',
                          style: AppTextStyles.body14,
                        ),
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

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.body14,
          decoration: AppInputDecorations.authField(
            hintText: hint,
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
