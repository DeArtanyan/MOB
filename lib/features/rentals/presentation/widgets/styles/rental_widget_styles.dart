import 'package:flutter/material.dart';

class RentalWidgetStyles {
  RentalWidgetStyles._();

  static const outlineSide = BorderSide(color: Colors.black87, width: 1);

  static const cardText = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const slotInfoText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const priceText = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static const filterText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const chipText = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const emptyStateText = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
  );

  static BoxDecoration outlinedBox(double radius, {Color? color}) {
    return BoxDecoration(
      color: color,
      border: Border.fromBorderSide(outlineSide),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
