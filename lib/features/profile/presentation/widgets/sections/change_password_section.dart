import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/features/auth/presentation/widgets/buttons/auth_action_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/sections/auth_text.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/change_password_styles.dart';

class ChangePasswordSection extends StatelessWidget {
  const ChangePasswordSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onSubmit,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ChangePasswordStyles.cardPadding,
      decoration: const BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: ChangePasswordStyles.cardRadius,
      ),
      child: Column(
        children: [
          const AuthTitleText('Смена пароля'),
          const SizedBox(height: 30),
          _ChangePasswordField(
            label: 'Пароль*',
            hint: 'Введите пароль',
            controller: passwordController,
            obscureText: obscurePassword,
            onToggleVisibility: onTogglePasswordVisibility,
          ),
          const SizedBox(height: 24),
          _ChangePasswordField(
            label: 'Подтвердите пароль*',
            hint: 'Введите пароль',
            controller: confirmPasswordController,
            obscureText: obscureConfirmPassword,
            onToggleVisibility: onToggleConfirmPasswordVisibility,
          ),
          const SizedBox(height: 30),
          Center(
            child: AuthActionButton(
              label: 'Подтвердить',
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangePasswordField extends StatelessWidget {
  const _ChangePasswordField({
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
        Text(label, style: ChangePasswordStyles.inputLabelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: AppInputDecorations.authField(
            hintText: hint,
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
