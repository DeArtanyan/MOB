import 'package:flutter/material.dart';

class AppConfirmationDialog {
  AppConfirmationDialog._();

  static const double _defaultMaxWidth = 300;
  static const double _defaultButtonHeight = 44;
  static const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(
    horizontal: 34,
  );
  static const EdgeInsets _defaultContentPadding = EdgeInsets.fromLTRB(
    16,
    22,
    16,
    18,
  );
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  static const TextStyle _messageStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
  static const TextStyle _detailStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

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
          backgroundColor: backgroundColor,
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
                    height: buttonHeight,
                    backgroundColor: confirmBackgroundColor,
                    onPressed: () =>
                        Navigator.of(dialogContext).pop(confirmResult),
                  ),
                  const SizedBox(height: 12),
                  _DialogButton(
                    label: cancelLabel,
                    height: buttonHeight,
                    backgroundColor: cancelBackgroundColor,
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
    required this.height,
    required this.onPressed,
    this.backgroundColor,
  });

  final String label;
  final double height;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(backgroundColor: backgroundColor),
        child: Text(label),
      ),
    );
  }
}
