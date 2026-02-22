import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class DeleteAccountModal {
  const DeleteAccountModal._();

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  static const TextStyle _messageStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.35,
  );
  static const TextStyle _buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static ButtonStyle _modalButtonStyle(Color backgroundColor) {
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      side: const BorderSide(color: Colors.black87, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Удаление',
                  style: _titleStyle,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Вы действительно хотите удалить\nпрофиль?',
                  textAlign: TextAlign.center,
                  style: _messageStyle,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: _modalButtonStyle(AppColors.controlGrey),
                    child: const Text(
                      'Удалить',
                      style: _buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: _modalButtonStyle(AppColors.background),
                    child: const Text(
                      'Отмена',
                      style: _buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
