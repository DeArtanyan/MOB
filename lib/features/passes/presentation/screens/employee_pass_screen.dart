import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';

/// Экран "Пропуск сотруднику" (UI-only).
class EmployeePassScreen extends StatefulWidget {
  const EmployeePassScreen({super.key});

  @override
  State<EmployeePassScreen> createState() => _EmployeePassScreenState();
}

class _EmployeePassScreenState extends State<EmployeePassScreen> {
  static const int _tabIndex = 2; // Пропуск
  int _selectedBottomIndex = _tabIndex;

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      onLogout: _logout,
      onNotifications: () {},
      notificationCount: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(36, 16, 36, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Пропуск',
              style: TextStyle(
                fontSize: 44 / 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 18),
            _FieldLabel('Эл.почта*'),
            SizedBox(height: 8),
            _InputField(hint: 'Введите электронную почту'),
            SizedBox(height: 18),
            _FieldLabel('Компания*'),
            SizedBox(height: 8),
            _InputField(hint: 'Введите компанию'),
            SizedBox(height: 18),
            _FieldLabel('Должность*'),
            SizedBox(height: 8),
            _InputField(hint: 'Введите должность'),
            SizedBox(height: 18),
            _FieldLabel('Парковочное место(необязательно)'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Парковочное место',
              trailing: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
              hasTrailingBox: true,
            ),
            SizedBox(height: 26),
            Center(
              child: _SubmitButton(text: 'Запросить пропуск'),
            ),
          ],
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

class _InputField extends StatelessWidget {
  const _InputField({
    required this.hint,
    this.trailing,
    this.hasTrailingBox = false,
  });

  final String hint;
  final Widget? trailing;
  final bool hasTrailingBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 14, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1),
        borderRadius: BorderRadius.circular(12),
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
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: OutlinedButton(
        onPressed: () {},
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
