import 'package:flutter/material.dart';

class OfficeRentalPriceFilter extends StatelessWidget {
  const OfficeRentalPriceFilter({
    super.key,
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
