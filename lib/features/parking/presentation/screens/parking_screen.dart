import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/buttons/app_action_menu_button.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/parking/presentation/widgets/modals/parking_confirmation_modal.dart';
import 'package:wordpice/features/parking/presentation/widgets/styles/parking_styles.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  static const int _tabIndex = 5;
  static const double _contentWidth = 324;
  static const List<int> _places = <int>[
    21,
    22,
    23,
    24,
    25,
    16,
    17,
    18,
    19,
    20,
    11,
    12,
    13,
    14,
    15,
    6,
    7,
    8,
    9,
    10,
    1,
    2,
    3,
    4,
    5,
  ];

  int _selectedBottomIndex = _tabIndex;
  int? _selectedPlace;

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
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
        centerVertically: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _ParkingHeader(),
            _ParkingPlacesGrid(
              places: _places,
              selectedPlace: _selectedPlace,
              onSelectPlace: _onSelectPlace,
            ),
            const SizedBox(height: 26),
            AppActionMenuButton(
              width: 190,
              height: 48,
              text: 'Забронировать',
              textStyle: ParkingStyles.buttonText,
              onPressed: _selectedPlace == null ? null : _onBookPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ParkingHeader extends StatelessWidget {
  const _ParkingHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Парковочные места',
            style: ParkingStyles.title,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class _ParkingPlacesGrid extends StatelessWidget {
  const _ParkingPlacesGrid({
    required this.places,
    required this.selectedPlace,
    required this.onSelectPlace,
  });

  final List<int> places;
  final int? selectedPlace;
  final ValueChanged<int> onSelectPlace;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: places
          .map(
            (number) => _ParkingPlace(
              number: number,
              selected: selectedPlace == number,
              onTap: () => onSelectPlace(number),
            ),
          )
          .toList(),
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
        decoration: ParkingStyles.placeDecoration(selected: selected),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('№$number', style: ParkingStyles.placeNumber),
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
