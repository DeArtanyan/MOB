import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';

/// Экран "Заявки" (UI-only).
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  static const int _tabIndex = 1; // Заявки
  int _selectedBottomIndex = _tabIndex;

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
          children: const [
            Text(
              'Заявки',
              style: TextStyle(
                fontSize: 44 / 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 18),
            _FieldLabel('Дата*'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Выберите дату',
              trailing: Icon(Icons.calendar_month_outlined, size: 26),
            ),
            SizedBox(height: 18),
            _FieldLabel('Тип заявки*'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Выберите тип заявки',
              trailing: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
            ),
            SizedBox(height: 18),
            _FieldLabel('Время*'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Выберите желаемое время',
              trailing: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
            ),
            SizedBox(height: 18),
            _FieldLabel('Тип помещения*'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Выберите помещение',
              trailing: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
            ),
            SizedBox(height: 18),
            _FieldLabel('Кабинет №*'),
            SizedBox(height: 8),
            _InputField(
              hint: 'Выберите номер кабинета',
              trailing: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
            ),
            SizedBox(height: 18),
            _FieldLabel('Комментарий (необязательно)'),
            SizedBox(height: 8),
            _CommentField(hint: 'Введите комментарий'),
            SizedBox(height: 20),
            Center(
              child: _SubmitButton(text: 'Создать заявку'),
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
  });

  final String hint;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 14, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1),
        borderRadius: BorderRadius.circular(12),
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
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        hint,
        style: const TextStyle(fontSize: 33 / 2, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 44,
      child: OutlinedButton(
        onPressed: () {},
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
