import 'package:flutter/material.dart';
import 'package:wordpice/features/reviews/presentation/widgets/reviews_styles.dart';

class ReviewsFilterBar extends StatelessWidget {
  const ReviewsFilterBar({
    super.key,
    required this.rating,
    required this.onPrevious,
    required this.onNext,
  });

  final int rating;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 17, 30, 40),
      child: Row(
        children: [
          _SquareArrowButton(icon: Icons.chevron_left, onTap: onPrevious),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: rating == 0
                  ? const Text('Все отзывы', style: ReviewsStyles.filterAll)
                  : _FilterStars(rating: rating),
            ),
          ),
          const SizedBox(width: 12),
          _SquareArrowButton(icon: Icons.chevron_right, onTap: onNext),
        ],
      ),
    );
  }
}

class _FilterStars extends StatelessWidget {
  const _FilterStars({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Icon(
            Icons.star,
            size: 30,
            color: isFilled
                ? ReviewsStyles.starActive
                : ReviewsStyles.starInactive,
          ),
        );
      }),
    );
  }
}

class _SquareArrowButton extends StatelessWidget {
  const _SquareArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Colors.black87, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}
