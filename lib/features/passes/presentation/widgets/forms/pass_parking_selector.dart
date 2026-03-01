import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/features/passes/presentation/widgets/forms/pass_form_widgets.dart';
import 'package:wordpice/features/passes/presentation/widgets/styles/pass_form_styles.dart';

const _kParkingPlaces = <int>[
  21,
  22,
  23,
  24,
  25,
  16,
  17,
  18,
  19,
  20,
  11,
  12,
  13,
  14,
  15,
  6,
  7,
  8,
  9,
  10,
  1,
  2,
  3,
  4,
  5,
];

class PassParkingSelector extends StatelessWidget {
  const PassParkingSelector({
    super.key,
    required this.selectedParkingPlace,
    required this.isOpen,
    required this.onToggle,
    required this.onSelect,
  });

  final int? selectedParkingPlace;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final hint = selectedParkingPlace == null
        ? 'Парковочное место'
        : 'Парковочное место №$selectedParkingPlace';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: PassFieldLabel('Парковочное место (необязательно)'),
        ),
        const SizedBox(height: 8),
        PassInputField(
          hint: hint,
          trailing: Icon(
            isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: 26,
          ),
          hasTrailingBox: true,
          onTap: onToggle,
          borderRadius: isOpen
              ? PassFormStyles.dropdownOpenRadius
              : PassFormStyles.fieldRadius,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          child: isOpen
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: PassFormStyles.outlinedBox(
                    PassFormStyles.dropdownBottomRadius,
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: _kParkingPlaces.map((place) {
                      return InkWell(
                        onTap: () => onSelect(place),
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 52,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '№$place',
                                style: PassFormStyles.parkingNumber,
                              ),
                              const SizedBox(height: 2),
                              SvgPicture.asset(
                                'assets/icons/nav_parking.svg',
                                width: 34,
                                height: 34,
                                colorFilter: const ColorFilter.mode(
                                  Colors.black87,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
