import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/bc_pass_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/employee_pass_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/guest_pass_screen.dart';

/// Экран "Пропуск" (UI-only).
class PassesScreen extends StatefulWidget {
  const PassesScreen({super.key});

  @override
  State<PassesScreen> createState() => _PassesScreenState();
}

class _PassesScreenState extends State<PassesScreen> {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 96, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 280,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Пропуск',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 42),
            _ActionButton(
              text: 'Пропуск БЦ',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BcPassScreen()),
              ),
            ),
            const SizedBox(height: 30),
            _ActionButton(
              text: 'Пропуск сотрудника',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmployeePassScreen()),
              ),
            ),
            const SizedBox(height: 30),
            _ActionButton(
              text: 'Пропуск для гостя',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GuestPassScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 36 / 2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
