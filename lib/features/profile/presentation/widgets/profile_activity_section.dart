import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/data/mock/profile_active_rentals_mock_data.dart';
import 'package:wordpice/features/profile/data/mock/profile_favorite_rentals_mock_data.dart';
import 'package:wordpice/features/profile/data/mock/profile_requests_mock_data.dart';
import 'package:wordpice/features/profile/data/mock/profile_rental_history_mock_data.dart';
import 'package:wordpice/features/profile/presentation/models/profile_activity_filter.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_active_rental_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_favorite_rental_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_request_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_rental_history_card.dart';

class ProfileActivitySection extends StatelessWidget {
  const ProfileActivitySection({
    super.key,
    required this.filter,
  });

  final ProfileActivityFilter filter;

  @override
  Widget build(BuildContext context) {
    switch (filter) {
      case ProfileActivityFilter.activeRentals:
        if (profileActiveRentalsMockData.isEmpty) {
          return const _ActivityEmptyState(text: 'У вас нет активных аренд');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < profileActiveRentalsMockData.length; i++) ...[
              ProfileActiveRentalCard(item: profileActiveRentalsMockData[i]),
              if (i != profileActiveRentalsMockData.length - 1) const SizedBox(height: 30),
            ],
          ],
        );

      case ProfileActivityFilter.favorites:
        if (profileFavoriteRentalsMockData.isEmpty) {
          return const _ActivityEmptyState(text: 'У вас нет избранного');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < profileFavoriteRentalsMockData.length; i++) ...[
              ProfileFavoriteRentalCard(item: profileFavoriteRentalsMockData[i]),
              if (i != profileFavoriteRentalsMockData.length - 1) const SizedBox(height: 30),
            ],
          ],
        );

      case ProfileActivityFilter.rentalHistory:
        if (profileRentalHistoryMockData.isEmpty) {
          return const _ActivityEmptyState(text: 'У вас нет истории аренд');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < profileRentalHistoryMockData.length; i++) ...[
              ProfileRentalHistoryCard(item: profileRentalHistoryMockData[i]),
              if (i != profileRentalHistoryMockData.length - 1) const SizedBox(height: 22),
            ],
          ],
        );

      case ProfileActivityFilter.requests:
        if (profileRequestsMockData.isEmpty) {
          return const _ActivityEmptyState(text: 'У вас нет заявок');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < profileRequestsMockData.length; i++) ...[
              ProfileRequestCard(item: profileRequestsMockData[i]),
              if (i != profileRequestsMockData.length - 1) const SizedBox(height: 22),
            ],
          ],
        );
    }
  }
}

class _ActivityEmptyState extends StatelessWidget {
  const _ActivityEmptyState({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
