import 'package:flutter/material.dart';

class RequestFormStyles {
  RequestFormStyles._();

  static const title = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static const fieldLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const fieldText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const fieldBorderRadius = BorderRadius.all(Radius.circular(12));
  static const dropdownOpenRadius = BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
  );
  static const dropdownMenuRadius = BorderRadius.only(
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );

  static const inputBorder = BorderSide(color: Colors.black87, width: 1);

  static BoxDecoration outlinedField({BorderRadius? radius}) {
    return BoxDecoration(
      border: Border.all(color: Colors.black87, width: 1),
      borderRadius: radius ?? fieldBorderRadius,
    );
  }

  static const dropdownMenuBorder = Border(
    left: inputBorder,
    right: inputBorder,
    bottom: inputBorder,
  );
}
