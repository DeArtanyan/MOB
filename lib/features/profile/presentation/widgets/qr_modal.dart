import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/states/app_empty_state_text.dart';

class QrModal {
  QrModal._();

  static const TextStyle _hintStyle = TextStyle(
    fontSize: 12,
    color: Colors.black54,
  );
  static const TextStyle _messageStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static Future<void> showQr(
    BuildContext context, {
    required String validUntilText,
  }) {
    return _show(
      context,
      title: 'Ваш пропуск',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.qr_code_2, size: 120),
          ),
          const SizedBox(height: 14),
          Text(validUntilText, textAlign: TextAlign.center, style: _hintStyle),
        ],
      ),
    );
  }

  static Future<void> showNoActiveRentals(BuildContext context) {
    return _show(
      context,
      title: 'Пропуск',
      child: const AppEmptyStateText(
        text: 'У вас нет активных аренд\nили приглашения как сотрудника',
        style: _messageStyle,
      ),
    );
  }

  static Future<void> _show(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: const SizedBox.expand(),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  decoration: BoxDecoration(
                    color: AppColors.modalBackground,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black87),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: _titleStyle,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                            splashRadius: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
