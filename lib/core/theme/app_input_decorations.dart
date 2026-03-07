import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppInputDecorations {
  AppInputDecorations._();

  static InputDecoration authField({
    required String hintText,
    Widget? suffixIcon,
  }) {
    const borderRadius = BorderRadius.all(Radius.circular(12));

    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppColors.formSurface,
      hintStyle: AppTextStyles.body14.copyWith(color: AppColors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: suffixIcon,
      enabledBorder: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: AppColors.border, width: 1),
      ),
    );
  }
}
