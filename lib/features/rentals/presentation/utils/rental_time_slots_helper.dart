class RentalTimeSlotsHelper {
  RentalTimeSlotsHelper._();

  static List<String> subtractBookedRange({
    required String sourceRange,
    required String bookedRange,
  }) {
    final source = parseRange(sourceRange);
    final booked = parseRange(bookedRange);
    if (source == null || booked == null) return [sourceRange];

    final sourceStart = source.$1;
    final sourceEnd = source.$2;
    final bookedStart = booked.$1;
    final bookedEnd = booked.$2;

    if (bookedStart <= sourceStart && bookedEnd >= sourceEnd) {
      return const [];
    }

    final result = <String>[];
    if (bookedStart > sourceStart) {
      result.add(formatRange(sourceStart, bookedStart));
    }
    if (bookedEnd < sourceEnd) {
      result.add(formatRange(bookedEnd, sourceEnd));
    }
    return result;
  }

  static (int, int)? parseRange(String text) {
    final parts = text.split('-').map((e) => e.trim()).toList();
    if (parts.length != 2) return null;

    int? parseHour(String value) {
      final hh = value.split(':').first.trim();
      return int.tryParse(hh);
    }

    final start = parseHour(parts[0]);
    final end = parseHour(parts[1]);
    if (start == null || end == null || end <= start) return null;
    return (start, end);
  }

  static String formatRange(int startHour, int endHour) {
    String h(int hour) => '${hour.toString().padLeft(2, '0')}:00';
    return '${h(startHour)} - ${h(endHour)}';
  }

  static int rangeStartHour(String text) => parseRange(text)?.$1 ?? 999;
}
