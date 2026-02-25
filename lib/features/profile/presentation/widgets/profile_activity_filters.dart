import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/models/profile_activity_filter.dart';

class ProfileActivityFilters extends StatelessWidget {
  const ProfileActivityFilters({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final ProfileActivityFilter selected;
  final ValueChanged<ProfileActivityFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget button(ProfileActivityFilter filter) {
      final isSelected = selected == filter;
      return Expanded(
        child: SizedBox(
          height: 34,
          child: OutlinedButton(
            onPressed: () => onChanged(filter),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.border, width: 1),
              backgroundColor: isSelected ? AppColors.controlGrey : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              filter.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        button(ProfileActivityFilter.rentalHistory),
        const SizedBox(width: 8),
        button(ProfileActivityFilter.favorites),
        const SizedBox(width: 8),
        button(ProfileActivityFilter.requests),
      ],
    );
  }
}
