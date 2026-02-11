import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Текстовые стили приложения.
/// 
/// Что изменено:
/// - title26 теперь использует Montserrat Alternates Regular 26
/// - Остальные стили оставлены, чтобы не ломать существующий код
class AppTextStyles {
  AppTextStyles._();

  /// Название шрифта должно совпадать с pubspec.yaml
  static const String _titleFontFamily = 'MontserratAlternates';

  /// Заголовок 26 (например: "Авторизация")
  /// Figma: Montserrat Alternates Regular, 26
  static const TextStyle title26 = TextStyle(
    fontFamily: _titleFontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w400, // Regular
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle header20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle label12Grey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle hint12Grey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle body14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
