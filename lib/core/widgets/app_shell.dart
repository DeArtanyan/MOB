import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_bottom_nav_bar.dart';
import 'package:wordpice/core/widgets/app_header.dart';

/// Единый "каркас" экрана: хедер + контент + подвал.
///
/// Зачем нужен:
/// - чтобы хедер и подвал были одинаковыми на разных экранах
/// - чтобы не дублировать Scaffold/навигацию/отступы
///
/// Важно:
/// - хедер обёрнут в SafeArea(top: true), поэтому он НЕ залезает
///   на статус-бар (время/батарея).
/// - подвал обёрнут в SafeArea(top: false), чтобы не упираться в жесты снизу.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.body,
    required this.selectedBottomIndex,
    required this.onBottomChanged,
    required this.onLogout,
    required this.onNotifications,
    this.notificationCount = 0,
  });

  /// Контент конкретного экрана (без хедера/подвала).
  final Widget body;

  /// Текущая вкладка нижнего меню.
  final int selectedBottomIndex;

  /// Коллбек при выборе вкладки.
  final ValueChanged<int> onBottomChanged;

  /// Нажатие на "Выход".
  final VoidCallback onLogout;

  /// Нажатие на уведомления.
  final VoidCallback onNotifications;

  /// Кол-во уведомлений (0 => бейдж не показываем).
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              onLogout: onLogout,
              onNotifications: onNotifications,
              notificationCount: notificationCount,
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
