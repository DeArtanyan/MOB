import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_confirmation_modal.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_form_comment_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_form_dropdown_menu.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_form_field_label.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_form_input_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_form_submit_button.dart';

const _kScreenPadding = EdgeInsets.fromLTRB(36, 16, 36, 24);
const _kTitleStyle = TextStyle(fontSize: 44 / 2, fontWeight: FontWeight.w600);
const _kSectionGap = SizedBox(height: 18);
const _kLabelGap = SizedBox(height: 8);
const _kTopMenuRadius = BorderRadius.only(
  topLeft: Radius.circular(12),
  topRight: Radius.circular(12),
);

enum _RequestMenu { requestType, time, roomType, cabinet }

/// Экран "Заявки" (UI-only).
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  static const int _tabIndex = 1; // Заявки
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
  List<String> get _requestTypes => const ['Клининг', 'Техобслуживание'];
  List<String> get _roomTypes => const [
    'Переговорная комната',
    'Офис',
    'Комната коворкинга',
  ];
  List<String> get _cabinetOptions => const [
    'Кабинет №1',
    'Кабинет №2',
    'Кабинет №3',
  ];

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

  String get _modalDateText {
    final value = _selectedDate;
    if (value == null) return 'Не выбрано';
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day.$month.${value.year}';
  }

  String get _modalTimeText => _selectedTime ?? 'Не выбрано';
  String get _modalRequestTypeText => _selectedRequestType ?? 'Не выбрано';
  String get _modalRoomTypeText => _selectedRoomType ?? 'Не выбрано';
  String get _modalCabinetText => _selectedCabinet ?? 'Не выбрано';
  bool get _canCreateRequest =>
      _selectedDate != null &&
      _selectedRequestType != null &&
      _selectedTime != null &&
      _selectedRoomType != null &&
      _selectedCabinet != null;

  Future<void> _showCreateRequestModal() {
    return RequestConfirmationModal.show(
      context,
      date: _modalDateText,
      time: _modalTimeText,
      requestType: _modalRequestTypeText,
      roomType: _modalRoomTypeText,
      cabinet: _modalCabinetText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: _kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Заявки', style: _kTitleStyle),
            _kSectionGap,
            const RequestFormFieldLabel('Дата*'),
            _kLabelGap,
            RequestFormInputField(
              hint: _dateText,
              trailing: SvgPicture.asset(
                'assets/icons/calendar.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.black87,
                  BlendMode.srcIn,
                ),
              ),
              onTap: _pickDate,
              showTrailingFrame: false,
            ),
            _kSectionGap,
            const RequestFormFieldLabel('Тип заявки*'),
            _kLabelGap,
            RequestFormInputField(
              hint: _requestTypeText,
              trailing: Icon(
                _isRequestTypeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: () => _toggleMenu(_RequestMenu.requestType),
              borderRadius: _isRequestTypeMenuOpen
                  ? _kTopMenuRadius
                  : BorderRadius.circular(12),
            ),
            if (_isRequestTypeMenuOpen)
              RequestFormDropdownMenu(
                items: _requestTypes,
                onSelect: _selectRequestType,
                height: 74,
              ),
            _kSectionGap,
            const RequestFormFieldLabel('Время*'),
            _kLabelGap,
            RequestFormInputField(
              hint: _timeText,
              trailing: Icon(
                _isTimeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: () => _toggleMenu(_RequestMenu.time),
              borderRadius: _isTimeMenuOpen
                  ? _kTopMenuRadius
                  : BorderRadius.circular(12),
            ),
            if (_isTimeMenuOpen)
              RequestFormDropdownMenu(
                items: _timeSlots,
                onSelect: _selectTime,
                height: 86,
              ),
            _kSectionGap,
            const RequestFormFieldLabel('Тип помещения*'),
            _kLabelGap,
            RequestFormInputField(
              hint: _roomTypeText,
              trailing: Icon(
                _isRoomTypeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: () => _toggleMenu(_RequestMenu.roomType),
              borderRadius: _isRoomTypeMenuOpen
                  ? _kTopMenuRadius
                  : BorderRadius.circular(12),
            ),
            if (_isRoomTypeMenuOpen)
              RequestFormDropdownMenu(
                items: _roomTypes,
                onSelect: _selectRoomType,
                height: 108,
              ),
            _kSectionGap,
            const RequestFormFieldLabel('Кабинет №*'),
            _kLabelGap,
            RequestFormInputField(
              hint: _cabinetText,
              trailing: Icon(
                _isCabinetMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: () => _toggleMenu(_RequestMenu.cabinet),
              borderRadius: _isCabinetMenuOpen
                  ? _kTopMenuRadius
                  : BorderRadius.circular(12),
            ),
            if (_isCabinetMenuOpen)
              RequestFormDropdownMenu(
                items: _cabinetOptions,
                onSelect: _selectCabinet,
                height: 108,
              ),
            _kSectionGap,
            const RequestFormFieldLabel('Комментарий (необязательно)'),
            _kLabelGap,
            const RequestFormCommentField(),
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
