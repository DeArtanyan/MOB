import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/passes/presentation/widgets/forms/pass_form_widgets.dart';
import 'package:wordpice/features/passes/presentation/widgets/forms/pass_parking_selector.dart';
import 'package:wordpice/features/passes/presentation/widgets/modals/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/styles/pass_form_styles.dart';

class EmployeePassScreen extends StatefulWidget {
  const EmployeePassScreen({super.key});

  @override
  State<EmployeePassScreen> createState() => _EmployeePassScreenState();
}

class _EmployeePassScreenState extends State<EmployeePassScreen> {
  static const int _tabIndex = 2;
  static const double _contentWidth = 320;

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
    final parking = _selectedParkingPlace == null
        ? 'Парковочное место: нет'
        : 'Парковочное место №$_selectedParkingPlace';

    return PassConfirmationModal.show(
      context,
      email: _emailController.text.trim(),
      company: _companyController.text.trim(),
      position: _positionController.text.trim(),
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
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        centerVertically: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _EmployeePassHeader(),
            _EmployeePassFieldsSection(
              emailController: _emailController,
              companyController: _companyController,
              positionController: _positionController,
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
    );
  }
}

class _EmployeePassHeader extends StatelessWidget {
  const _EmployeePassHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Пропуск сотрудника',
            style: PassFormStyles.title,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }
}

class _EmployeePassFieldsSection extends StatelessWidget {
  const _EmployeePassFieldsSection({
    required this.emailController,
    required this.companyController,
    required this.positionController,
  });

  final TextEditingController emailController;
  final TextEditingController companyController;
  final TextEditingController positionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmployeePassField(
          label: 'Эл.почта*',
          hint: 'Введите электронную почту',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        _EmployeePassField(
          label: 'Компания*',
          hint: 'Введите компанию',
          controller: companyController,
        ),
        const SizedBox(height: 18),
        _EmployeePassField(
          label: 'Должность*',
          hint: 'Введите должность',
          controller: positionController,
        ),
      ],
    );
  }
}

class _EmployeePassField extends StatelessWidget {
  const _EmployeePassField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: double.infinity, child: PassFieldLabel(label)),
        const SizedBox(height: 8),
        PassEditableInputField(
          controller: controller,
          hint: hint,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

