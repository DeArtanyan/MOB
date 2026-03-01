import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Интерфейс репозитория профиля.
abstract class ProfileRepository {
  /// Получить историю аренды пользователя.
  Future<List<RentalHistoryItem>> getRentalHistory();
}
