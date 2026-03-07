import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class AppConfirmationDialog {
  AppConfirmationDialog._();

  static const double _defaultMaxWidth = 300;
  static const double _defaultButtonHeight = 44;
  static const double _defaultButtonWidth = 200;
  static const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(
    horizontal: 34,
  );
  static const EdgeInsets _defaultContentPadding = EdgeInsets.fromLTRB(16, 22, 16, 18,);
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  static const TextStyle _messageStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
  static const TextStyle _detailStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  static const Color _defaultConfirmButtonColor = Color(0x407C8FA0);
  static const Color _defaultCancelButtonColor = Color(0x807C8FA0);

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    List<String> details = const [],
    T? confirmResult,
    T? cancelResult,
    bool barrierDismissible = true,
    double maxWidth = _defaultMaxWidth,
    double buttonWidth = _defaultButtonWidth,
    double buttonHeight = _defaultButtonHeight,
    Color? backgroundColor,
    Color? confirmBackgroundColor,
    Color? cancelBackgroundColor,
    TextStyle titleStyle = _titleStyle,
    TextStyle messageStyle = _messageStyle,
    TextStyle detailStyle = _detailStyle,
    EdgeInsets insetPadding = _defaultInsetPadding,
    EdgeInsets contentPadding = _defaultContentPadding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: backgroundColor ?? AppColors.modalBackground,
          insetPadding: insetPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: contentPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: titleStyle),
                  const SizedBox(height: 14),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: messageStyle,
                  ),
                  if (details.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    ...List.generate(details.length, (index) {
                      final detail = details[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == details.length - 1 ? 0 : 8,
                        ),
                        child: Text(
                          detail,
                          textAlign: TextAlign.center,
                          style: detailStyle,
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 18),
                  _DialogButton(
                    label: confirmLabel,
                    width: buttonWidth,
                    height: buttonHeight,
                    backgroundColor:
                        confirmBackgroundColor ?? _defaultConfirmButtonColor,
                    onPressed: () =>
                        Navigator.of(dialogContext).pop(confirmResult),
                  ),
                  const SizedBox(height: 12),
                  _DialogButton(
                    label: cancelLabel,
                    width: buttonWidth,
                    height: buttonHeight,
                    backgroundColor:
                        cancelBackgroundColor ?? _defaultCancelButtonColor,
                    onPressed: () =>
                        Navigator.of(dialogContext).pop(cancelResult),
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

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.backgroundColor,
  });

  final String label;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black87, width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: onPressed,
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
