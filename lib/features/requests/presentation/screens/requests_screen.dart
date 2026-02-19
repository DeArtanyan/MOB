import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/requests/presentation/widgets/request_confirmation_modal.dart';

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

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

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
      onLogout: _logout,
      onNotifications: () {},
      notificationCount: 0,
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
            const _FieldLabel('Дата*'),
            const SizedBox(height: 8),
            _InputField(
              hint: _dateText,
              trailing: const Icon(Icons.calendar_month_outlined, size: 26),
              onTap: _pickDate,
            ),
            const SizedBox(height: 18),
            const _FieldLabel('Тип заявки*'),
            const SizedBox(height: 8),
            _InputField(
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
              Container(
                transform: Matrix4.translationValues(0, -1, 0),
                height: 74,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: _requestTypes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final type = _requestTypes[index];
                    return InkWell(
                      onTap: () => _selectRequestType(type),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 18),
            const _FieldLabel('Время*'),
            const SizedBox(height: 8),
            _InputField(
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
              Container(
                transform: Matrix4.translationValues(0, -1, 0),
                height: 86,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: _timeSlots.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final slot = _timeSlots[index];
                    return InkWell(
                      onTap: () => _selectTime(slot),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          slot,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 18),
            const _FieldLabel('Тип помещения*'),
            const SizedBox(height: 8),
            _InputField(
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
              Container(
                transform: Matrix4.translationValues(0, -1, 0),
                height: 108,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: _roomTypes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final type = _roomTypes[index];
                    return InkWell(
                      onTap: () => _selectRoomType(type),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 18),
            const _FieldLabel('Кабинет №*'),
            const SizedBox(height: 8),
            _InputField(
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
              Container(
                transform: Matrix4.translationValues(0, -1, 0),
                height: 108,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: _cabinetOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final cabinet = _cabinetOptions[index];
                    return InkWell(
                      onTap: () => _selectCabinet(cabinet),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          cabinet,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 18),
            const _FieldLabel('Комментарий (необязательно)'),
            const SizedBox(height: 8),
            const _CommentField(),
            const SizedBox(height: 20),
            Center(
              child: _SubmitButton(
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18 * 0.9,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.hint,
    required this.trailing,
    this.onTap,
    this.borderRadius,
  });

  final String hint;
  final Widget trailing;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 14, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87, width: 1),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: const TextStyle(fontSize: 33 / 2, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: trailing),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'Введите комментарий',
          contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
