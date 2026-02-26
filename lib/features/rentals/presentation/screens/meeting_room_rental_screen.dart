import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/rentals/presentation/utils/rental_date_text_helper.dart';
import 'package:wordpice/features/rentals/presentation/widgets/rental_date_filter.dart';
import 'package:wordpice/features/rentals/presentation/widgets/rental_empty_rooms_message.dart';

class MeetingRoomRentalScreen extends StatefulWidget {
  const MeetingRoomRentalScreen({super.key});

  @override
  State<MeetingRoomRentalScreen> createState() => _MeetingRoomRentalScreenState();
}

class _MeetingRoomRentalScreenState extends State<MeetingRoomRentalScreen> {
  static const int _tabIndex = 0;
  int _selectedBottomIndex = _tabIndex;
  DateTime? _selectedDate;

  void _onBottomChanged(int index) {
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

  String get _dateText => RentalDateTextHelper.formatDayMonth(_selectedDate);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RentalDateFilter(text: _dateText, onTap: _pickDate),
            const SizedBox(height: 260),
            const RentalEmptyRoomsMessage(),
          ],
        ),
      ),
    );
  }
}
