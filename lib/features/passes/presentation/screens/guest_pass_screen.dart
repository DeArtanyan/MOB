import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_form_widgets.dart';

/// Экран "Пропуск гостя" (UI-only).
class GuestPassScreen extends StatefulWidget {
  const GuestPassScreen({super.key});

  @override
  State<GuestPassScreen> createState() => _GuestPassScreenState();
}

class _GuestPassScreenState extends State<GuestPassScreen> {
  static const int _tabIndex = 2; // Пропуск
  final int _selectedBottomIndex = _tabIndex;
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() => setState(() {});

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
                    'Пропуск гостя',
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
                  child: PassFieldLabel('Эл.почта*'),
                ),
                const SizedBox(height: 8),
                PassEditableInputField(
                  controller: _emailController,
                  hint: 'Введите электронную почту',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                PassSubmitButton(
                  text: 'Купить пропуск',
                  onPressed: _canBuyPass ? _showPurchaseModal : null,
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


