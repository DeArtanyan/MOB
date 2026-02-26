import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/reviews/data/mock/reviews_mock_data.dart';
import 'package:wordpice/features/reviews/presentation/models/review_item.dart';
import 'package:wordpice/features/reviews/presentation/widgets/review_full_text_modal.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  static const int _tabIndex = 4; // Отзывы
  int _selectedBottomIndex = _tabIndex;
  int _rating = 0;
  int _currentReviewIndex = 0;
  final TextEditingController _reviewController = TextEditingController();
  final PageController _reviewsPageController = PageController();

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _reviewsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = reviewsMockData; // позже заменится на API

    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 17, 30, 40),
              child: Row(
                children: [
                  _SquareArrowButton(
                    icon: Icons.chevron_left,
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Все отзывы',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _SquareArrowButton(
                    icon: Icons.chevron_right,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
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
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: PageView.builder(
                        controller: _reviewsPageController,
                        scrollDirection: Axis.vertical,
                        itemCount: reviews.length,
                        onPageChanged: (index) {
                          if (_currentReviewIndex == index) return;
                          setState(() => _currentReviewIndex = index);
                        },
                        itemBuilder: (context, index) => SizedBox(
                          height: 230,
                          child: _ReviewCard(item: reviews[index]),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 46),
            const Text(
              'Оцените наш бизнес центр*',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            _RatingStars(
              rating: _rating,
              onChanged: (value) => setState(() => _rating = value),
            ),
            const SizedBox(height: 34),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ваш отзыв*',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Отзыв',
                  hintStyle: TextStyle(color: Colors.black54),
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
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Отправить',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.item});

  final ReviewItem item;

  bool get _needsReadMore => item.text.length > 140;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 74),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.authorName,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 3),
                    const SizedBox(
                      width: 250,
                      child: Divider(height: 1, thickness: 1, color: Colors.black54),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final filled = index < item.rating;
                            return Icon(
                              Icons.star,
                              size: 20,
                              color: filled ? const Color(0xFFFFFFAA) : const Color(0xFFD0D0D0),
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.dateText,
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, height: 1.45),
              ),
              if (_needsReadMore) ...[
                const SizedBox(height: 1),
                GestureDetector(
                  onTap: () => ReviewFullTextModal.show(context, item),
                  child: const Text(
                    'Читать полностью',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/edit-2.svg',
                width: 25,
                height: 25,
                colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/icons/delete.svg',
                width: 25,
                height: 25,
                colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 0,
          right: 0,
          child: _ReviewAvatar(),
        ),
      ],
    );
  }
}

class _ReviewAvatar extends StatelessWidget {
  const _ReviewAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: ClipOval(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: const Color(0xFFF4F4F4)),
            ),
            Positioned(
              top: 12,
              left: 20,
              right: 20,
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF8A8F99),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              child: Container(
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF8A8F99),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquareArrowButton extends StatelessWidget {
  const _SquareArrowButton({
    required this.icon,
    required this.onTap,
  });

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({
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
              color: isFilled ? const Color(0xFFFFFFAA) : const Color(0xFFD0D0D0),
            ),
          ),
        );
      }),
    );
  }
}
