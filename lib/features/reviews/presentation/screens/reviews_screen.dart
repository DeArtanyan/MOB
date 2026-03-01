import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/reviews/data/mock/reviews_mock_data.dart';
import 'package:wordpice/features/reviews/presentation/models/review_item.dart';
import 'package:wordpice/features/reviews/presentation/widgets/forms/reviews_submission_form.dart';
import 'package:wordpice/features/reviews/presentation/widgets/sections/reviews_filter_section.dart';
import 'package:wordpice/features/reviews/presentation/widgets/sections/reviews_list_section.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  static const int _tabIndex = 4;
  static const double _contentWidth = 360;
  static const List<int> _ratingFilters = [0, 5, 4, 3, 2, 1];

  int _selectedBottomIndex = _tabIndex;
  int _selectedFilterIndex = 0;
  int _rating = 0;

  final TextEditingController _reviewController = TextEditingController();
  final PageController _reviewsPageController = PageController(
    viewportFraction: 0.9,
  );

  int get _selectedFilterRating => _ratingFilters[_selectedFilterIndex];

  List<ReviewItem> get _filteredReviews {
    if (_selectedFilterRating == 0) return reviewsMockData;
    return reviewsMockData
        .where((item) => item.rating == _selectedFilterRating)
        .toList();
  }

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  void _changeFilter(int delta) {
    setState(() {
      _selectedFilterIndex =
          (_selectedFilterIndex + delta + _ratingFilters.length) %
          _ratingFilters.length;
    });
    if (_reviewsPageController.hasClients) {
      _reviewsPageController.jumpToPage(0);
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _reviewsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = _filteredReviews;

    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          children: [
            ReviewsFilterSection(
              rating: _selectedFilterRating,
              onPrevious: () => _changeFilter(-1),
              onNext: () => _changeFilter(1),
            ),
            const SizedBox(height: 6),
            ReviewsListSection(
              reviews: reviews,
              controller: _reviewsPageController,
            ),
            ReviewsSubmissionForm(
              rating: _rating,
              onRatingChanged: (value) => setState(() => _rating = value),
              reviewController: _reviewController,
              onSubmit: () {},
            ),
          ],
        ),
      ),
    );
  }
}
