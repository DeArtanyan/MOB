import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/requests/data/mock/request_booking_mock_data.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_comment_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_dropdown_menu.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_field_label.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_input_field.dart';
import 'package:wordpice/features/requests/presentation/widgets/forms/request_form_submit_button.dart';
import 'package:wordpice/features/requests/presentation/widgets/modals/request_confirmation_modal.dart';
import 'package:wordpice/features/requests/presentation/widgets/styles/request_form_styles.dart';

const _kScreenPadding = EdgeInsets.fromLTRB(24, 16, 24, 24);
const _kSectionGap = SizedBox(height: 18);
const _kLabelGap = SizedBox(height: 8);
const _kFieldsBlockPadding = EdgeInsets.fromLTRB(14, 12, 14, 24);

enum _RequestMenu { booking, time, requestType }

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  static const int _tabIndex = 1;
  static const double _contentWidth = double.infinity;
  static const List<String> _requestTypes = ['Клининг', 'Техобслуживание'];

  int _selectedBottomIndex = _tabIndex;
  DateTime? _selectedDate;
  String? _selectedBooking;
  String? _selectedRequestType;
  String? _selectedTime;
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

  String get _bookingText => _selectedBooking ?? 'Выберите бронирование';
  String get _timeText => _selectedTime ?? 'Выберите желаемое время';
  String get _requestTypeText => _selectedRequestType ?? 'Выберите тип заявки';

  bool get _isBookingMenuOpen => _openMenu == _RequestMenu.booking;
  bool get _isTimeMenuOpen => _openMenu == _RequestMenu.time;
  bool get _isRequestTypeMenuOpen => _openMenu == _RequestMenu.requestType;

  void _toggleMenu(_RequestMenu menu) {
    setState(() {
      _openMenu = _openMenu == menu ? null : menu;
    });
  }

  void _selectBooking(String booking) {
    setState(() {
      _selectedBooking = booking;
      _openMenu = null;
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

  bool get _canCreateRequest =>
      _selectedDate != null &&
      _selectedBooking != null &&
      _selectedRequestType != null &&
      _selectedTime != null;

  Future<void> _showCreateRequestModal() {
    final selectedDate = _selectedDate!;
    final day = selectedDate.day.toString().padLeft(2, '0');
    final month = selectedDate.month.toString().padLeft(2, '0');

    return RequestConfirmationModal.show(
      context,
      date: '$day.$month.${selectedDate.year}',
      time: _selectedTime!,
      requestType: _selectedRequestType!,
      booking: _selectedBooking!,
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
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: _kFieldsBlockPadding,
              decoration: BoxDecoration(
                color: AppColors.formBlockBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RequestDropdownSection(
                    label: 'Список бронирований*',
                    value: _bookingText,
                    isOpen: _isBookingMenuOpen,
                    onTap: () => _toggleMenu(_RequestMenu.booking),
                    items: requestBookingMockData,
                    onSelect: _selectBooking,
                    menuHeight: 108,
                  ),
                  _RequestDateSection(dateText: _dateText, onTap: _pickDate),
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
                    label: 'Тип заявки*',
                    value: _requestTypeText,
                    isOpen: _isRequestTypeMenuOpen,
                    onTap: () => _toggleMenu(_RequestMenu.requestType),
                    items: _requestTypes,
                    onSelect: _selectRequestType,
                    menuHeight: 74,
                  ),
                  const _RequestCommentSection(),
                ],
              ),
            ),
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
