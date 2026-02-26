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
  bool _isRequestTypeMenuOpen = false;
  bool _isTimeMenuOpen = false;
  bool _isRoomTypeMenuOpen = false;
  bool _isCabinetMenuOpen = false;

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

  void _toggleRequestTypeMenu() {
    setState(() {
      _isRequestTypeMenuOpen = !_isRequestTypeMenuOpen;
      if (_isRequestTypeMenuOpen) {
        _isTimeMenuOpen = false;
        _isRoomTypeMenuOpen = false;
        _isCabinetMenuOpen = false;
      }
    });
  }

  void _selectRequestType(String type) {
    setState(() {
      _selectedRequestType = type;
      _isRequestTypeMenuOpen = false;
    });
  }

  void _toggleTimeMenu() {
    setState(() {
      _isTimeMenuOpen = !_isTimeMenuOpen;
      if (_isTimeMenuOpen) {
        _isRequestTypeMenuOpen = false;
        _isRoomTypeMenuOpen = false;
        _isCabinetMenuOpen = false;
      }
    });
  }

  void _selectTime(String slot) {
    setState(() {
      _selectedTime = slot;
      _isTimeMenuOpen = false;
    });
  }

  void _toggleRoomTypeMenu() {
    setState(() {
      _isRoomTypeMenuOpen = !_isRoomTypeMenuOpen;
      if (_isRoomTypeMenuOpen) {
        _isRequestTypeMenuOpen = false;
        _isTimeMenuOpen = false;
        _isCabinetMenuOpen = false;
      }
    });
  }

  void _selectRoomType(String type) {
    setState(() {
      _selectedRoomType = type;
      _isRoomTypeMenuOpen = false;
    });
  }

  void _toggleCabinetMenu() {
    setState(() {
      _isCabinetMenuOpen = !_isCabinetMenuOpen;
      if (_isCabinetMenuOpen) {
        _isRequestTypeMenuOpen = false;
        _isTimeMenuOpen = false;
        _isRoomTypeMenuOpen = false;
      }
    });
  }

  void _selectCabinet(String cabinet) {
    setState(() {
      _selectedCabinet = cabinet;
      _isCabinetMenuOpen = false;
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
        padding: const EdgeInsets.fromLTRB(36, 16, 36, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Заявки',
              style: TextStyle(
                fontSize: 44 / 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Дата*'),
            const SizedBox(height: 8),
            RequestFormInputField(
              hint: _dateText,
              trailing: SvgPicture.asset(
                'assets/icons/calendar.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
              ),
              onTap: _pickDate,
              showTrailingFrame: false,
            ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Тип заявки*'),
            const SizedBox(height: 8),
            RequestFormInputField(
              hint: _requestTypeText,
              trailing: Icon(
                _isRequestTypeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: _toggleRequestTypeMenu,
              borderRadius: _isRequestTypeMenuOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.circular(12),
            ),
            if (_isRequestTypeMenuOpen)
              RequestFormDropdownMenu(
                items: _requestTypes,
                onSelect: _selectRequestType,
                height: 74,
              ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Время*'),
            const SizedBox(height: 8),
            RequestFormInputField(
              hint: _timeText,
              trailing: Icon(
                _isTimeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: _toggleTimeMenu,
              borderRadius: _isTimeMenuOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.circular(12),
            ),
            if (_isTimeMenuOpen)
              RequestFormDropdownMenu(
                items: _timeSlots,
                onSelect: _selectTime,
                height: 86,
              ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Тип помещения*'),
            const SizedBox(height: 8),
            RequestFormInputField(
              hint: _roomTypeText,
              trailing: Icon(
                _isRoomTypeMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: _toggleRoomTypeMenu,
              borderRadius: _isRoomTypeMenuOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.circular(12),
            ),
            if (_isRoomTypeMenuOpen)
              RequestFormDropdownMenu(
                items: _roomTypes,
                onSelect: _selectRoomType,
                height: 108,
              ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Кабинет №*'),
            const SizedBox(height: 8),
            RequestFormInputField(
              hint: _cabinetText,
              trailing: Icon(
                _isCabinetMenuOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 26,
              ),
              onTap: _toggleCabinetMenu,
              borderRadius: _isCabinetMenuOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.circular(12),
            ),
            if (_isCabinetMenuOpen)
              RequestFormDropdownMenu(
                items: _cabinetOptions,
                onSelect: _selectCabinet,
                height: 108,
              ),
            const SizedBox(height: 18),
            const RequestFormFieldLabel('Комментарий (необязательно)'),
            const SizedBox(height: 8),
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
