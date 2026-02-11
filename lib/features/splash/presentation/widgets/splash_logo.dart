import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Заглушка логотипа. заменить на Image.asset()
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.image_outlined, color: Colors.black45),
        ),
        const SizedBox(width: 12),
        const Text(
          'LOGOTYPE',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
