import 'package:flutter/material.dart';
import 'package:wordpice/features/requests/presentation/widgets/styles/request_form_styles.dart';

class RequestFormFieldLabel extends StatelessWidget {
  const RequestFormFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: RequestFormStyles.fieldLabel);
  }
}
