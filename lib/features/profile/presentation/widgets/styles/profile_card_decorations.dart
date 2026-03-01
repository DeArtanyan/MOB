import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ProfileCardDecorations {
  ProfileCardDecorations._();

  static const double outlineRadiusValue = 8;
  static const BorderSide outlineBorderSide = BorderSide(
    color: AppColors.border,
    width: 1,
  );
  static const BorderRadius outlineRadius = BorderRadius.all(
    Radius.circular(outlineRadiusValue),
  );

  static BoxDecoration outlinedCard({Color color = Colors.transparent}) {
    return BoxDecoration(
      color: color,
      border: Border.fromBorderSide(outlineBorderSide),
      borderRadius: outlineRadius,
    );
  }
}
