class RentalDateTextHelper {
  RentalDateTextHelper._();

  static String formatDayMonth(DateTime? selectedDate) {
    final now = DateTime.now();
    final value = selectedDate ?? DateTime(now.year, now.month, now.day);
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${value.day} ${months[value.month - 1]}';
  }
}
