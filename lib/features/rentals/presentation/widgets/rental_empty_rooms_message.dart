import 'package:flutter/material.dart';

class RentalEmptyRoomsMessage extends StatelessWidget {
  const RentalEmptyRoomsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Нет свободных помещений',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
