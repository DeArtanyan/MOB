import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';

class ParkingStyles {
  ParkingStyles._();

  static const title = AppTextStyles.unboundedRegular22;
  static const placeNumber = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static BoxDecoration placeDecoration({required bool selected}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: selected ? const Color(0xFFECECEC) : Colors.transparent,
    );
  }
}
