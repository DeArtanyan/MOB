import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/reviews/presentation/widgets/forms/rating_stars_input.dart';
import 'package:wordpice/features/reviews/presentation/widgets/styles/reviews_styles.dart';

class ReviewsSubmissionForm extends StatelessWidget {
  const ReviewsSubmissionForm({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    required this.reviewController,
    required this.onSubmit,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;
  final TextEditingController reviewController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 46),
        const Text(
          'Оцените наш бизнес центр*',
          style: ReviewsStyles.sectionTitle,
        ),
        const SizedBox(height: 10),
        RatingStarsInput(rating: rating, onChanged: onRatingChanged),
        const SizedBox(height: 34),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Ваш отзыв*', style: ReviewsStyles.fieldLabel),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: Colors.black87, width: 1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            controller: reviewController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Отзыв',
              hintStyle: ReviewsStyles.inputHint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 150,
          height: 42,
          child: OutlinedButton(
            onPressed: onSubmit,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.formSurface,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Отправить', style: ReviewsStyles.buttonText),
          ),
        ),
      ],
    );
  }
}
