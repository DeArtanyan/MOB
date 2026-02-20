import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';

class OfficeRentalScreen extends StatefulWidget {
  const OfficeRentalScreen({super.key});

  @override
  State<OfficeRentalScreen> createState() => _OfficeRentalScreenState();
}

class _OfficeRentalScreenState extends State<OfficeRentalScreen> {
  static const int _tabIndex = 0;
  int _selectedBottomIndex = _tabIndex;

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
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _DateChip(text: '05 Февраля'),
                    SizedBox(width: 8),
                    Text('--', style: TextStyle(fontSize: 26 / 2, fontWeight: FontWeight.w400)),
                    SizedBox(width: 8),
                    _DateChip(text: '05 Марта'),
                  ],
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Text('10 000', style: TextStyle(fontSize: 20 * 0.9, fontWeight: FontWeight.w400)),
                      SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 3,
                          child: ColoredBox(color: Color(0xFFCDCDCD)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('30 000', style: TextStyle(fontSize: 20 * 0.9, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const SizedBox(height: 250),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Нет свободных помещений',
                    style: TextStyle(
                      fontSize: 50 / 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 34 / 2, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 22),
        ],
      ),
    );
  }
}

