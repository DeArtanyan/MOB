import 'package:flutter/material.dart';

class AppOutlinedIconButton extends StatelessWidget {
  const AppOutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 28,
    this.iconSize = 18,
    this.radius = 8,
    this.padding = EdgeInsets.zero,
    this.borderColor = Colors.black87,
    this.iconColor = Colors.black87,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
