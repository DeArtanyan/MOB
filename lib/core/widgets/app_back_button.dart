import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double top;
  final double left;

  const AppBackButton({
    super.key,
    this.onTap,
    this.top = 32,
    this.left = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: IconButton(
        iconSize: 16,
        padding: EdgeInsets.zero,
        onPressed: onTap ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new),
        style: IconButton.styleFrom(
          side: const BorderSide(color: Colors.black87),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(28, 28),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
