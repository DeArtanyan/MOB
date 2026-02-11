import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/app_header.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/bottom_nav_carousel.dart';

class RentalsScreen extends StatefulWidget {
  const RentalsScreen({super.key});

  @override
  State<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends State<RentalsScreen> {
  int _selectedBottomIndex = 0;

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (route) => false,
    );
  }

  void _onBottomChanged(int index) {
  setState(() => _selectedBottomIndex = index);

  if (index == 3) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
    return;
  }

  if (index == 1 || index == 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Раздел в разработке')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavCarousel(
        selectedIndex: _selectedBottomIndex,
        onChanged: _onBottomChanged,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onLogout: _logout,
              onNotifications: () {},
              notificationCount: 0,
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Аренды', style: AppTextStyles.title26),
                        const SizedBox(height: 26),
                        _RentalsButton(text: 'Аренда переговорной', onTap: () {}),
                        const SizedBox(height: 18),
                        _RentalsButton(text: 'Аренда офиса', onTap: () {}),
                        const SizedBox(height: 18),
                        _RentalsButton(text: 'Аренда коворкинга', onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RentalsButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _RentalsButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
