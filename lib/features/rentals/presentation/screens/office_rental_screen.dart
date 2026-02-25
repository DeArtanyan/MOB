import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/rentals/data/mock/office_rental_mock_data.dart';
import 'package:wordpice/features/rentals/presentation/widgets/office_rental_card.dart';
import 'package:wordpice/features/rentals/presentation/widgets/office_rental_price_filter.dart';
import 'package:wordpice/features/rentals/presentation/widgets/rental_date_filter.dart';

class OfficeRentalScreen extends StatefulWidget {
  const OfficeRentalScreen({super.key});

  @override
  State<OfficeRentalScreen> createState() => _OfficeRentalScreenState();
}

class _OfficeRentalScreenState extends State<OfficeRentalScreen> {
  static const int _tabIndex = 0;
  int _selectedBottomIndex = _tabIndex;
  DateTime? _selectedDate;

  static const int _minPrice = 10000;
  static const int _maxPrice = 30000;
  double _priceValue = _maxPrice.toDouble();

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

  String get _dateText {
    final now = DateTime.now();
    final value = _selectedDate ?? DateTime(now.year, now.month, now.day);
    if (value == null) return '05 февраля';
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${value.day} ${months[value.month - 1]}';
  }

  String _formatPrice(int price) {
    final text = price.toString();
    if (text.length <= 3) return text;
    return '${text.substring(0, text.length - 3)} ${text.substring(text.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    final maxPerDay = _priceValue.round();
    final filtered = officeRentalMockData.where((e) => e.pricePerHour * 10 <= maxPerDay).toList();

    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RentalDateFilter(
              leftPadding: 10,
              text: _dateText,
              onTap: _pickDate,
            ),
            const SizedBox(height: 10),
            OfficeRentalPriceFilter(
              value: _priceValue,
              min: _minPrice.toDouble(),
              max: _maxPrice.toDouble(),
              minLabel: _formatPrice(_minPrice),
              maxLabel: _formatPrice(_priceValue.round()),
              onChanged: (v) => setState(() => _priceValue = v),
            ),
            const SizedBox(height: 18),
            if (filtered.isEmpty) ...[
              const SizedBox(height: 220),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Нет свободных помещений',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ] else ...[
              for (final item in filtered) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 6),
                  child: Text(
                    item.dateText,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                OfficeRentalCard(item: item),
                const SizedBox(height: 12),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
