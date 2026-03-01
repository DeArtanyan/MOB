import 'package:flutter/material.dart';

class ParkingStyles {
  ParkingStyles._();

  static const title = TextStyle(fontSize: 19, fontWeight: FontWeight.w600);
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
