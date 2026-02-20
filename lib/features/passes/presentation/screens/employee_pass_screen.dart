import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_confirmation_modal.dart';
import 'package:wordpice/features/passes/presentation/widgets/pass_form_widgets.dart';

/// Экран "Пропуск сотруднику" (UI-only).
class EmployeePassScreen extends StatefulWidget {
  const EmployeePassScreen({super.key});

  @override
  State<EmployeePassScreen> createState() => _EmployeePassScreenState();
}

class _EmployeePassScreenState extends State<EmployeePassScreen> {
  static const int _tabIndex = 2; // Пропуск
  int _selectedBottomIndex = _tabIndex;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  bool _isParkingMenuOpen = false;
  int? _selectedParkingPlace;

  static const List<int> _parkingPlaces = <int>[
    21, 22, 23, 24, 25,
    16, 17, 18, 19, 20,
    11, 12, 13, 14, 15,
    6, 7, 8, 9, 10,
    1, 2, 3, 4, 5,
  ];

  void _onAnyFieldChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onAnyFieldChanged);
    _companyController.addListener(_onAnyFieldChanged);
    _positionController.addListener(_onAnyFieldChanged);
  }

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
                    'Пропуск',
                    style: TextStyle(
                      fontSize: 44 / 2,
                      fontWeight: FontWeight.w600,
                    ),
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
                const SizedBox(
                  width: double.infinity,
                  child: PassFieldLabel('Парковочное место (необязательно)'),
                ),
                const SizedBox(height: 8),
                PassInputField(
                  hint: _selectedParkingPlace == null
                      ? 'Парковочное место'
                      : 'Парковочное место №$_selectedParkingPlace',
                  trailing: Icon(
                    _isParkingMenuOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 26,
                  ),
                  hasTrailingBox: true,
                  onTap: _toggleParkingMenu,
                  borderRadius: _isParkingMenuOpen
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )
                      : BorderRadius.circular(12),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  child: _isParkingMenuOpen
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87, width: 1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            children: _parkingPlaces.map((place) {
                              return InkWell(
                                onTap: () => _selectParkingPlace(place),
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 52,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '№$place',
                                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 2),
                                      SvgPicture.asset(
                                        'assets/icons/nav_parking.svg',
                                        width: 34,
                                        height: 34,
                                        colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox.shrink(),
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

