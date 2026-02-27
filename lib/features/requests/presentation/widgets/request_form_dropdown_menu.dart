import 'package:flutter/material.dart';

class RequestFormDropdownMenu extends StatelessWidget {
  const RequestFormDropdownMenu({
    super.key,
    required this.items,
    required this.onSelect,
    required this.height,
  });

  final List<String> items;
  final ValueChanged<String> onSelect;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -1, 0),
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 6),
        itemBuilder: (context, index) {
          final value = items[index];
          return InkWell(
            onTap: () => onSelect(value),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

