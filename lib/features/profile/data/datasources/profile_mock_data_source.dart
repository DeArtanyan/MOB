import 'package:wordpice/features/profile/data/datasources/profile_data_source.dart';
import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Моковый источник данных.
///
/// Используется до появления backend.
/// В будущем этот класс можно будет удалить/заменить на RemoteDataSource.
class ProfileMockDataSource implements ProfileDataSource {
  @override
  Future<List<RentalHistoryItem>> getRentalHistory() async {
    // Имитируем небольшую задержку, как будто это сетевой запрос.
    await Future<void>.delayed(const Duration(milliseconds: 250));

    // Моковые данные. Никакой бизнес-логики.
    return const <RentalHistoryItem>[];
  }
}
