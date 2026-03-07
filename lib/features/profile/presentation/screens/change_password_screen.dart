import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/buttons/app_outlined_icon_button.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/profile/presentation/widgets/sections/change_password_section.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/change_password_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  static const int _tabIndex = 3;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _onBottomChanged(int index) {
    if (index == _tabIndex) {
      Navigator.of(context).pop();
      return;
    }
    AppTabNavigator.goToTab(context, index);
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  void _submit() {}

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _tabIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: ChangePasswordStyles.maxContentWidth,
        padding: ChangePasswordStyles.screenPadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppOutlinedIconButton(
                icon: Icons.arrow_back_ios_new,
                iconSize: 14,
                size: 30,
                radius: 10,
                onPressed: _goBack,
              ),
            ),
            const SizedBox(height: 92),
            ChangePasswordSection(
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              obscurePassword: _obscurePassword,
              obscureConfirmPassword: _obscureConfirmPassword,
              onTogglePasswordVisibility: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              onToggleConfirmPasswordVisibility: () {
                setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                );
              },
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
