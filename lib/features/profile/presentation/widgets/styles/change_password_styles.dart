import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ChangePasswordStyles {
  ChangePasswordStyles._();

  static const double maxContentWidth = 360;
  static const screenPadding = EdgeInsets.fromLTRB(16, 44, 16, 28);
  static const cardPadding = EdgeInsets.fromLTRB(24, 40, 24, 30);

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(18));

  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
