import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ArchiveStyles {
  ArchiveStyles._();

  static const cardText = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const priceText = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static const dateText = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const emptyStateText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static BoxDecoration outlinedBox(double radius, {Color? color}) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: AppColors.bottomNavBackground, width: 1.5),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
