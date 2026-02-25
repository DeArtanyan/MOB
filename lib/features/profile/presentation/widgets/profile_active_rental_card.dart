import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/models/rental_history_item.dart';

class ProfileActiveRentalCard extends StatefulWidget {
  const ProfileActiveRentalCard({
    super.key,
    required this.item,
  });

  final RentalHistoryItem item;

  @override
  State<ProfileActiveRentalCard> createState() => _ProfileActiveRentalCardState();
}

class _ProfileActiveRentalCardState extends State<ProfileActiveRentalCard> {
  static const List<String> _actions = [
    'Пригласить',
    'Перенести бронь',
    'Отменить бронь',
  ];

  int _actionIndex = 0;
  late final PageController _actionController;

  @override
  void initState() {
    super.initState();
    _actionController = PageController(
      initialPage: _actionIndex,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _actionController.dispose();
    super.dispose();
  }

  void _showPrevAction() {
    if (_actionIndex <= 0) return;
    _actionController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _showNextAction() {
    if (_actionIndex >= _actions.length - 1) return;
    _actionController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            item.dateLabel,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 332),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border, width: 1),
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
                                item.capacity,
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
        if (item.timeSlots.isNotEmpty) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                for (var i = 0; i < item.timeSlots.length; i++) ...[
                  Expanded(
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item.timeSlots[i],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  if (i != item.timeSlots.length - 1) const SizedBox(width: 10),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            item.priceLabel,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ArrowButton(
              icon: Icons.chevron_left_rounded,
              onPressed: _showPrevAction,
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: PageView.builder(
                  controller: _actionController,
                  onPageChanged: (i) => setState(() => _actionIndex = i),
                  itemCount: _actions.length,
                  itemBuilder: (_, i) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.border, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _actions[i],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            _ArrowButton(
              icon: Icons.chevron_right_rounded,
              onPressed: _showNextAction,
            ),
          ],
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border, width: 1),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
