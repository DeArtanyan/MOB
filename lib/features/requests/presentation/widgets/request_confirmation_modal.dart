import 'package:flutter/material.dart';

class RequestConfirmationModal {
  RequestConfirmationModal._();

  static Future<void> show(
    BuildContext context, {
    required String date,
    required String time,
    required String requestType,
    required String roomType,
    required String cabinet,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Подтверждение',
                    style: TextStyle(
                      fontSize: 36 / 2,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Пожалуйста, проверьте правильность\nуказанных данных',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$date, $time',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24 / 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    requestType,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24 / 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    roomType,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24 / 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cabinet,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24 / 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Подтвердить'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Отмена'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
