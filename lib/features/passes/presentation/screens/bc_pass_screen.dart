import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/passes/presentation/widgets/forms/pass_form_widgets.dart';
import 'package:wordpice/features/passes/presentation/widgets/forms/pass_parking_selector.dart';
import 'package:wordpice/features/passes/presentation/widgets/modals/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/styles/pass_form_styles.dart';

class BcPassScreen extends StatefulWidget {
  const BcPassScreen({super.key});

  @override
  State<BcPassScreen> createState() => _BcPassScreenState();
}

class _BcPassScreenState extends State<BcPassScreen> {
  static const int _tabIndex = 2;
  static const double _contentWidth = 320;

  final int _selectedBottomIndex = _tabIndex;
  bool _isParkingMenuOpen = false;
  int? _selectedParkingPlace;

  void _onBottomChanged(int index) {
    AppTabNavigator.goToTab(context, index);
  }

  void _toggleParkingMenu() {
    setState(() => _isParkingMenuOpen = !_isParkingMenuOpen);
  }

  void _selectParkingPlace(int place) {
    setState(() {
      _selectedParkingPlace = place;
      _isParkingMenuOpen = false;
    });
  }

  Future<void> _showPurchaseModal() {
    final parking = _selectedParkingPlace == null
        ? 'Парковочное место: нет'
        : 'Парковочное место №$_selectedParkingPlace';

    return PassConfirmationModal.show(context, parking: parking);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        centerVertically: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Пропуск владельца',
                style: PassFormStyles.title,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 18),
            PassParkingSelector(
              selectedParkingPlace: _selectedParkingPlace,
              isOpen: _isParkingMenuOpen,
              onToggle: _toggleParkingMenu,
              onSelect: _selectParkingPlace,
            ),
            const SizedBox(height: 20),
            PassSubmitButton(
              text: 'Купить пропуск',
              onPressed: _showPurchaseModal,
            ),
            const SizedBox(height: 28),
            const PassQrPreview(),
          ],
        ),
      ),
    );
  }
}
