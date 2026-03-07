import 'package:flutter/material.dart';

class AppActionMenuButton extends StatelessWidget {
  const AppActionMenuButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 280,
    this.height = 52,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    this.backgroundColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
