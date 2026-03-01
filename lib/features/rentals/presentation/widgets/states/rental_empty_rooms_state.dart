import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/states/app_empty_state_text.dart';
import 'package:wordpice/features/rentals/presentation/widgets/styles/rental_widget_styles.dart';

class RentalEmptyRoomsState extends StatelessWidget {
  const RentalEmptyRoomsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppEmptyStateText(
      text: 'Нет свободных помещений',
      style: RentalWidgetStyles.emptyStateText,
    );
  }
}
