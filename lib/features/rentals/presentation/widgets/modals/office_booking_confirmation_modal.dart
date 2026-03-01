import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/dialogs/app_confirmation_dialog.dart';

class OfficeBookingConfirmationModal {
  OfficeBookingConfirmationModal._();

  static Future<bool> show(
    BuildContext context, {
    required String date,
    required String timeRange,
    required String title,
    required String room,
    required int price,
  }) async {
    final result = await AppConfirmationDialog.show<bool>(
      context,
      title: 'Подтверждение',
      message: 'Пожалуйста, проверьте правильность\nуказанных данных',
      details: ['$date, $timeRange', '$title, $room', 'Цена: $priceр'],
      confirmLabel: 'Подтвердить',
      cancelLabel: 'Отмена',
      confirmResult: true,
      cancelResult: false,
      buttonHeight: 40,
    );

    return result ?? false;
  }
}
