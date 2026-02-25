import 'package:wordpice/features/profile/presentation/models/rental_history_item.dart';

const List<RentalHistoryItem> profileRentalHistoryMockData = [
  RentalHistoryItem(
    dateLabel: '5 февраля, 2026',
    title: 'Аренда переговорной',
    room: 'Кабинет №1',
    capacity: 'Вместимость: 10 человек',
    priceLabel: '1000р/час',
    timeSlots: ['09:00 - 13:00'],
  ),
  RentalHistoryItem(
    dateLabel: '6 февраля, 2026',
    title: 'Аренда переговорной',
    room: 'Кабинет №3',
    capacity: 'Вместимость: 8 человек',
    priceLabel: '900р/час',
    timeSlots: ['14:00 - 18:00'],
  ),
];
