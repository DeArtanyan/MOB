import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_styles.dart';

class AuthTitleText extends StatelessWidget {
  const AuthTitleText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, style: AppTextStyles.title26);
  }
}

class AuthLabelText extends StatelessWidget {
  const AuthLabelText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.label12Grey);
  }
}

class AuthBodyText extends StatelessWidget {
  const AuthBodyText(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, style: AppTextStyles.body14);
  }
}

class AuthHeaderText extends StatelessWidget {
  const AuthHeaderText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.header20);
  }
}

class AuthHelperText extends StatelessWidget {
  const AuthHelperText(this.text, {super.key, this.small = false});

  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: small ? AuthStyles.helperTextSmall : AuthStyles.helperText,
    );
  }
}

class AuthPolicyBodyText extends StatelessWidget {
  const AuthPolicyBodyText(this.text, {super.key});

  final String text;
  static const _style = TextStyle(
    fontSize: 14,
    color: Colors.black87,
    height: 1.4,
  );

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style);
  }
}

class AuthStatusText extends StatelessWidget {
  const AuthStatusText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AuthStyles.statusText,
    );
  }
}

class AuthPolicyCheckboxText extends StatelessWidget {
  const AuthPolicyCheckboxText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AuthStyles.policyCheckboxText);
  }
}

class AuthPolicyText extends StatelessWidget {
  const AuthPolicyText(this.text, {super.key, this.small = false});

  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: small ? AuthStyles.policyTextSmall : AuthStyles.policyText,
    );
  }
}
