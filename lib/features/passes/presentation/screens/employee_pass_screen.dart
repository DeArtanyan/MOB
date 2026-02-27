import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_form_widgets.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_parking_selector.dart';

const _kTitleStyle = TextStyle(fontSize: 44 / 2, fontWeight: FontWeight.w600);

/// Экран "Пропуск сотруднику" (UI-only).
class EmployeePassScreen extends StatefulWidget {
  const EmployeePassScreen({super.key});

  @override
  State<EmployeePassScreen> createState() => _EmployeePassScreenState();
}

class _EmployeePassScreenState extends State<EmployeePassScreen> {
  static const int _tabIndex = 2; // Пропуск
  final int _selectedBottomIndex = _tabIndex;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  bool _isParkingMenuOpen = false;
  int? _selectedParkingPlace;

  void _onAnyFieldChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onAnyFieldChanged);
    _companyController.addListener(_onAnyFieldChanged);
    _positionController.addListener(_onAnyFieldChanged);
  }

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
    final email = _emailController.text.trim();
    final company = _companyController.text.trim();
    final position = _positionController.text.trim();
    final parking = _selectedParkingPlace == null
        ? 'Парковочное место: нет'
        : 'Парковочное место №$_selectedParkingPlace';

    return PassConfirmationModal.show(
      context,
      email: email,
      company: company,
      position: position,
      parking: parking,
    );
  }

  bool get _canBuyPass =>
      _emailController.text.trim().isNotEmpty &&
      _companyController.text.trim().isNotEmpty &&
      _positionController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _emailController.removeListener(_onAnyFieldChanged);
    _companyController.removeListener(_onAnyFieldChanged);
    _positionController.removeListener(_onAnyFieldChanged);
    _emailController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    super.dispose();
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
                    'Пропуск сотрудника',
                    style: _kTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: double.infinity,
                  child: PassFieldLabel('Эл.почта*'),
                ),
                const SizedBox(height: 8),
                PassEditableInputField(
                  controller: _emailController,
                  hint: 'Введите электронную почту',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: double.infinity,
                  child: PassFieldLabel('Компания*'),
                ),
                const SizedBox(height: 8),
                PassEditableInputField(
                  controller: _companyController,
                  hint: 'Введите компанию',
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: double.infinity,
                  child: PassFieldLabel('Должность*'),
                ),
                const SizedBox(height: 8),
                PassEditableInputField(
                  controller: _positionController,
                  hint: 'Введите должность',
                ),
                const SizedBox(height: 18),
                PassParkingSelector(
                  selectedParkingPlace: _selectedParkingPlace,
                  isOpen: _isParkingMenuOpen,
                  onToggle: _toggleParkingMenu,
                  onSelect: _selectParkingPlace,
                ),
                const SizedBox(height: 26),
                PassSubmitButton(
                  text: 'Купить пропуск',
                  onPressed: _canBuyPass ? _showPurchaseModal : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
