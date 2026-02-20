import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/parking/presentation/widgets/parking_confirmation_modal.dart';

/// Экран "Парковка" (UI-only).
class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  static const int _tabIndex = 5; // Парковка
  int _selectedBottomIndex = _tabIndex;
  int? _selectedPlace;

  static const List<int> _places = <int>[
    21, 22, 23, 24, 25,
    16, 17, 18, 19, 20,
    11, 12, 13, 14, 15,
    6, 7, 8, 9, 10,
    1, 2, 3, 4, 5,
  ];

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

  void _onSelectPlace(int place) {
    setState(() => _selectedPlace = place);
  }

  Future<void> _onBookPressed() {
    if (_selectedPlace == null) return Future.value();
    return ParkingConfirmationModal.show(
      context,
      parkingPlace: _selectedPlace!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 324),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Парковочные места',
                    style: TextStyle(
                      fontSize: 38 / 2,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: _places
                      .map(
                        (number) => _ParkingPlace(
                          number: number,
                          selected: _selectedPlace == number,
                          onTap: () => _onSelectPlace(number),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: 190,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _selectedPlace == null ? null : _onBookPressed,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Забронировать',
                      style: TextStyle(
                        fontSize: 28 / 2,
                        fontWeight: FontWeight.w400,
                      ),
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

class _ParkingPlace extends StatelessWidget {
  const _ParkingPlace({
    required this.number,
    required this.selected,
    required this.onTap,
  });

  final int number;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? const Color(0xFFECECEC) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '№$number',
              style: const TextStyle(
                fontSize: 30 / 2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            SvgPicture.asset(
              'assets/icons/nav_parking.svg',
              width: 42,
              height: 42,
              colorFilter: ColorFilter.mode(
                selected ? Colors.black : Colors.black87,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





