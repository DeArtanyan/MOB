import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_bottom_nav_bar.dart';
import 'package:wordpice/core/widgets/app_header.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    required this.selectedBottomIndex,
  });

  final int selectedBottomIndex;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late int _selectedBottomIndex;

  @override
  void initState() {
    super.initState();
    _selectedBottomIndex = widget.selectedBottomIndex;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              onLogout: _logout,
              onNotifications: () {},
              notificationCount: 0,
              showActions: false,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 22, 32, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: const BorderSide(color: Colors.black87),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.black87),
                          ),
                        ),
                      ),
                      const Text(
                        'Уведомления',
                        style: TextStyle(
                          fontSize: 44 / 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 260),
                  const Center(
                    child: Text(
                      'Уведомлений нет',
                      style: TextStyle(
                        fontSize: 60 / 2,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: AppBottomNavBar(
          selectedIndex: _selectedBottomIndex,
          onChanged: _onBottomChanged,
        ),
      ),
    );
  }
}
