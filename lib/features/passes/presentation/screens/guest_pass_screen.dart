import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_confirmation_modal.dart';

/// Экран "Пропуск гостя" (UI-only).
class GuestPassScreen extends StatefulWidget {
  const GuestPassScreen({super.key});

  @override
  State<GuestPassScreen> createState() => _GuestPassScreenState();
}

class _GuestPassScreenState extends State<GuestPassScreen> {
  static const int _tabIndex = 2; // Пропуск
  int _selectedBottomIndex = _tabIndex;
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() => setState(() {});

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

  void _onBottomChanged(int index) {
    AppTabNavigator.goToTab(context, index);
  }

  bool get _canBuyPass => _emailController.text.trim().isNotEmpty;

  Future<void> _showPurchaseModal() {
    return PassConfirmationModal.show(
      context,
      email: _emailController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      onLogout: _logout,
      onNotifications: () {},
      notificationCount: 0,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Пропуск',
                    style: TextStyle(
                      fontSize: 44 / 2,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Пропуск для гостя является одноразовым и\nдействует всего 2 часа',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: double.infinity,
                  child: _FieldLabel('Эл.почта*'),
                ),
                const SizedBox(height: 8),
                _EditableInputField(
                  controller: _emailController,
                  hint: 'Введите электронную почту',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: _canBuyPass ? _showPurchaseModal : null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Купить пропуск',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code_2, size: 120),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

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

class _EditableInputField extends StatelessWidget {
  const _EditableInputField({
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
