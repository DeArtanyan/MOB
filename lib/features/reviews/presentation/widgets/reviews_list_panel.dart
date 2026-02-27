import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/reviews/presentation/models/review_item.dart';
import 'package:wordpice/features/reviews/presentation/widgets/review_card.dart';
import 'package:wordpice/features/reviews/presentation/widgets/reviews_styles.dart';

class ReviewsListPanel extends StatelessWidget {
  const ReviewsListPanel({
    super.key,
    required this.reviews,
    required this.controller,
  });

  final List<ReviewItem> reviews;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: reviews.isEmpty
          ? const Center(
              child: Text(
                'Отзывы отсутствуют',
                style: ReviewsStyles.emptyState,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.vertical,
                itemCount: reviews.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 230,
                  child: ReviewCard(item: reviews[index]),
                ),
              ),
            ),
    );
  }
}
