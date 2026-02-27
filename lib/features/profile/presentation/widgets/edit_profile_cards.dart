import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/widgets/edit_profile_styles.dart';

class EditProfileField {
  const EditProfileField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;
}

class EditProfilePreviewCard extends StatelessWidget {
  const EditProfilePreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: EditProfileStyles.cardRadius,
      ),
      padding: EditProfileStyles.previewCardPadding,
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: SvgPicture.asset(
                  'assets/icons/edit-2.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Фамилия Имя Отчество',
                  style: EditProfileStyles.previewNameStyle,
                ),
                SizedBox(height: 4),
                Text('Должность', style: EditProfileStyles.previewRoleStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileEditorCard extends StatelessWidget {
  const EditProfileEditorCard({
    super.key,
    required this.fields,
    required this.onDeleteTap,
  });

  final List<EditProfileField> fields;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 410,
      decoration: const BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: EditProfileStyles.cardRadius,
      ),
      padding: EditProfileStyles.editorCardPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('ОСНОВНОЕ', style: EditProfileStyles.sectionTitleStyle),
            for (final field in fields) ...[
              const SizedBox(height: 8),
              _LabeledInput(label: field.label, controller: field.controller),
            ],
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: EditProfileStyles.deleteButtonWidth,
                height: EditProfileStyles.deleteButtonHeight,
                child: OutlinedButton(
                  onPressed: onDeleteTap,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87, width: 1),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    shape: const RoundedRectangleBorder(
                      borderRadius: EditProfileStyles.deleteButtonRadius,
                    ),
                  ),
                  child: const Text(
                    'Удалить аккаунт',
                    style: EditProfileStyles.deleteButtonTextStyle,
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

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: EditProfileStyles.inputLabelStyle),
        const SizedBox(height: 3),
        Container(
          height: 28,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black26, width: 1)),
          ),
          child: TextField(
            controller: controller,
            style: EditProfileStyles.inputTextStyle,
            decoration: EditProfileStyles.inputDecoration,
          ),
        ),
      ],
    );
  }
}
