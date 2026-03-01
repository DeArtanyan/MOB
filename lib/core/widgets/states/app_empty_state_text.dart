import 'package:flutter/material.dart';

class AppEmptyStateText extends StatelessWidget {
  const AppEmptyStateText({
    super.key,
    required this.text,
    this.style,
    this.height,
    this.padding,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final TextStyle? style;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(text, textAlign: textAlign, style: style),
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (height != null) {
      return SizedBox(height: height, child: content);
    }

    return content;
  }
}
