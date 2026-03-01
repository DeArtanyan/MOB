import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/buttons/favorite_heart_toggle.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/profile_card_decorations.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/profile_card_styles.dart';

class ProfileRentalCardFrame extends StatelessWidget {
  const ProfileRentalCardFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 332),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
        decoration: ProfileCardDecorations.outlinedCard(),
        child: child,
      ),
    );
  }
}

class ProfileRentalCardDateLabel extends StatelessWidget {
  const ProfileRentalCardDateLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(text, style: ProfileCardStyles.caption),
    );
  }
}

class ProfileRentalCardContent extends StatelessWidget {
  const ProfileRentalCardContent({
    super.key,
    required this.title,
    required this.room,
    required this.capacity,
    this.timeText,
    this.favoriteInitiallyFilled = false,
  });

  final String title;
  final String room;
  final String capacity;
  final String? timeText;
  final bool favoriteInitiallyFilled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _RentalThumbnail(),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: timeText == null ? 90 : 112,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: FavoriteHeartToggle(
                    initialFilled: favoriteInitiallyFilled,
                  ),
                ),
                Center(
                  child: _RentalTextColumn(
                    title: title,
                    room: room,
                    capacity: capacity,
                    timeText: timeText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RentalThumbnail extends StatelessWidget {
  const _RentalThumbnail();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        width: 48,
        height: 48,
        decoration: ProfileCardDecorations.outlinedCard(
          color: const Color(0xFFBDBDBD),
        ).copyWith(border: null),
        child: const Icon(Icons.image_outlined, size: 28, color: Colors.white),
      ),
    );
  }
}

class _RentalTextColumn extends StatelessWidget {
  const _RentalTextColumn({
    required this.title,
    required this.room,
    required this.capacity,
    this.timeText,
  });

  final String title;
  final String room;
  final String capacity;
  final String? timeText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: ProfileCardStyles.rentalText),
        const SizedBox(height: 3),
        Text(room, style: ProfileCardStyles.rentalText),
        const SizedBox(height: 3),
        Text(capacity, style: ProfileCardStyles.rentalText),
        if (timeText != null) ...[
          const SizedBox(height: 3),
          Text(timeText!, style: ProfileCardStyles.rentalText),
        ],
      ],
    );
  }
}
