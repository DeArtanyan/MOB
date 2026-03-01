import 'package:flutter/material.dart';

class AuthStyles {
  AuthStyles._();

  static const screenHorizontalPadding = EdgeInsets.symmetric(horizontal: 24);
  static const formPadding = EdgeInsets.fromLTRB(20, 24, 20, 20);
  static const formPaddingCompact = EdgeInsets.fromLTRB(20, 24, 20, 18);

  static const double actionButtonWidth = 185;
  static const double actionButtonHeight = 42;

  static const helperText = TextStyle(fontSize: 14, color: Colors.black54);

  static const helperTextSmall = TextStyle(fontSize: 12, color: Colors.black54);

  static const policyCheckboxText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const policyText = TextStyle(fontSize: 12, color: Colors.black);

  static const policyTextSmall = TextStyle(fontSize: 10, color: Colors.black);

  static const statusText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
}
