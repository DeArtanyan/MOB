import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

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
  static const titleText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  static const emptyStateText = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.border, width: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
