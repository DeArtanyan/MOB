import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';

class NotificationStyles {
  NotificationStyles._();

  static const cardTopicText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const actionText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const messageText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const dateText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
  static const titleText = AppTextStyles.unboundedRegular22;
  static const emptyStateText = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB2C1CB), Color(0xFF7C8FA0)],
      ),
      border: Border.all(color: AppColors.bottomNavBackground, width: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
