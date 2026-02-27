import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordpice/core/theme/app_input_decorations.dart';
import 'package:wordpice/core/widgets/app_back_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_styles.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_text_widgets.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';

class AccountConfirmationScreen extends StatefulWidget {
  const AccountConfirmationScreen({super.key});

  @override
  State<AccountConfirmationScreen> createState() =>
      _AccountConfirmationScreenState();
}

class _AccountConfirmationScreenState extends State<AccountConfirmationScreen> {
  static const _codeLength = 6;

  final _emailController = TextEditingController();
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
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _submit() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
      return;
    }

    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
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
        onChanged: (value) => _onChanged(index, value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppBackButton(onTap: _goBack),
            Center(
              child: SingleChildScrollView(
                padding: AuthStyles.screenHorizontalPadding,
                child: AuthFormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Center(
                        child: AuthTitleText('Подтверждение\nаккаунта'),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: AuthHelperText(
                          'Введите код, отправленный вам на почту',
                          small: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AuthLabelText('Эл.почта*'),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppInputDecorations.authField(
                          hintText: 'Введите электронную почту',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AuthBodyText('Код'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_codeLength, _codeBox),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: AuthActionButton(
                          label: 'Отправить',
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
