import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/dialogs/app_confirmation_dialog.dart';

class ParkingConfirmationModal {
  ParkingConfirmationModal._();

  static Future<void> show(
    BuildContext context, {
    required int parkingPlace,
  }) async {
    await AppConfirmationDialog.show<void>(
      context,
      title: 'Подтверждение',
      message: 'Пожалуйста, проверьте правильность\nуказанных данных',
      details: ['Парковочное место №$parkingPlace'],
      confirmLabel: 'Подтвердить',
      cancelLabel: 'Отмена',
    );
  }
}
