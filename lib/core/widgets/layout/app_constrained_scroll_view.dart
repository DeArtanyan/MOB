import 'package:flutter/material.dart';

class AppConstrainedScrollView extends StatelessWidget {
  const AppConstrainedScrollView({
    super.key,
    required this.child,
    required this.maxWidth,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 24),
    this.centerVertically = false,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool centerVertically;

  @override
  Widget build(BuildContext context) {
    final resolvedPadding = padding.resolve(Directionality.of(context));

    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight = (constraints.maxHeight - resolvedPadding.vertical)
            .clamp(0, double.infinity)
            .toDouble();

        return SingleChildScrollView(
          padding: padding,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                minHeight: centerVertically ? minHeight : 0,
              ),
              child: centerVertically ? Center(child: child) : child,
            ),
          ),
        );
      },
    );
  }
}
