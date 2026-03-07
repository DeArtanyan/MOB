import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/edit_profile_styles.dart';

class EditProfileActionsSection extends StatelessWidget {
  const EditProfileActionsSection({
    super.key,
    required this.onSaveTap,
    required this.onExitTap,
  });

  final VoidCallback onSaveTap;
  final VoidCallback onExitTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: EditProfileStyles.saveButtonWidth,
          height: EditProfileStyles.saveButtonHeight,
          child: OutlinedButton(
            onPressed: onSaveTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.formSurface,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: EditProfileStyles.saveButtonRadius,
              ),
            ),
            child: const Text(
              'Сохранить',
              style: EditProfileStyles.primaryButtonTextStyle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onExitTap,
          child: const Text(
            'Выйти без сохранения',
            style: EditProfileStyles.exitTextStyle,
          ),
        ),
      ],
    );
  }
}
