import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/widgets/buttons/favorite_heart_toggle.dart';
import 'package:wordpice/features/rentals/presentation/models/office_rental_item.dart';
import 'package:wordpice/features/rentals/presentation/utils/rental_time_slots_helper.dart';
import 'package:wordpice/features/rentals/presentation/widgets/modals/office_booking_confirmation_modal.dart';
import 'package:wordpice/features/rentals/presentation/widgets/modals/office_time_picker_modal.dart';
import 'package:wordpice/features/rentals/presentation/widgets/rental_time_slot_chip.dart';
import 'package:wordpice/features/rentals/presentation/widgets/styles/rental_widget_styles.dart';

class OfficeRentalCard extends StatefulWidget {
  const OfficeRentalCard({super.key, required this.item});

  final OfficeRentalItem item;

  @override
  State<OfficeRentalCard> createState() => _OfficeRentalCardState();
}

class _OfficeRentalCardState extends State<OfficeRentalCard> {
  late final List<String> _freeTimeSlots;
  int _slotWindowStart = 0;

  int get _maxWindowStart =>
      (_freeTimeSlots.length - 2).clamp(0, _freeTimeSlots.length);

  @override
  void initState() {
    super.initState();
    _freeTimeSlots = [widget.item.availableTime];
  }

  Future<void> _pickTimeRange() async {
    if (_freeTimeSlots.isEmpty) return;
    await _pickTimeRangeForSlot(_freeTimeSlots.first);
  }

  Future<void> _pickTimeRangeForSlot(String sourceRange) async {
    final picked = await OfficeTimePickerModal.show(
      context,
      availableTime: sourceRange,
    );
    if (picked == null) return;
    if (!mounted) return;

    final confirmed = await OfficeBookingConfirmationModal.show(
      context,
      date: widget.item.dateText,
      timeRange: picked,
      title: widget.item.title,
      room: widget.item.room,
      price: widget.item.price,
    );
    if (!confirmed || !mounted) return;

    setState(() {
      final slotIndex = _freeTimeSlots.indexOf(sourceRange);
      if (slotIndex == -1) return;

      final nextSlots = List<String>.from(_freeTimeSlots);
      nextSlots.removeAt(slotIndex);
      nextSlots.insertAll(
        slotIndex,
        RentalTimeSlotsHelper.subtractBookedRange(
          sourceRange: sourceRange,
          bookedRange: picked,
        ),
      );

      nextSlots.sort(
        (a, b) => RentalTimeSlotsHelper.rangeStartHour(
          a,
        ).compareTo(RentalTimeSlotsHelper.rangeStartHour(b)),
      );

      _freeTimeSlots
        ..clear()
        ..addAll(nextSlots);

      if (_slotWindowStart > _maxWindowStart) {
        _slotWindowStart = _maxWindowStart;
      }
    });
  }

  void _showPreviousSlots() {
    setState(() {
      _slotWindowStart = (_slotWindowStart - 1).clamp(0, _maxWindowStart);
    });
  }

  void _showNextSlots() {
    setState(() {
      _slotWindowStart = (_slotWindowStart + 1).clamp(0, _maxWindowStart);
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final hasFreeTime = _freeTimeSlots.isNotEmpty;
    final hasSingleSlot = _freeTimeSlots.length == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 332),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
            decoration: RentalWidgetStyles.outlinedBox(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: RentalWidgetStyles.outlinedBox(
                      8,
                      color: const Color(0xFFBDBDBD),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const FavoriteHeartToggle(),
                              const SizedBox(height: 6),
                              SvgPicture.asset(
                                'assets/icons/nav_archive.svg',
                                width: 22,
                                height: 22,
                                colorFilter: const ColorFilter.mode(
                                  Colors.black87,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: RentalWidgetStyles.cardText,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.room,
                                style: RentalWidgetStyles.cardText,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Вместимость: ${item.capacity} человек',
                                style: RentalWidgetStyles.cardText,
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
        if (!hasFreeTime)
          Center(
            child: Container(
              width: 286,
              height: 36,
              alignment: Alignment.center,
              decoration: RentalWidgetStyles.outlinedBox(8),
              child: const Text(
                'Свободного времени нет',
                textAlign: TextAlign.center,
                style: RentalWidgetStyles.slotInfoText,
              ),
            ),
          ),
        if (hasSingleSlot) ...[
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _pickTimeRange,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 286,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: RentalWidgetStyles.outlinedBox(8),
                  alignment: Alignment.center,
                  child: Text(
                    'Доступное время с ${_freeTimeSlots.first}',
                    textAlign: TextAlign.center,
                    style: RentalWidgetStyles.slotInfoText,
                  ),
                ),
              ),
            ),
          ),
        ],
        if (hasFreeTime && !hasSingleSlot) ...[
          if (_freeTimeSlots.length <= 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  for (var i = 0; i < _freeTimeSlots.length; i++) ...[
                    Expanded(
                      child: RentalTimeSlotChip(
                        text: _freeTimeSlots[i],
                        onTap: () => _pickTimeRangeForSlot(_freeTimeSlots[i]),
                      ),
                    ),
                    if (i != _freeTimeSlots.length - 1)
                      const SizedBox(width: 10),
                  ],
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _SlotArrowButton(
                    icon: Icons.chevron_left,
                    onTap: _slotWindowStart > 0 ? _showPreviousSlots : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RentalTimeSlotChip(
                      text: _freeTimeSlots[_slotWindowStart],
                      onTap: () => _pickTimeRangeForSlot(
                        _freeTimeSlots[_slotWindowStart],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RentalTimeSlotChip(
                      text: _freeTimeSlots[_slotWindowStart + 1],
                      onTap: () => _pickTimeRangeForSlot(
                        _freeTimeSlots[_slotWindowStart + 1],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _SlotArrowButton(
                    icon: Icons.chevron_right,
                    onTap: _slotWindowStart < _freeTimeSlots.length - 2
                        ? _showNextSlots
                        : null,
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: 10),
        Text('${item.price}р', style: RentalWidgetStyles.priceText),
      ],
    );
  }
}

class _SlotArrowButton extends StatelessWidget {
  const _SlotArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 30,
        height: 30,
        decoration: RentalWidgetStyles.outlinedBox(10),
        child: Icon(
          icon,
          size: 20,
          color: onTap == null ? Colors.black38 : Colors.black87,
        ),
      ),
    );
  }
}
