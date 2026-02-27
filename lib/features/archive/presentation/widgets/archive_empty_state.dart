import 'package:flutter/material.dart';

class ArchiveEmptyState extends StatelessWidget {
  const ArchiveEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 420,
      child: Center(
        child: Text(
          'Помещения отсутствуют',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
