import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ProfileRentalTypeFilters extends StatefulWidget {
  const ProfileRentalTypeFilters({super.key});

  @override
  State<ProfileRentalTypeFilters> createState() => _ProfileRentalTypeFiltersState();
}

class _ProfileRentalTypeFiltersState extends State<ProfileRentalTypeFilters> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget btn(String text, int index) {
      final isSelected = _selectedIndex == index;

      return SizedBox(
        width: 140,
        height: 34,
        child: OutlinedButton(
          onPressed: () => setState(() => _selectedIndex = index),
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ? AppColors.controlGrey : Colors.transparent,
            side: const BorderSide(color: AppColors.border, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btn('Все аренды', 0),
            const SizedBox(width: 10),
            btn('Переговорные', 1),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btn('Коворкинг', 2),
            const SizedBox(width: 10),
            btn('Офис', 3),
          ],
        ),
      ],
    );
  }
}
