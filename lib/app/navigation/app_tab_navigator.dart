import 'package:flutter/material.dart';
import 'package:wordpice/features/parking/presentation/screens/parking_screen.dart';
import 'package:wordpice/features/passes/presentation/screens/passes_screen.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordpice/features/requests/presentation/screens/requests_screen.dart';
import 'package:wordpice/features/rentals/presentation/screens/rentals_screen.dart';

/// Простая навигация между вкладками нижнего меню.
///
/// UI-only: это не бизнес-логика. Backend позже будет "источником истины",
/// а сейчас нам нужно просто переключать экраны.
class AppTabNavigator {
  AppTabNavigator._();

  /// Возвращает нужный экран по индексу вкладки.
  static Widget screenForIndex(int index) {
    switch (index) {
      case 0:
        return const RentalsScreen();
      case 2:
        return const PassesScreen();
      case 3:
        return const ProfileScreen();
      case 1:
        return const RequestsScreen();
      case 5:
        return const ParkingScreen();
      default:
        return const _PlaceholderScreen(title: 'Раздел (UI-only)');
    }
  }

  /// Переход на вкладку с заменой текущего экрана (чтобы не копить стек).
  static void goToTab(BuildContext context, int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screenForIndex(index)),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}
