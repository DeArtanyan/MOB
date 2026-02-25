import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';
import 'register_screen.dart';

class AccountConfirmationScreen extends StatefulWidget {
  const AccountConfirmationScreen({super.key});

  @override
  State<AccountConfirmationScreen> createState() => _AccountConfirmationScreenState();
}

class _AccountConfirmationScreenState extends State<AccountConfirmationScreen> {
  static const int _codeLength = 6;

  final TextEditingController _emailController = TextEditingController();
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
    _emailController.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _goBackToRegister() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
      (route) => false,
    );
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
        decoration: const InputDecoration(contentPadding: EdgeInsets.zero),
        onChanged: (v) => _onChanged(index, v),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppBackButton(onTap: _goBackToRegister),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Center(
                      child: Text(
                        'Подтверждение\nаккаунта',
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
                    const SizedBox(height: 20),
                    const Text('Эл.почта*', style: AppTextStyles.label12Grey),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppInputDecorations.authField(
                        hintText: 'Введите электронную почту',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Код', style: AppTextStyles.body14),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_codeLength, (i) => _codeBox(i)),
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const ProfileScreen()),
                          );
                        },
                        child: const Text('Отправить'),
                        ),
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
