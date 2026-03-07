import 'package:flutter/material.dart';

class AuthStyles {
  AuthStyles._();

  static const interFontFamily = 'Inter';

  static const screenHorizontalPadding = EdgeInsets.symmetric(horizontal: 24);
  static const screenPadding = EdgeInsets.fromLTRB(24, 16, 24, 24);
  static const formPadding = EdgeInsets.fromLTRB(20, 24, 20, 20);
  static const formPaddingCompact = EdgeInsets.fromLTRB(20, 40, 20, 30);

  static const double actionButtonWidth = 185;
  static const double actionButtonHeight = 42;

  static const helperText = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 14,
    color: Colors.black54,
  );

  static const helperTextSmall = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    color: Colors.black54,
  );

  static const policyCheckboxText = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const policyText = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    color: Colors.black,
  );

  static const policyTextSmall = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 10,
    color: Colors.black,
  );

  static const statusText = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
}
