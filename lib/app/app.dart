import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_theme.dart';
import 'package:wordpice/features/splash/presentation/screens/splash_screen.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordpice/features/rentals/presentation/screens/rentals_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
      routes: {
        '/profile': (_) => const ProfileScreen(),
        '/rentals': (_) => const RentalsScreen(),
      },
    );
  }
}
