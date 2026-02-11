class RentalHistoryItem {
  final String dateLabel; // "5 февраля, 2026"
  final String title; // "Аренда переговорной"
  final String room; // "Кабинет №1"
  final String capacity; // "Вместимость: 10 человек"
  final String priceLabel; // "1000р/час"
  final List<String> timeSlots; // ["09:00 - 10:00", "10:00 - 11:00"]

  const RentalHistoryItem({
    required this.dateLabel,
    required this.title,
    required this.room,
    required this.capacity,
    required this.priceLabel,
    required this.timeSlots,
  });
}
