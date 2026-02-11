import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle title26 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle header20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle label12Grey = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle hint12Grey = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle body14 = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
}
