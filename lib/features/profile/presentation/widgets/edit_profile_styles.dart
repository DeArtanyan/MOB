import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class EditProfileStyles {
  static const screenPadding = EdgeInsets.fromLTRB(16, 24, 16, 18);
  static const maxContentWidth = 360.0;
  static const editorWidth = 340.0;

  static const saveButtonWidth = 200.0;
  static const saveButtonHeight = 44.0;
  static const deleteButtonWidth = 150.0;
  static const deleteButtonHeight = 40.0;

  static const previewCardPadding = EdgeInsets.fromLTRB(14, 10, 14, 10);
  static const editorCardPadding = EdgeInsets.all(12);

  static const cardRadius = BorderRadius.all(Radius.circular(20));
  static const saveButtonRadius = BorderRadius.all(Radius.circular(12));
  static const deleteButtonRadius = BorderRadius.all(Radius.circular(10));

  static const primaryButtonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const exitTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  static const sectionTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  static const deleteButtonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const inputLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const inputTextStyle = TextStyle(fontSize: 15, color: Colors.black87);
  static const previewNameStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const previewRoleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const inputDecoration = InputDecoration(
    isCollapsed: true,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    contentPadding: EdgeInsets.zero,
  );
}
