class ArchiveItem {
  const ArchiveItem({
    required this.dateText,
    required this.title,
    required this.room,
    required this.capacity,
    required this.pricePerHour,
  });

  final String dateText;
  final String title;
  final String room;
  final int capacity;
  final int pricePerHour;
}
