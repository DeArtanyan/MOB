import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/dialogs/app_confirmation_dialog.dart';

class RequestConfirmationModal {
  RequestConfirmationModal._();

  static Future<void> show(
    BuildContext context, {
    required String date,
    required String time,
    required String requestType,
    required String booking,
  }) async {
    await AppConfirmationDialog.show<void>(
      context,
      title: 'Подтверждение',
      message: 'Пожалуйста, проверьте правильность\nуказанных данных',
      details: ['$date, $time', booking, requestType],
      confirmLabel: 'Подтвердить',
      cancelLabel: 'Отмена',
    );
  }
}
