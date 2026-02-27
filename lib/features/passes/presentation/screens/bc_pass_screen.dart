import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_parking_selector.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_form_widgets.dart';

/// Экран "Пропуск БЦ" (UI-only).
class BcPassScreen extends StatefulWidget {
  const BcPassScreen({super.key});

  @override
  State<BcPassScreen> createState() => _BcPassScreenState();
}

class _BcPassScreenState extends State<BcPassScreen> {
  static const int _tabIndex = 2; // Пропуск
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Пропуск владельца',
                    style: TextStyle(
                      fontSize: 44 / 2,
                      fontWeight: FontWeight.w600,
                    ),
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
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code_2, size: 120),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
