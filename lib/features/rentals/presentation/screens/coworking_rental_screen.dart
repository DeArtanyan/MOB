import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';

class CoworkingRentalScreen extends StatefulWidget {
  const CoworkingRentalScreen({super.key});

  @override
  State<CoworkingRentalScreen> createState() => _CoworkingRentalScreenState();
}

class _CoworkingRentalScreenState extends State<CoworkingRentalScreen> {
  static const int _tabIndex = 0;
  int _selectedBottomIndex = _tabIndex;

  void _onBottomChanged(int index) {
    AppTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _DateFilter(),
            SizedBox(height: 260),
            Text(
              'Нет свободных помещений',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateFilter extends StatelessWidget {
  const _DateFilter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '05 февраля',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 8),
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        ),
      ],
    );
  }
}
