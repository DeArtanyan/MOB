import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/rentals/data/mock/office_rental_mock_data.dart';
import 'package:wordpice/features/rentals/presentation/models/office_rental_item.dart';

class OfficeRentalScreen extends StatefulWidget {
  const OfficeRentalScreen({super.key});

  @override
  State<OfficeRentalScreen> createState() => _OfficeRentalScreenState();
}

class _OfficeRentalScreenState extends State<OfficeRentalScreen> {
  static const int _tabIndex = 0;
  int _selectedBottomIndex = _tabIndex;

  static const int _minPrice = 10000;
  static const int _maxPrice = 30000;
  double _priceValue = _maxPrice.toDouble();

  void _onBottomChanged(int index) {
    AppTabNavigator.goToTab(context, index);
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
            const _DateFilter(),
            const SizedBox(height: 10),
            _PriceFilter(
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
                _OfficeRentalCard(item: item),
                const SizedBox(height: 12),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _DateFilter extends StatelessWidget {
  const _DateFilter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '05 февраля',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}

class _PriceFilter extends StatelessWidget {
  const _PriceFilter({
    required this.value,
    required this.min,
    required this.max,
    required this.minLabel,
    required this.maxLabel,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final String minLabel;
  final String maxLabel;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          minLabel,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              activeTrackColor: const Color(0xFFCDCDCD),
              inactiveTrackColor: const Color(0xFFCDCDCD),
              thumbColor: const Color(0xFF8F8F8F),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              min: min,
              max: max,
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
        Text(
          maxLabel,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class _OfficeRentalCard extends StatelessWidget {
  const _OfficeRentalCard({required this.item});

  final OfficeRentalItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 332),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDBDBD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image_outlined, size: 28, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(CupertinoIcons.heart, size: 24),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.room,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Вместимость: ${item.capacity} человек',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 286,
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Доступное время с ${item.availableTime}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${item.pricePerHour}р/час',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
