import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/rentals/presentation/utils/rental_date_text_helper.dart';
import 'package:wordpice/features/rentals/presentation/widgets/sections/rental_empty_results_section.dart';

class MeetingRoomRentalScreen extends StatefulWidget {
  const MeetingRoomRentalScreen({super.key});

  @override
  State<MeetingRoomRentalScreen> createState() =>
      _MeetingRoomRentalScreenState();
}

class _MeetingRoomRentalScreenState extends State<MeetingRoomRentalScreen> {
  static const int _tabIndex = 0;
  static const int _minPrice = 10000;
  static const int _maxPrice = 30000;

  final int _selectedBottomIndex = _tabIndex;
  DateTime? _selectedDate;
  RangeValues _priceRange = RangeValues(
    _minPrice.toDouble(),
    _maxPrice.toDouble(),
  );

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

  String _formatPrice(double price) {
    final text = price.round().toString();
    if (text.length <= 3) return text;
    return '${text.substring(0, text.length - 3)} ${text.substring(text.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: RentalEmptyResultsSection(
          dateText: _dateText,
          onPickDate: _pickDate,
          priceRange: _priceRange,
          minPrice: _minPrice.toDouble(),
          maxPrice: _maxPrice.toDouble(),
          onPriceChanged: (values) => setState(() => _priceRange = values),
          formatPrice: _formatPrice,
        ),
      ),
    );
  }
}
