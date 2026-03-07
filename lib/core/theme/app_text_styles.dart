import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _titleFontFamily = 'MontserratAlternates';
  static const String unboundedFontFamily = 'Unbounded';

  static const TextStyle title26 = TextStyle(
    fontFamily: _titleFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400, 
    height: 1,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle header20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle label12Grey = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle hint12Grey = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle body14 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle unboundedRegular22 = TextStyle(
    fontFamily: unboundedFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle unboundedRegular24 = TextStyle(
    fontFamily: unboundedFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle unboundedRegular18 = TextStyle(
    fontFamily: unboundedFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
