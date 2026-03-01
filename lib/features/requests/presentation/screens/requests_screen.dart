import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_comment_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_dropdown_menu.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_field_label.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_input_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_submit_button.dart';
import 'package:wordpice/features/requests/presentation/widgets/modals/request_confirmation_modal.dart';
import 'package:wordpice/features/requests/presentation/widgets/styles/request_form_styles.dart';

const _kScreenPadding = EdgeInsets.fromLTRB(36, 16, 36, 24);
const _kSectionGap = SizedBox(height: 18);
const _kLabelGap = SizedBox(height: 8);

enum _RequestMenu { requestType, time, roomType, cabinet }

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  static const int _tabIndex = 1;
  static const double _contentWidth = 360;
  static const List<String> _requestTypes = ['Клининг', 'Техобслуживание'];
  static const List<String> _roomTypes = [
    'Переговорная комната',
    'Офис',
    'Комната коворкинга',
  ];
  static const List<String> _cabinetOptions = [
    'Кабинет №1',
    'Кабинет №2',
    'Кабинет №3',
  ];

  int _selectedBottomIndex = _tabIndex;
  DateTime? _selectedDate;
  String? _selectedRequestType;
  String? _selectedTime;
  String? _selectedRoomType;
  String? _selectedCabinet;
  _RequestMenu? _openMenu;

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 5),
      locale: const Locale('ru', 'RU'),
    );
    if (picked == null) return;
    setState(() => _selectedDate = picked);
  }

  List<String> get _timeSlots => List<String>.generate(12, (index) {
    final start = 9 + index;
    final end = start + 1;
    final startText = start.toString().padLeft(2, '0');
    final endText = end.toString().padLeft(2, '0');
    return '$startText:00 - $endText:00';
  });

  String get _dateText {
    final value = _selectedDate;
    if (value == null) return 'Выберите дату';
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day.$month.${value.year}';
  }

  String get _timeText => _selectedTime ?? 'Выберите желаемое время';
  String get _requestTypeText => _selectedRequestType ?? 'Выберите тип заявки';
  String get _roomTypeText => _selectedRoomType ?? 'Выберите помещение';
  String get _cabinetText => _selectedCabinet ?? 'Выберите номер кабинета';

  bool get _isRequestTypeMenuOpen => _openMenu == _RequestMenu.requestType;
  bool get _isTimeMenuOpen => _openMenu == _RequestMenu.time;
  bool get _isRoomTypeMenuOpen => _openMenu == _RequestMenu.roomType;
  bool get _isCabinetMenuOpen => _openMenu == _RequestMenu.cabinet;

  void _toggleMenu(_RequestMenu menu) {
    setState(() {
      _openMenu = _openMenu == menu ? null : menu;
    });
  }

  void _selectRequestType(String type) {
    setState(() {
      _selectedRequestType = type;
      _openMenu = null;
    });
  }

  void _selectTime(String slot) {
    setState(() {
      _selectedTime = slot;
      _openMenu = null;
    });
  }

  void _selectRoomType(String type) {
    setState(() {
      _selectedRoomType = type;
      _openMenu = null;
    });
  }

  void _selectCabinet(String cabinet) {
    setState(() {
      _selectedCabinet = cabinet;
      _openMenu = null;
    });
  }

  bool get _canCreateRequest =>
      _selectedDate != null &&
      _selectedRequestType != null &&
      _selectedTime != null &&
      _selectedRoomType != null &&
      _selectedCabinet != null;

  Future<void> _showCreateRequestModal() {
    final selectedDate = _selectedDate!;
    final day = selectedDate.day.toString().padLeft(2, '0');
    final month = selectedDate.month.toString().padLeft(2, '0');

    return RequestConfirmationModal.show(
      context,
      date: '$day.$month.${selectedDate.year}',
      time: _selectedTime!,
      requestType: _selectedRequestType!,
      roomType: _selectedRoomType!,
      cabinet: _selectedCabinet!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        padding: _kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Заявки', style: RequestFormStyles.title),
            _RequestDateSection(dateText: _dateText, onTap: _pickDate),
            _RequestDropdownSection(
              label: 'Тип заявки*',
              value: _requestTypeText,
              isOpen: _isRequestTypeMenuOpen,
              onTap: () => _toggleMenu(_RequestMenu.requestType),
              items: _requestTypes,
              onSelect: _selectRequestType,
              menuHeight: 74,
            ),
            _RequestDropdownSection(
              label: 'Время*',
              value: _timeText,
              isOpen: _isTimeMenuOpen,
              onTap: () => _toggleMenu(_RequestMenu.time),
              items: _timeSlots,
              onSelect: _selectTime,
              menuHeight: 86,
            ),
            _RequestDropdownSection(
              label: 'Тип помещения*',
              value: _roomTypeText,
              isOpen: _isRoomTypeMenuOpen,
              onTap: () => _toggleMenu(_RequestMenu.roomType),
              items: _roomTypes,
              onSelect: _selectRoomType,
              menuHeight: 108,
            ),
            _RequestDropdownSection(
              label: 'Кабинет №*',
              value: _cabinetText,
              isOpen: _isCabinetMenuOpen,
              onTap: () => _toggleMenu(_RequestMenu.cabinet),
              items: _cabinetOptions,
              onSelect: _selectCabinet,
              menuHeight: 108,
            ),
            const _RequestCommentSection(),
            const SizedBox(height: 20),
            Center(
              child: RequestFormSubmitButton(
                text: 'Создать заявку',
                onPressed: _canCreateRequest ? _showCreateRequestModal : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestDateSection extends StatelessWidget {
  const _RequestDateSection({required this.dateText, required this.onTap});

  final String dateText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kSectionGap,
        const RequestFormFieldLabel('Дата*'),
        _kLabelGap,
        RequestFormInputField(
          hint: dateText,
          trailing: SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
          onTap: onTap,
          showTrailingFrame: false,
        ),
      ],
    );
  }
}

class _RequestDropdownSection extends StatelessWidget {
  const _RequestDropdownSection({
    required this.label,
    required this.value,
    required this.isOpen,
    required this.onTap,
    required this.items,
    required this.onSelect,
    required this.menuHeight,
  });

  final String label;
  final String value;
  final bool isOpen;
  final VoidCallback onTap;
  final List<String> items;
  final ValueChanged<String> onSelect;
  final double menuHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kSectionGap,
        RequestFormFieldLabel(label),
        _kLabelGap,
        RequestFormInputField(
          hint: value,
          trailing: Icon(
            isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: 26,
          ),
          onTap: onTap,
          borderRadius: isOpen
              ? RequestFormStyles.dropdownOpenRadius
              : RequestFormStyles.fieldBorderRadius,
        ),
        if (isOpen)
          RequestFormDropdownMenu(
            items: items,
            onSelect: onSelect,
            height: menuHeight,
          ),
      ],
    );
  }
}

class _RequestCommentSection extends StatelessWidget {
  const _RequestCommentSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kSectionGap,
        RequestFormFieldLabel('Комментарий (необязательно)'),
        _kLabelGap,
        RequestFormCommentField(),
      ],
    );
  }
}
