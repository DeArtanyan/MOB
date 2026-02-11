import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'forgot_password_new_password_screen.dart';

class ForgotPasswordCodeScreen extends StatefulWidget {
  const ForgotPasswordCodeScreen({super.key});

  @override
  State<ForgotPasswordCodeScreen> createState() => _ForgotPasswordCodeScreenState();
}

class _ForgotPasswordCodeScreenState extends State<ForgotPasswordCodeScreen> {
  static const int _codeLength = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      final last = value.characters.last;
      _controllers[index].text = last;
      _controllers[index].selection = const TextSelection.collapsed(offset: 1);
    }

    if (_controllers[index].text.isNotEmpty) {
      if (index < _codeLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) _focusNodes[index - 1].requestFocus();
    }
  }

  Widget _codeBox(int index) {
    return SizedBox(
      width: 44,
      height: 44,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (v) => _onChanged(index, v),
      ),
    );
  }

  void _goToNewPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ForgotPasswordNewPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackButton(),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    const Center(
                      child: Text(
                        'Восстановление\nпароля',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title26,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'Введите код, отправленный Вам на почту',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text('Код', style: AppTextStyles.body14),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_codeLength, (i) => _codeBox(i)),
                    ),

                    const SizedBox(height: 22),

                    Center(
                      child: OutlinedButton(
                        onPressed: _goToNewPassword,
                        child: const Text('Отправить'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
