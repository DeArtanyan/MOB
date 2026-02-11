import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Источник данных для профиля.
///
/// Позже может быть две реализации:
/// - Remote (HTTP) — данные с backend
/// - Local (cache) — если появится кэш (не сейчас)
///
/// Сейчас делаем только моковую реализацию.
abstract class ProfileDataSource {
  Future<List<RentalHistoryItem>> getRentalHistory();
}
