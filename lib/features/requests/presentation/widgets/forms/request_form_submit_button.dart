import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/buttons/app_action_menu_button.dart';
import 'package:wordpice/features/requests/presentation/widgets/styles/request_form_styles.dart';

class RequestFormSubmitButton extends StatelessWidget {
  const RequestFormSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppActionMenuButton(
      width: 210,
      height: 44,
      text: text,
      textStyle: RequestFormStyles.buttonText,
      onPressed: onPressed,
    );
  }
}
