import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/buttons/app_action_menu_button.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/passes/presentation/screens/bc_pass_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/employee_pass_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/guest_pass_screen.dart';
import 'package:wordpice/features/passes/presentation/widgets/styles/pass_form_styles.dart';

class PassesScreen extends StatefulWidget {
  const PassesScreen({super.key});

  @override
  State<PassesScreen> createState() => _PassesScreenState();
}

class _PassesScreenState extends State<PassesScreen> {
  static const int _tabIndex = 2;
  static const double _contentWidth = 320;

  int _selectedBottomIndex = _tabIndex;

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
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        centerVertically: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Пропуск',
                style: PassFormStyles.title,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 42),
            AppActionMenuButton(
              text: 'Пропуск БЦ',
              textStyle: PassFormStyles.actionText,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BcPassScreen()),
              ),
            ),
            const SizedBox(height: 30),
            AppActionMenuButton(
              text: 'Пропуск сотрудника',
              textStyle: PassFormStyles.actionText,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmployeePassScreen()),
              ),
            ),
            const SizedBox(height: 30),
            AppActionMenuButton(
              text: 'Пропуск для гостя',
              textStyle: PassFormStyles.actionText,
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
