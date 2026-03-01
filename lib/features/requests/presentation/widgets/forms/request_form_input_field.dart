import 'package:flutter/material.dart';
import 'package:wordpice/features/requests/presentation/widgets/styles/request_form_styles.dart';

class RequestFormInputField extends StatelessWidget {
  const RequestFormInputField({
    super.key,
    required this.hint,
    required this.trailing,
    this.onTap,
    this.borderRadius,
    this.showTrailingFrame = true,
  });

  final String hint;
  final Widget trailing;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final bool showTrailingFrame;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: RequestFormStyles.fieldBorderRadius,
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 14, right: 10),
        decoration: RequestFormStyles.outlinedField(radius: borderRadius),
        child: Row(
          children: [
            Expanded(child: Text(hint, style: RequestFormStyles.fieldText)),
            showTrailingFrame
                ? Container(
                    width: 28,
                    height: 28,
                    decoration: RequestFormStyles.outlinedField(
                      radius: BorderRadius.circular(8),
                    ),
                    child: Center(child: trailing),
                  )
                : SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(child: trailing),
                  ),
          ],
        ),
      ),
    );
  }
}
