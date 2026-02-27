import 'package:flutter/material.dart';

const _kFieldHeight = 48.0;
const _kButtonWidth = 200.0;
const _kButtonHeight = 44.0;
const _kMainBorder = BorderSide(color: Colors.black87, width: 1);
const _kMainRadius = BorderRadius.all(Radius.circular(12));
const _kFieldTextStyle = TextStyle(
  fontSize: 33 / 2,
  fontWeight: FontWeight.w400,
);
const _kButtonTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const _kFieldLabelStyle = TextStyle(
  fontSize: 18 * 0.9,
  fontWeight: FontWeight.w400,
);

class PassFieldLabel extends StatelessWidget {
  const PassFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _kFieldLabelStyle);
  }
}

class PassInputField extends StatelessWidget {
  const PassInputField({
    super.key,
    required this.hint,
    this.trailing,
    this.hasTrailingBox = false,
    this.onTap,
    this.borderRadius,
  });

  final String hint;
  final Widget? trailing;
  final bool hasTrailingBox;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _kMainRadius,
      child: Container(
        height: _kFieldHeight,
        padding: const EdgeInsets.only(left: 14, right: 10),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(_kMainBorder),
          borderRadius: borderRadius ?? _kMainRadius,
        ),
        child: Row(
          children: [
            Expanded(child: Text(hint, style: _kFieldTextStyle)),
            if (trailing != null)
              hasTrailingBox
                  ? Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(_kMainBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: trailing),
                    )
                  : trailing!,
          ],
        ),
      ),
    );
  }
}

class PassEditableInputField extends StatelessWidget {
  const PassEditableInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kFieldHeight,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: _kMainRadius,
            borderSide: _kMainBorder,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: _kMainRadius,
            borderSide: _kMainBorder,
          ),
        ),
      ),
    );
  }
}

class PassSubmitButton extends StatelessWidget {
  const PassSubmitButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kButtonWidth,
      height: _kButtonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: _kMainRadius),
        ),
        child: Text(text, style: _kButtonTextStyle),
      ),
    );
  }
}
