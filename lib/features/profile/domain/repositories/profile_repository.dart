import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Репозиторий профиля — "контракт" между domain и data.
///
/// Важно:
/// - здесь нет UI и нет конкретных HTTP/DB реализаций
/// - позже мы реализуем этот интерфейс через backend
abstract class ProfileRepository {
  /// Получить историю аренды пользователя.
  ///
  /// Сейчас будет моковая реализация в data.
  Future<List<RentalHistoryItem>> getRentalHistory();
}
