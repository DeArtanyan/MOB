import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/rentals/presentation/widgets/styles/rental_widget_styles.dart';

class RentalTimeSlotChip extends StatelessWidget {
  const RentalTimeSlotChip({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 35,
          decoration: RentalWidgetStyles.outlinedBox(
            8,
            color: AppColors.formSurface,
          ),
          alignment: Alignment.center,
          child: Text(text, style: RentalWidgetStyles.chipText),
        ),
      ),
    );
  }
}
