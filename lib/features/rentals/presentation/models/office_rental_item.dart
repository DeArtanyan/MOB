class OfficeRentalItem {
  const OfficeRentalItem({
    required this.dateText,
    required this.title,
    required this.room,
    required this.capacity,
    required this.availableTime,
    required this.price,
  });

  final String dateText;
  final String title;
  final String room;
  final int capacity;
  final String availableTime;
  final int price;
}
