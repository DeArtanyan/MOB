import 'package:flutter/material.dart';
import 'package:wordpice/features/reviews/presentation/widgets/reviews_styles.dart';

class RatingStarsInput extends StatelessWidget {
  const RatingStarsInput({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;
        return GestureDetector(
          onTap: () => onChanged(starIndex),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.star,
              size: 32,
              color: isFilled
                  ? ReviewsStyles.starActive
                  : ReviewsStyles.starInactive,
            ),
          ),
        );
      }),
    );
  }
}
