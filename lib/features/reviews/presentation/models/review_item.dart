class ReviewItem {
  const ReviewItem({
    required this.authorName,
    required this.rating,
    required this.dateText,
    required this.text,
  });

  final String authorName;
  final int rating;
  final String dateText;
  final String text;
}
