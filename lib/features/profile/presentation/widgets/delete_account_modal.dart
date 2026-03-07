import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/dialogs/app_confirmation_dialog.dart';

class DeleteAccountModal {
  const DeleteAccountModal._();

  static const TextStyle _messageStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static Future<void> show(BuildContext context) async {
    await AppConfirmationDialog.show<void>(
      context,
      title: 'Удаление',
      message: 'Вы действительно хотите удалить\nпрофиль?',
      confirmLabel: 'Удалить',
      cancelLabel: 'Отмена',
      backgroundColor: AppColors.modalBackground,
      messageStyle: _messageStyle,
      contentPadding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
    );
  }
}
