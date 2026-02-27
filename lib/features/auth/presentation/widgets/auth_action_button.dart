import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_styles.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AuthStyles.actionButtonWidth,
      height: AuthStyles.actionButtonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label, style: AppTextStyles.body14),
      ),
    );
  }
}
