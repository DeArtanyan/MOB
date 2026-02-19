import 'package:flutter/material.dart';

class PassFieldLabel extends StatelessWidget {
  const PassFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18 * 0.9,
        fontWeight: FontWeight.w400,
      ),
    );
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 14, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87, width: 1),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: const TextStyle(fontSize: 33 / 2, fontWeight: FontWeight.w400),
              ),
            ),
            if (trailing != null)
              hasTrailingBox
                  ? Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 1),
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
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
        ),
      ),
    );
  }
}

class PassSubmitButton extends StatelessWidget {
  const PassSubmitButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
