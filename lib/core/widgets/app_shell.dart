import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_bottom_nav_bar.dart';
import 'package:wordpice/core/widgets/app_header.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/notifications/presentation/screens/notifications_screen.dart';

/// Единый каркас экрана: хедер + контент + нижний бар.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.body,
    required this.selectedBottomIndex,
    required this.onBottomChanged,
    this.onLogout,
    this.onNotifications,
    this.notificationCount,
  });

  final Widget body;
  final int selectedBottomIndex;
  final ValueChanged<int> onBottomChanged;

  /// Опционально: переопределить обработчик выхода.
  final VoidCallback? onLogout;

  /// Опционально: переопределить обработчик уведомлений.
  final VoidCallback? onNotifications;

  /// Опционально: переопределить счетчик уведомлений.
  final int? notificationCount;

  void _defaultLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
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
              onLogout: onLogout ?? () => _defaultLogout(context),
              onNotifications: onNotifications ?? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NotificationsScreen(selectedBottomIndex: selectedBottomIndex),
                  ),
                );
              },
              notificationCount: notificationCount ?? 0,
            ),
          ),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: AppBottomNavBar(
          selectedIndex: selectedBottomIndex,
          onChanged: onBottomChanged,
        ),
      ),
    );
  }
}

