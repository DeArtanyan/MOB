import 'package:flutter/material.dart';

class RentalDateFilter extends StatelessWidget {
  const RentalDateFilter({
    super.key,
    this.leftPadding = 0,
    this.text = '5 февраля',
    this.onTap,
  });

  final double leftPadding;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          ),
        ],
      ),
    );

    if (leftPadding == 0) return content;

    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: content,
    );
  }
}
